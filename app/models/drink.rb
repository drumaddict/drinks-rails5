class Drink < ApplicationRecord
  KAMINARI_RECORDS_PER_PAGE = 10

  belongs_to  :drink_category
  has_many  :line_items

  validates :name, presence: :true
end
