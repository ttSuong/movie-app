class User < ApplicationRecord
  has_many :movie_users
  has_many :movies, through: :movie_users
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: URI::MailTo::EMAIL_REGEXP

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def check_status(movie_id)
    user_reaction = movie_users.where(movie_id: movie_id).last
    return 'unset' if user_reaction.blank?
    user_reaction.type_reaction
  end
end
