class Settlement < ApplicationRecord
  belongs_to :user
  has_many :groups, dependent: :destroy

  validates :name, presence: true, length: { maximum: 25 }
  validates :amount, presence: true, numericality: { greater_than: 0, only_integer: true }
end
