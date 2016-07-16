class User < ApplicationRecord
  # KAMINARI_RECORDS_PER_PAGE = 10
  # Set default ApplicationPolicy for all models
  # def self.policy_class
  #   'ApplicationPolicy'
  # end

  has_secure_password
  enum role: [:employee, :manager]

  scope :role, -> (role) { where(role: role) }

  has_many :orders, dependent: :destroy
  belongs_to :company, dependent: :destroy

  validates :email, presence: :true
end
