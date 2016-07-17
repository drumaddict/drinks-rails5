class LineItem < ApplicationRecord
  # KAMINARI_RECORDS_PER_PAGE = 10
  # Set default ApplicationPolicy for all models
  # def self.policy_class
  #   'ApplicationPolicy'
  # end

  belongs_to :order
  belongs_to :drink

  accepts_nested_attributes_for :drink

  validates :email, presence: :true
end


