# A model for Basecamp's Project (Basecamp)
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/basecamps.md#basecamps For more information, see the official Basecamp3 API documentation for Basecamps}
class Basecamp3::Project < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :name,
                :description,
                :bookmarked

  REQUIRED_FIELDS = %w(name)

  # Returns a paginated list of active projects (basecamps) visible to the current user sorted by most recently
  # created project (basecamp) first.
  #
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  # @option params [String] :status (optional) when set to archived or trashed,
  # will return archived or trashed projects (basecamps) visible to the current user
  #
  # @return [Array<Basecamp3::Project>]
  def self.all(params = {})
    Basecamp3.request.get("/projects", params, Basecamp3::Project)
  end

  # Returns the project (basecamp).
  #
  # @param [Integer] id the id of the project
  #
  # @return [Basecamp3::Project]
  def self.find(id)
    Basecamp3.request.get("/projects/#{id}", {}, Basecamp3::Project)
  end

  # Creates a project.
  #
  # @param [Hash] data the data to create a project with
  # @option params [String] :name (required) the name of the project
  # @option params [String] :description (optional) the description of the project
  #
  # @return [Basecamp3::Project]
  def self.create(data)
    self.validate_required(data)
    Basecamp3.request.post("/projects", data, Basecamp3::Project)
  end

  # Updates the project.
  #
  # @param [Integer] id the id of the project
  # @param [Hash] data the data to update the project with
  # @option params [String] :name (required) the name of the project
  # @option params [String] :description (optional) the description of the project
  #
  # @return [Basecamp3::Project]
  def self.update(id, data)
    self.validate_required(data)
    Basecamp3.request.put("/projects/#{id}", data, Basecamp3::Project)
  end

  # Deletes the project.
  #
  # @param [Integer] id the id of the project
  #
  # @return [Boolean]
  def self.delete(id)
    Basecamp3.request.delete("/projects/#{id}")
  end
end