module Movies
  class ReactionMovie
    prepend SimpleCommand
    def initialize(params, current_user)
      @params = params
      @current_user = current_user
    end

    def call
      return movie if @params[:type_reaction] == 'unset'
      return  movie if @params[:type_reaction] == last_reaction.type_reaction
      raise I18n.t("user.errors.not_found_movie") unless movie.present?
      update_movie
      update_reaction
      movie
    end

    private
    def movie
      @movie ||= Movie.find_by(id: @params[:id])
    end
    def last_reaction
      @last_reaction ||= @current_user.movie_users.where(movie_id: movie.id).last
    end
    def update_movie
      case @params[:type_reaction]
      when MovieUser.type_reactions[:like]
        liked
      when MovieUser.type_reactions[:dislike]
        disliked
      end
    end

    def update_reaction
      if last_reaction.blank?
        MovieUser.create(user_id: @current_user.id, movie_id: movie.id, type_reaction: @params[:type_reaction])
      else
        last_reaction.type_reaction = @params[:type_reaction]
        last_reaction.save
      end
    end

    def liked
      movie.total_liked = movie.total_liked.to_i + 1
      if exist_reaction?
        movie.total_disliked = movie.total_disliked > 0 ? movie.total_disliked -= 1 : 0
      end
      movie.save
    end

    def disliked
      movie.total_disliked = movie.total_disliked.to_i + 1
      if exist_reaction?
        movie.total_liked = movie.total_liked > 0 ? movie.total_liked -= 1 : 0
      end
      movie.save
    end
    def exist_reaction?
      last_reaction.present? && last_reaction.type_reaction != @params[:type_reaction]
    end
  end
end
