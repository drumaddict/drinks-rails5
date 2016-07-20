class LineItem < ApplicationRecord
  # KAMINARI_RECORDS_PER_PAGE = 10
  # Set default ApplicationPolicy for all models
  # def self.policy_class
  #   'ApplicationPolicy'
  # end
  validates_numericality_of :quantity , greater_than: 0,  presence:  true
  MILK_SPOONS = [:no_milk, :half_a_tablespoon, :one_tablespoon, :one_and_half_tablespoon, :two_tablespoons, :two_and_half_tablespoons]

  SUGAR_SPOONS = [:no_sugar, :half_a_teaspoon, :one_teaspoon, :one_and_half_teaspoon, :two_teaspoons, :two_and_half_teaspoons]


  enum milk: MILK_SPOONS
  enum sugar: SUGAR_SPOONS

  belongs_to :order
  belongs_to :drink
  belongs_to :drink_category

  accepts_nested_attributes_for :drink

  # validates :email, presence: :true
  #
end




