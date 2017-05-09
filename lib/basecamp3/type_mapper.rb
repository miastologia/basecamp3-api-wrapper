# The basecamp type to wrapper type mapper
class Basecamp3::TypeMapper

  # Maps the basecamp model type to wrapper model type.
  #
  # @param [String] basecamp_type the basecamp model name
  #
  # @return [Class, OpenStruct]
  def self.map(basecamp_type)
    case basecamp_type
    when 'Project'
      Basecamp3::Project
    when 'Chat::Transcript'
      Basecamp3::Campfire
    when 'Chat::Lines::Text'
      Basecamp3::CampfireLine
    when 'Comment'
      Basecamp3::Comment
    when 'Document'
      Basecamp3::Document
    when 'Inbox::Forward'
      Basecamp3::Forward
    when 'Inbox'
      Basecamp3::Inbox
    when 'Message::Board'
      Basecamp3::MessageBoard
    when 'Message'
      Basecamp3::Message
    when 'User'
      Basecamp3::Person
    when 'Question::Answer'
      Basecamp3::QuestionAnswer
    when 'Questionnaire'
      Basecamp3::Questionnaire
    when 'Question'
      Basecamp3::Question
    when 'Schedule::Entry'
      Basecamp3::ScheduleEntry
    when 'Schedule'
      Basecamp3::Schedule
    when 'Todolist'
      Basecamp3::TodoList
    when 'Todo'
      Basecamp3::Todo
    when 'Todoset'
      Basecamp3::TodoSet
    when 'Vault'
      Basecamp3::Vault
    else
      OpenStruct
    end
  end
end