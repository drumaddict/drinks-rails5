class DrinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :drink_category_id, :has_sugar, :has_milk

def has_sugar
  object.drink_category.has_sugar
end
def has_milk
  object.drink_category.has_milk
end

end

