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
      memo
    end
  end

  def duplicate
    order_dup = self.dup
    order_dup.favorite =false
    self.line_items.each do |li|
      order_dup.line_items << li.dup
    end
    order_dup
  end

  #Scheduled to run every hour and place reoccuring orders for specified time and day.
  def self.place_reoccuring
    self.reoccuring.each do |reoccuring_order|
      order_days = reoccuring_order.days.map.reject(&:empty?).map(&:to_i) #Delete empty string entry from multiple checkboxes bug.
      order_hour = reoccuring_order.hour
      now = DateTime.current
      if now.hour == order_hour  &&  order_days.include?(now.wday)
        order = reoccuring_order.duplicate
        order.reoccuring = false
        if  order.save
           Rails.logger.info "Order with id #{order.id} has been re-placed.Details: #{order.description} "
        end
      end
    end
  end


end



