require 'rails_helper'
RSpec.describe "Share movie", type: :request do
  context 'Reaction success movie' do
    before {
      application = create(:application)
      user = create(:user)
      movie = create(:movie, :total_liked => 0, :total_disliked => 0)
      create(:movie_user, movie: movie, user: user, type_reaction: 'like')
      token = create(:access_token, application: application, resource_owner_id: user.id)
      put "/api/movies/reaction_movie", params: {id: movie.id, type_reaction: 'dislike'}, headers: {
        'Authorization': 'Bearer ' + token.token,
        'Accept': 'application/json'}
    }
    it 'succeeds' do
      expect(response).to be_successful
    end

    it 'reaction dislike increase 1' do
      body_movies = JSON.parse(response.body)
      expect(body_movies['result']['total_disliked']).to eq(1)
    end

    it 'reaction like keep = 0' do
      body_movies = JSON.parse(response.body)
      expect(body_movies['result']['total_liked']).to eq(0)
    end
  end

  context 'Reaction success movie' do
    before {
      application = create(:application)
      user = create(:user)
      movie = create(:movie, :total_liked => 0, :total_disliked => 0)
      create(:movie_user, movie: movie, user: user, type_reaction: 'like')
      token = create(:access_token, application: application, resource_owner_id: user.id)
      put "/api/movies/reaction_movie", params: {id: movie.id, type_reaction: 'unset'}, headers: {
        'Authorization': 'Bearer ' + token.token,
        'Accept': 'application/json'}
    }
    it 'succeeds' do
      expect(response).to be_successful
    end

    it 'reaction dislike keep 0' do
      body_movies = JSON.parse(response.body)
      expect(body_movies['result']['total_disliked']).to eq(0)
    end

    it 'reaction like keep = 0' do
      body_movies = JSON.parse(response.body)
      expect(body_movies['result']['total_liked']).to eq(0)
    end
  end

  context 'Reaction success movie' do
    before {
      application = create(:application)
      user = create(:user)
      movie = create(:movie, :total_liked => 0, :total_disliked => 0)
      create(:movie_user, movie: movie, user: user, type_reaction: 'like')
      token = create(:access_token, application: application, resource_owner_id: user.id)
      put "/api/movies/reaction_movie", params: {id: movie.id, type_reaction: 'like'}, headers: {
        'Authorization': 'Bearer ' + token.token,
        'Accept': 'application/json'}
    }
    it 'succeeds' do
      expect(response).to be_successful
    end

    it 'reaction dislike keep 0' do
      body_movies = JSON.parse(response.body)
      expect(body_movies['result']['total_disliked']).to eq(0)
    end

    it 'reaction like keep = 0' do
      body_movies = JSON.parse(response.body)
      expect(body_movies['result']['total_liked']).to eq(0)
    end
  end

  context 'Reaction success movie' do
    before {
      application = create(:application)
      user = create(:user)
      movie = create(:movie, :total_liked => 3, :total_disliked => 0)
      create(:movie_user, movie: movie, user: user, type_reaction: 'like')
      token = create(:access_token, application: application, resource_owner_id: user.id)
      put "/api/movies/reaction_movie", params: {id: movie.id, type_reaction: 'dislike'}, headers: {
        'Authorization': 'Bearer ' + token.token,
        'Accept': 'application/json'}
    }
    it 'succeeds' do
      expect(response).to be_successful
    end

    it 'reaction like = 2' do
      body_movies = JSON.parse(response.body)
      expect(body_movies['result']['total_liked']).to eq(2)
    end

    it 'reaction like keep = 0' do
      body_movies = JSON.parse(response.body)
      expect(body_movies['result']['total_disliked']).to eq(1)
    end
  end
end