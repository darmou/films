require 'rails_helper'
require 'json'

RSpec.describe Api::V1::FilmsController, type: :controller do

  before(:each) do
    json_payload =  { data: {type: "films", attributes: {title:"test", description:"My desc", :"url-slug"=>"test_slug"} }}
    post "/api/v1/films/",  params: json_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/vnd.api+json', 'ACCEPT' => 'application/vnd.api+json' }
    expect(response.status).to eq(201)
  end

  describe "POST #submit_rating", :type => :request  do
    it 'can submit a user rating' do

      id = Film.last.id
      json_payload =  {  user_id: "test", rating: "3.4" }
      post "/api/v1/films/#{id}/submit_rating", params: json_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/vnd.api+json', 'ACCEPT' => 'application/vnd.api+json' }

      expect(response.status).to eq(200)
    end

    it 'can let user know if film does not exist' do
      json_payload =  {   user_id: "test",rating: "3.4" }
      post "/api/v1/films/0/submit_rating", params: json_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/vnd.api+json', 'ACCEPT' => 'application/vnd.api+json' }

      expect(response.status).to eq(404)
    end

    it 'can let user know wrong or missing parameters' do
      id = Film.last.id
      json_payload =  {   rating: "3.4" }
      post "/api/v1/films/#{id}/submit_rating", params: json_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/vnd.api+json', 'ACCEPT' => 'application/vnd.api+json' }

      expect(response.status).to eq(400)
    end

    it 'can do paging' do
      json_payload =  { data: {type: "films", attributes: {title:"test1", description:"My desc1", :"url-slug"=>"test_slug1"} }}
      post "/api/v1/films/",  params: json_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/vnd.api+json', 'ACCEPT' => 'application/vnd.api+json' }
      json_payload =  { data: {type: "films", attributes: {title:"test2", description:"My desc1", :"url-slug"=>"test_slug2"} }}
      post "/api/v1/films/",  params: json_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/vnd.api+json', 'ACCEPT' => 'application/vnd.api+json' }
      json_payload =  { data: {type: "films", attributes: {title:"test3", description:"My desc3", :"url-slug"=>"test_slug3"} }}
      post "/api/v1/films/",  params: json_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/vnd.api+json', 'ACCEPT' => 'application/vnd.api+json' }

      get "/api/v1/films?page%5Bnumber%5D=2&page%5Bsize%5D=2",  headers: { 'CONTENT_TYPE' => 'application/vnd.api+json', 'ACCEPT' => 'application/vnd.api+json' }
      expect(response.body).to include('"last":"http://www.example.com/api/v1/films?page%5Bnumber%5D=2&page%5Bsize%5D=2"')
    end
  end
end