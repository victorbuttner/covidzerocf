class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :paid, -> { where(payment_status: 'paid') }
end
