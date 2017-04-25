require 'net/https'
require 'json'

require 'basecamp3/version'
require 'basecamp3/request'
require 'basecamp3/response_parser'
require 'basecamp3/model'

require 'basecamp3/models/project'
require 'basecamp3/models/person'
require 'basecamp3/models/todo_set'
require 'basecamp3/models/todo_list'
require 'basecamp3/models/todo'
require 'basecamp3/models/comment'
require 'basecamp3/models/vault'
require 'basecamp3/models/campfire'
require 'basecamp3/models/campfire_line'
require 'basecamp3/models/message_board'

module Basecamp3
  class << self
    HOST = 'https://3.basecampapi.com'

    def connect(account_id, access_token)
      @account_id = account_id
      @access_token = access_token
      @uri = URI.parse("#{HOST}/#{@account_id}")

      @request = Basecamp3::Request.new(@access_token, @uri)
    end

    def request
      @request || raise('You have to call Basecamp.connect method first')
    end
  end
end