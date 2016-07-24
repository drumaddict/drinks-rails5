class User < ApplicationRecord

  has_secure_password
  enum role: [:employee, :manager]

  scope :role, -> (role) { where(role: role) }

  has_many :orders, dependent: :destroy
  belongs_to :company, dependent: :destroy

  validates :name, :email, presence: :true
end
