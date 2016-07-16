class LineItem < ApplicationRecord
  # KAMINARI_RECORDS_PER_PAGE = 10
  # Set default ApplicationPolicy for all models
  # def self.policy_class
  #   'ApplicationPolicy'
  # end

  belongs_to :order

  # accepts_nested_attributes_for :playlists

  validates :email, presence: :true
end


