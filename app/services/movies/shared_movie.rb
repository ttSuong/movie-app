module Movies
  class SharedMovie
    prepend SimpleCommand
    def initialize(url, current_user)
      @url = url
      @current_user = current_user
    end

    def call
      shared_video
    end


    private
    def shared_video
      video = VideoInfo.new(@url)
      video_params = {
        title: video.title,
        description: video.description,
        url_id: video.video_id,
        url: video.embed_url,
        is_sharing: true,
        shared_by: @current_user.email,
        provider: video.provider,
      }
      current_movie = Movie.find_by(url: video.embed_url)
      if current_movie.present?
        current_movie.update_attributes(video_params)
      else
        current_movie = Movie.create(video_params)
      end
      current_movie
    end
  end
end