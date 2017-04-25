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

  def self.all
    Basecamp3.request.get("/people", {}, Basecamp3::Person)
  end

  def self.pingable
    Basecamp3.request.get("/circles/people", {}, Basecamp3::Person)
  end

  def self.find(id)
    Basecamp3.request.get("/people/#{id}", {}, Basecamp3::Person)
  end

  def self.me
    Basecamp3.request.get("/my/profile", {}, Basecamp3::Person)
  end
end