class Basecamp3::Request
  def initialize(access_token, uri)
    @access_token = access_token
    @uri = uri
  end

  def request(method, path, data = nil, model = 'raw')
    uri = build_request_uri(path)
    https = build_https_object(uri)
    request = build_request_object(method, uri)

    request.body = data.to_json unless data.nil?

    get_response(https, request, model)
  end

  def get(path, params = {}, model = 'raw')
    request(:get, "#{path}#{hash_to_get_query(params)}", nil, model)
  end

  def post(path, data = nil, model = 'raw')
    request(:post, path, data, model)
  end

  def put(path, data = nil, model = 'raw')
    request(:put, path, data, model)
  end

  def delete(path, model = 'raw')
    request(:delete, path, nil, model)
  end

  private

  def get_response(https, request, model)
    response = https.request(request)

    code = response.code.to_i
    message = response.message

    raise message if [400, 403, 404, 507].include?(code)

    return true if code == 204

    json = response.body.nil? ? nil : JSON.parse(response.body)

    return json if model == 'raw'

    Basecamp3::ResponseParser.parse(json, model)
  end

  def build_request_uri(path)
    uri = URI.parse("#{@uri}#{path}")
    uri.path += '.json'

    uri
  end

  def build_https_object(uri)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    https
  end

  def build_request_object(method, uri)
    raise "Unsupported http method: #{method.to_s}" unless [:get, :post, :put, :delete].include?(method)

    request = Object.const_get("Net::HTTP::#{method.to_s.capitalize}").new(uri.request_uri)
    request['Authorization'] = "Bearer #{@access_token}"
    request['Content-Type'] = 'application/json'

    request
  end

  def hash_to_get_query(hash)
    if !hash.nil? && !hash.empty?
      "?#{hash.map{ |i, v| "#{i}=#{v}" }.join('&')}"
    else
      ''
    end
  end
end