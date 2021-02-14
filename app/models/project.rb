# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy

  validates :name, uniqueness: { scope: :user_id }
end
