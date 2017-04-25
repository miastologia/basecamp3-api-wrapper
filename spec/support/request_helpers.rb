module RequestHelpers
  include JSONFixtures

  ACCOUNT_ID = '12345'
  ACCESS_TOKEN = '12345'

  def build_uri(path)
    "https://3.basecampapi.com/#{ACCOUNT_ID}#{path}.json"
  end

  def establish_connection
    Basecamp3.connect(ACCOUNT_ID, ACCESS_TOKEN)
  end

  def stub_http_request(method, path, fixture_name = nil, options = {})
    uri = build_uri(path)
    status = options.fetch(:status, 200)
    headers = {
      'Authorization': "Bearer #{ACCESS_TOKEN}",
      'Content-Type': 'application/json'
    }

    body = fixture_name.nil? ? nil : json_string(fixture_name)
    response_body = options.fetch(:response_body, body)

    stub_request(method, uri).with(headers: headers).to_return(status: status, body: response_body)
  end
end