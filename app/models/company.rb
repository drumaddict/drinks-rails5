class Company < ApplicationRecord
  # KAMINARI_RECORDS_PER_PAGE = 10
  # Set default ApplicationPolicy for all models
  # def self.policy_class
  #   'ApplicationPolicy'
  # end


  has_many :users, dependent: :destroy
  validates :name, presence: :true
end
