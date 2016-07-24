class DrinkCategory < ApplicationRecord

  KAMINARI_RECORDS_PER_PAGE = 10

  has_many  :drinks

  validates :name, presence: :true

end



