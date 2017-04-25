$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'basecamp3'
require 'webmock/rspec'

require 'support/json_fixtures'
require 'support/request_helpers'

require 'request'
require 'response_parser'

require 'models/todo_list'
require 'models/todo_set'
require 'models/todo'
require 'models/person'
require 'models/project'
require 'models/comment'
require 'models/vault'
require 'models/campfire'
require 'models/campfire_line'
require 'models/message_board'
require 'models/message'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|

end