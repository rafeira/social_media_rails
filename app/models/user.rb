class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_connections, foreign_key: :solicitor_user_id
  has_many :following, through: :user_connections, source: :requested
  has_many :followers, through: :user_connections, source: :requester
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :friends_posts, through: :friends, source: :posts

  validates :first_name, :last_name, presence: true, on: :create

  def pending_data?
    first_name.blank? || last_name.blank?
  end

  def follows?(candidate)
    user_connections.collect(&:requested).include?(candidate)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
