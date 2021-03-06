class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :trackable

  include Validation

  has_many :addresses
  has_many :orders

  def full_name
    "#{first_name} #{last_name}"
  end
end
