class Drink < ApplicationRecord
  # KAMINARI_RECORDS_PER_PAGE = 10
  # Set default ApplicationPolicy for all models
  # def self.policy_class
  #   'ApplicationPolicy'
  # end

  belongs_to  :drink_category
  has_many  :line_items

  # accepts_nested_attributes_for :playlists
  #

  validates :name, presence: :true
end
