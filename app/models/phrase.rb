class Phrase < ApplicationRecord

    belongs_to :user

    CATEGORIES = [['Actions', 0], ['Time', 1], ['Productivity', 2], ['Apologies', 3], ['Common', 4]]

    validates :translation, :phrase, presence: true
    validates :phrase, uniqueness: true
    validates :category,
              inclusion: {
                  in: %w(Actions Time Productivity Apologies Common),
                  message: "%{value} is not a valid category"
              }
  
    enum category: %w(Actions Time Productivity Apologies Common)
end
