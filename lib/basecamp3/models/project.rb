class Basecamp3::Project < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :name,
                :description,
                :bookmarked

  REQUIRED_FIELDS = %w(name)

  ##
  # Optional query parameters:
  #
  # status    - when set to archived or trashed, will return archived or trashed Basecamps visible to the current user.
  # page      - to paginate results
  #
  def self.all(params = {})
    Basecamp3.request.get("/projects", params, Basecamp3::Project)
  end

  def self.find(id)
    Basecamp3.request.get("/projects/#{id}", {}, Basecamp3::Project)
  end

  def self.create(data)
    self.validate_required(data)
    Basecamp3.request.post("/projects", data, Basecamp3::Project)
  end

  def self.update(id, data)
    self.validate_required(data)
    Basecamp3.request.put("/projects/#{id}", data, Basecamp3::Project)
  end

  def self.delete(id)
    Basecamp3.request.delete("/projects/#{id}")
  end
end