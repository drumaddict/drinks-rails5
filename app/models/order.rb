class Order < ApplicationRecord
  # KAMINARI_RECORDS_PER_PAGE = 10
  # Set default ApplicationPolicy for all models
  # def self.policy_class
  #   'ApplicationPolicy'
  # end

  has_many :line_items, dependent: :destroy
belongs_to :user

  enum status: [:in_progress, :complete, :cancelled]
  scope :status, -> (status) { where(status: status) }

   scope :favorite, -> { where(:favorite => true) }
  scope  :reoccuring, -> { where(:reoccuring => true) }
  scope :by_company, -> company_id { joins(:user).where("users.company_id = ? ", company_id) }


  accepts_nested_attributes_for :line_items, :allow_destroy => true
  # accepts_nested_attributes_for :line_items, :reject_if => :all_blank, :allow_destroy => true
  validates :line_items, presence: :true
  def description
    return []  if  self.new_record? || !self.valid?
    line_items.inject([]) do |memo, item|
      item_description  = "#{item.drink_category.name}: #{item.drink.name} (#{item.quantity}) "
      item_description += "Sugar: #{item.sugar.humanize}. " if item.drink_category.has_sugar
      item_description += "Milk: #{item.milk.humanize}. " if item.drink_category.has_milk
      memo << item_description
      # memo <<  "#{item.drink.name} (#{item.quantity}), sugar: #{item.sugar.humanize}, milk: #{item.milk.humanize}"
      memo
    end
  end
  def summary


  end
end



