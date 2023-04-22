FactoryBot.define do
  factory :movie_user do
    user
    movie
    type_reaction { 'like' }
  end
end