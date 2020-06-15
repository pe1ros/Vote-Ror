class User < ApplicationRecord

  include PublicActivity::Model

  extend FriendlyId
  friendly_id :username, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :phrases
  has_many :examples
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :username, presence: true
  validates :username, uniqueness: true

  #validates :last_name, presence: true
  #validates :age, presence: true
  #validates :developer, presence: true

  def has_new_notifications?
    PublicActivity::Activity.where(recipient_id: self.id, readed: false).any?
  end
  
end
