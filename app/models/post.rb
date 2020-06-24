class Post < ApplicationRecord
  validates :from_club, numericality: { less_than: 0 }, allow_nil: true
  validates :from_user, numericality: { greater_than: 0 }, allow_nil: true
end
