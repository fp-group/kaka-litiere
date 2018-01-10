class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :shipping_addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, :last_name, :phone_number, presence: true

  def fullname
    "#{self.first_name} #{self.last_name}"
  end

  def no_orders_yet?
    orders.empty?
  end
end
