class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_many :likes
  has_many :like_posts, through: :likes, source: :post

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
