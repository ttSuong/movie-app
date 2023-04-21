class Movie < ApplicationRecord
  has_many :movie_users
  has_many :users, through: :movie_users
end
