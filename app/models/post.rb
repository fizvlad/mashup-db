class Post < ApplicationRecord
  validates :from_club, numericality: { less_than: 0 }, allow_nil: true
  validates :from_user, numericality: { greater_than: 0 }, allow_nil: true

  validates :likes, numericality: { greater_than_or_equal_to: 0 }
  validates :reposts, numericality: { greater_than_or_equal_to: 0 }
  validates :views, numericality: { greater_than_or_equal_to: 0 }
  validates :comments, numericality: { greater_than_or_equal_to: 0 }

  has_and_belongs_to_many :mashups
end
