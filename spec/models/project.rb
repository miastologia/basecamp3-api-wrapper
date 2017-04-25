require 'spec_helper'

describe 'Project Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'project.json'
    @fixtures_collection = 'projects.json'

    @id = '12345'

    establish_connection
  end

  it 'returns a list of projects' do
    stub_http_request(:get, "/projects", @fixtures_collection)

    projects = Basecamp3::Project.all
    expected_projects = json_to_model(@fixtures_collection, Basecamp3::Project)

    expect(projects.count).to be(expected_projects.count)
    expect(projects).to all be_instance_of(Basecamp3::Project)
    expect(projects.map{ |t| t.id }).to match_array(expected_projects.map{ |t| t.id })
  end

  it 'returns a specific project' do
    stub_http_request(:get, "/projects/#{@id}", @fixtures_object)

    project = Basecamp3::Project.find(@id)
    expected_project = json_to_model(@fixtures_object, Basecamp3::Project)

    expect(project).to be_instance_of Basecamp3::Project
    expect(project.id).to eq(expected_project.id)
  end

  it 'creates a project' do
    stub_http_request(:post, "/projects", @fixtures_object)

    project = Basecamp3::Project.create({ name: 'test' })

    expect(project).to be_instance_of(Basecamp3::Project)
  end

  it 'should raise StandardError for missing required fields when creates a project' do
    stub_http_request(:post, "/projects", @fixtures_object)

    expect{ Basecamp3::Project.create({ }) }.to raise_error(StandardError)
  end

  it 'updates a project' do
    stub_http_request(:put, "/projects/#{@id}", @fixtures_object)

    project = Basecamp3::Project.update(@id, { name: 'test' })

    expect(project).to be_instance_of(Basecamp3::Project)
  end

  it 'should raise StandardError for missing required fields when updates a project' do
    stub_http_request(:put, "/projects/#{@id}", @fixtures_object)

    expect{ Basecamp3::Project.update(@id, { }) }.to raise_error(StandardError)
  end

  it 'deletes a project' do
    stub_http_request(:delete, "/projects/#{@id}", nil, { status: 204 })

    response = Basecamp3::Project.delete(@id)

    expect(response).to be true
  end
end