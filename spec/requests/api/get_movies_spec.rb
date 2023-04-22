require 'rails_helper'
RSpec.describe "Get movie", type: :request do
  context 'Included token' do
    before {
      user = create(:user)
      movie = create(:movie)
      create(:movie_user, movie: movie, user: user, type_reaction: 'like')
      application = create(:application)
      token = create(:access_token, application: application, resource_owner_id: user.id)
      get "/api/movies", params: {}, headers: {
        'Authorization': 'Bearer ' + token.token,
        'Accept': 'application/json'}
    }
    it 'succeeds' do
      expect(response).to be_successful
    end

    it 'get successfully' do
      body_movies = JSON.parse(response.body)
      expect(body_movies.count).to eq(1)
    end

    it 'response reaction status' do
      body_movies = JSON.parse(response.body)
      expect(body_movies[0]['status']).to eq('like')
    end
  end


  context 'Without authentication' do
    before {
      create(:movie)
      get "/api/movies", params: {}
    }
    it 'succeeds' do
      expect(response).to be_successful
    end

    it 'get successfully' do
      body_movies = JSON.parse(response.body)
      expect(body_movies.count).to eq(1)
    end

    it 'response reaction status' do
      body_movies = JSON.parse(response.body)
      expect(body_movies[0]['status']).to eq('unset')
    end
  end
end