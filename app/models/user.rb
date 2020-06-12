class User < ApplicationRecord

  include PublicActivity::Model

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :phrases
  has_many :examples
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :username, uniqueness: true

  def has_new_notifications?
    PublicActivity::Activity.where(recipient_id: self.id, readed: false).any?
  end
  
end
