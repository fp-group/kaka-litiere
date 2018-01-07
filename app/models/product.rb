class Product < ApplicationRecord
  serialize :features
  has_many :order_details
  has_many :orders, through: :order_details

  validates :designation, :unit_price, presence: true

  # FIXME: put that in a decorator, but draper is broken
  # Need to learn how to build my own :D
  def normalized_designation
    designation.downcase.gsub(" ", "_")
  end
end
