# A class for handling requests
class Basecamp3::Request

  # Initializes the request object.
  #
  # @param [String] access_token the data to send in the request
  # @param [String] uri
  def initialize(access_token, uri)
    @access_token = access_token
    @uri = uri
  end

  # Sends the request.
  #
  # @param [Symbol] method the symbol of the http method
  # @param [String] path the request path
  # @param [Hash] data the request body
  # @param [String] model the name of the model
  #
  # @return [Basecamp3::Model, OpenStruct]
  def request(method, path, data = nil, model = 'raw')
    uri = build_request_uri(path)
    https = build_https_object(uri)
    request = build_request_object(method, uri)

    request.body = data.to_json unless data.nil?

    get_response(https, request, model)
  end

  # Sends the get request.
  #
  # @param [String] path the request path
  # @param [Hash] params the get params
  # @param [String] model the name of the model
  #
  # @return [Basecamp3::Model, OpenStruct]
  def get(path, params = {}, model = 'raw')
    request(:get, "#{path}#{hash_to_get_query(params)}", nil, model)
  end

  # Sends the post request.
  #
  # @param [String] path the request path
  # @param [Hash] data the request body
  # @param [String] model the name of the model
  #
  # @return [Basecamp3::Model, OpenStruct]
  def post(path, data = nil, model = 'raw')
    request(:post, path, data, model)
  end

  # Sends the put request.
  #
  # @param [String] path the request path
  # @param [Hash] data the request body
  # @param [String] model the name of the model
  #
  # @return [Basecamp3::Model, OpenStruct]
  def put(path, data = nil, model = 'raw')
    request(:put, path, data, model)
  end

  # Sends the delete request.
  #
  # @param [String] path the request path
  # @param [String] model the name of the model
  #
  # @return [Basecamp3::Model, OpenStruct]
  def delete(path, model = 'raw')
    request(:delete, path, nil, model)
  end

  private

  # Returns the response.
  #
  # @private
  #
  # @param [Net:HTTP] https the http object
  # @param [Net::HTTP::Get, Net::HTTP::Post, Net::HTTP::Put, Net::HTTP::Delete] request the request object
  # @param [Class] model the class of the model
  #
  # @return [Basecamp3::Model, OpenStruct]
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

  # Builds the request uri.
  #
  # @private
  #
  # @param [String] path the path of the request
  #
  # @return [String]
  def build_request_uri(path)
    uri = URI.parse("#{@uri}#{path}")
    uri.path += '.json'

    uri
  end

  # Builds the https object.
  #
  # @private
  #
  # @param [String] uri the request uri
  #
  # @return [Net::HTTP]
  def build_https_object(uri)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    https
  end

  # Builds the request object.
  #
  # @private
  #
  # @param [Symbol] method the symbol of the http method
  # @param [String] uri the request uri
  #
  # @return [Net::HTTP::Get, Net::HTTP::Post, Net::HTTP::Put, Net::HTTP::Delete]
  # @raise [StandardError] raises an error for unsupported http method
  def build_request_object(method, uri)
    raise "Unsupported http method: #{method.to_s}" unless [:get, :post, :put, :delete].include?(method)

    request = Object.const_get("Net::HTTP::#{method.to_s.capitalize}").new(uri.request_uri)
    request['Authorization'] = "Bearer #{@access_token}"
    request['Content-Type'] = 'application/json'

    request
  end

  # Builds get query string from the given hash.
  #
  # @private
  #
  # @param [Hash] hash
  #
  # @return [String]
  def hash_to_get_query(hash)
    if !hash.nil? && !hash.empty?
      "?#{hash.map{ |i, v| "#{i}=#{v}" }.join('&')}"
    else
      ''
    end
  end
end