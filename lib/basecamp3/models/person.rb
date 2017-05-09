# A model for Basecamp's Message Person
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/people.md#people For more information, see the official Basecamp3 API documentation for People}
class Basecamp3::Person < Basecamp3::Model
  attr_accessor :id,
                :name,
                :title,
                :email_address,
                :bio,
                :avatar_url,
                :admin,
                :owner,
                :time_zone,
                :created_at,
                :updated_at

  # Returns a list of all people visible to the current user.
  #
  # @return [Array<Basecamp3::Person>]
  def self.all
    Basecamp3.request.get("/people", {}, Basecamp3::Person)
  end

  # Returns a list of all people who can be pinged.
  #
  # @return [Array<Basecamp3::Person>]
  def self.pingable
    Basecamp3.request.get("/circles/people", {}, Basecamp3::Person)
  end

  # Returns the person.
  #
  # @param [Integer] id the id of the person
  #
  # @return [Basecamp3::Person]
  def self.find(id)
    Basecamp3.request.get("/people/#{id}", {}, Basecamp3::Person)
  end

  # Returns the current user's personal info..
  #
  # @return [Basecamp3::Person]
  def self.me
    Basecamp3.request.get("/my/profile", {}, Basecamp3::Person)
  end
end