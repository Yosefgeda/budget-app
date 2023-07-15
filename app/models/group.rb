class Group < ApplicationRecord
  belongs_to :user
  has_many :settlements, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :icon, presence: true

  def total_transaction_amount
    settlements.sum(:amount)
  end
end
