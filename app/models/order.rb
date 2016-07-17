class Order < ApplicationRecord
  # KAMINARI_RECORDS_PER_PAGE = 10
  # Set default ApplicationPolicy for all models
  # def self.policy_class
  #   'ApplicationPolicy'
  # end

  has_many :line_items, dependent: :destroy

  # accepts_nested_attributes_for :playlists
  #
  accepts_nested_attributes_for :line_items, :reject_if => :all_blank, :allow_destroy => true
  # validates :email, presence: :true
end


