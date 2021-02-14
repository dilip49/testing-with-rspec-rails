# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  has_many :projects, dependent: :destroy
  has_many :notes, dependent: :destroy

  def name
    [first_name, last_name].join(' ')
  end
end
