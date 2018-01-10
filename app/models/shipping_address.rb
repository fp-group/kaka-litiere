class ShippingAddress < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :nullify

  def full_address
    "#{self.designation} - #{self.country_name}"
  end

  def country_name
    c = ISO3166::Country[country]
    c.translations[I18n.locale.to_s] || c.name
  end
end
