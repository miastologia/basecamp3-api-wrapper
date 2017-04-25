require 'spec_helper'

describe 'ResponseParser' do
  it 'returns a model for Hash response' do
    response = { id: 1, content: 'test' }
    parsed_response = Basecamp3::ResponseParser.parse(response, Basecamp3::Todo)

    expect(parsed_response).to be_instance_of(Basecamp3::Todo)
    expect(parsed_response.id).to eq(response[:id])
    expect(parsed_response.content).to eq(response[:content])
  end

  it 'returns an array of models for Array response' do
    response = [{ id: 1, content: 'test' }, { id: 2, content: 'todo' }]
    parsed_response = Basecamp3::ResponseParser.parse(response, Basecamp3::Todo)

    expect(parsed_response.count).to be(response.count)
    expect(parsed_response).to all be_instance_of(Basecamp3::Todo)
    expect(parsed_response.map{ |t| t.id }).to match_array(response.map{ |t| t[:id] })
    expect(parsed_response.map{ |t| t.content }).to match_array(response.map{ |t| t[:content] })
  end

  it 'returns nil for NilClass response' do
    response = nil
    parsed_response = Basecamp3::ResponseParser.parse(response, Basecamp3::Todo)

    expect(parsed_response).to be(nil)
  end

  it 'should raise StandardError for unsupported response type' do
    response = OpenStruct.new({ id: 1 })

    expect{ Basecamp3::ResponseParser.parse(response, Basecamp3::Todo) }.to raise_error(StandardError)
  end

  it 'should raise StandardError for unsupported model' do
    response = { id: 1, content: 'test' }

    expect{ Basecamp3::ResponseParser.parse(response, 'NonExistingModel') }.to raise_error(StandardError)
  end
end