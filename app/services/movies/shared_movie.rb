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
      byebug
      current_movie =  Movie.find_by(url: @url)
      if current_movie.present?
        current_movie.update_attributes(video_params)
      else
        current_movie = Movie.create(video_params)
      end
      current_movie
    end

    def video_params
      video = VideoInfo.new(@url)
      {
        title: video.title,
        description: video.description,
        url_id: video.video_id,
        url: @url,
        is_sharing: true,
        shared_by: @current_user.email,
        provider: video.provider,
      }
    end

  end
end