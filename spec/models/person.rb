require 'spec_helper'

describe 'Person Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'person.json'
    @fixtures_collection = 'people.json'

    @id = '12345'

    establish_connection
  end

  it 'returns a list of visible people' do
    stub_http_request(:get, "/people", @fixtures_collection)

    people = Basecamp3::Person.all
    expected_people = json_to_model(@fixtures_collection, Basecamp3::Person)

    expect(people.count).to be(expected_people.count)
    expect(people).to all be_instance_of(Basecamp3::Person)
    expect(people.map{ |p| p.id }).to match_array(expected_people.map{ |p| p.id })
  end

  it 'returns a list of pingable people' do
    stub_http_request(:get, "/circles/people", @fixtures_collection)

    people = Basecamp3::Person.pingable
    expected_people = json_to_model(@fixtures_collection, Basecamp3::Person)

    expect(people.count).to be(expected_people.count)
    expect(people).to all be_instance_of(Basecamp3::Person)
    expect(people.map{ |p| p.id }).to match_array(expected_people.map{ |p| p.id })
  end

  it 'returns a specific person' do
    stub_http_request(:get, "/people/#{@id}", @fixtures_object)

    person = Basecamp3::Person.find(@id)
    expected_person = json_to_model(@fixtures_object, Basecamp3::Person)

    expect(person).to be_instance_of Basecamp3::Person
    expect(person.id).to eq(expected_person.id)
  end

  it 'return the current user\'s personal info' do
    stub_http_request(:get, "/my/profile", @fixtures_object)

    person = Basecamp3::Person.me
    expected_person = json_to_model(@fixtures_object, Basecamp3::Person)

    expect(person).to be_instance_of Basecamp3::Person
    expect(person.id).to eq(expected_person.id)
  end
end