class Example < ApplicationRecord
    include SharedMethods
    include PublicActivity::Model

    extend FriendlyId
    friendly_id :example, use: :slugged
    
    validates :example, presence: true
    validates_uniqueness_of :example, scope: :phrase_id, :message=>"has already been used!"
    
    belongs_to :phrase
    belongs_to :user

    acts_as_votable
end
