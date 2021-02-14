# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :message, presence: true
  scope :search, lambda { |term|
    where('LOWER(message) LIKE ?', "%#{term.downcase}%")
  }
end
