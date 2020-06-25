class Post < ApplicationRecord
  validates :from_club, numericality: { less_than: 0 }, allow_nil: true
  validates :from_user, numericality: { greater_than: 0 }, allow_nil: true

  has_and_belongs_to_many :mashups
end
