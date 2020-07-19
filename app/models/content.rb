class Content < ApplicationRecord
  validates :title, presence: true
  validates :plot, presence: true
  validates :content_type, presence: true

  has_many :episodes
  enum content_type: [:movie, :season]

  default_scope { order(created_at: :desc, title: :asc) }
end
