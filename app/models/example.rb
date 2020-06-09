class Example < ApplicationRecord
    include SharedMethods
    validates :example, presence: true
    belongs_to :phrase
    belongs_to :user
    acts_as_votable
end
