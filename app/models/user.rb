# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :requested_connections, foreign_key: :solicitor_user_id, class_name: 'UserConnection'
  has_many :following, through: :requested_connections, source: :requested
  has_many :received_connection_requests, foreign_key: :requested_user_id, class_name: 'UserConnection'
  has_many :followers, through: :received_connection_requests, source: :requester
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :friends_posts, through: :friends, source: :posts

  validates :first_name, :last_name, presence: true, on: :create

  def pending_data?
    first_name.blank? || last_name.blank?
  end

  def follows?(candidate)
    requested_connections.collect(&:requested).include?(candidate)
  end

  def follow(candidate)
    requested_connections.build(requested: candidate)
    save
  end

  def unfollow(candidate)
    candidate = requested_connections.find_by(requested: candidate)
    return false if candidate.nil?

    candidate.destroy.destroyed?
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
