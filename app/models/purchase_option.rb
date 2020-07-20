class PurchaseOption < ApplicationRecord
  validates :price, presence: true, numericality: true
  validates :quality, presence: true, uniqueness: { scope: :content_id }

  belongs_to :content

  enum quality: [:HD, :SD]
end
