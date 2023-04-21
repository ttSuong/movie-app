class MovieUser < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  enum type_reaction: {
    like: 'like',
    dislike: 'dislike'
  }
end
