FactoryBot.define do
  factory :movie do
    id { |number| number }
    title { 'English Songs Playlist' }
    total_liked { 1 }
    total_disliked { 0 }
    shared_by {'test123@gmail.com'}
    description { 'test 12121212' }
    url_id { "test 1234" }
    is_sharing { true }
    provider { "YouTube" }
  end
end