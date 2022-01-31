class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :friends, class_name: "User", join_table: "user_connections",
  foreign_key: "solicitor_user_id",
  association_foreign_key: "requested_user_id"
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :friends_posts, through: :friends, source: :posts
end
