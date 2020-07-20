class Purchase < ApplicationRecord
  # A given user can't have more than one active purchase for the same content
  validates :user_id,
    uniqueness: { scope: :purchase_option_id, conditions: -> { self.active } }

  belongs_to :user
  belongs_to :purchase_option
  has_one :content, through: :purchase_option

  scope :active, -> { where("expiry_date >= ?", DateTime.now) }
  after_initialize :init, unless: :persisted?

  def init
    # Expiry date defaults to 2 days from the purchase.
    self.expiry_date = DateTime.now + 2.days
  end
end
