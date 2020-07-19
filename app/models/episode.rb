class Episode < ApplicationRecord
  validates :number, uniqueness: { scope: :content_id }, presence: true

  belongs_to :content

  default_scope { order(content_id: :asc, number: :asc) }
end
