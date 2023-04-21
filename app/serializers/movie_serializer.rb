class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :url, :shared_by, :total_liked, :total_disliked, :status

  def total_liked
    object.total_liked || 0
  end

  def total_disliked
    object.total_disliked || 0
  end

  def status
    current_user.present? ? current_user.check_status(object.id) : 'unset'
  end

  def current_user
    scope
  end
end
