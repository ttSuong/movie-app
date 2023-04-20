json.extract! movie, :id, :title, :url, :total_liked, :total_disliked, :shared_by, :description, :created_at, :updated_at
json.url movie_url(movie, format: :json)
