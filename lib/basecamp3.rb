require 'net/https'
require 'json'

require 'basecamp3/version'
require 'basecamp3/request'
require 'basecamp3/response_parser'
require 'basecamp3/type_mapper'
require 'basecamp3/model'

require 'basecamp3/concerns/creatorable'
require 'basecamp3/concerns/bucketable'
require 'basecamp3/concerns/parentable'
require 'basecamp3/concerns/recordingable'

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
require 'basecamp3/models/message'
require 'basecamp3/models/message_type'
require 'basecamp3/models/document'
require 'basecamp3/models/schedule'
require 'basecamp3/models/schedule_entry'
require 'basecamp3/models/question'
require 'basecamp3/models/question_answer'
require 'basecamp3/models/questionnaire'
require 'basecamp3/models/inbox'
require 'basecamp3/models/forward'

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