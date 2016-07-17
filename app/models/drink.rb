class Drink < ApplicationRecord
  # KAMINARI_RECORDS_PER_PAGE = 10
  # Set default ApplicationPolicy for all models
  # def self.policy_class
  #   'ApplicationPolicy'
  # end

  belongs_to  :drink_category

  # accepts_nested_attributes_for :playlists
  #

  validates :name, presence: :true
end
