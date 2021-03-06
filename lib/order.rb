require_relative 'send_sms'

class Order

  include SendSMS

  def initialize(menu_items)
    @menu = menu_items
    @items = []
    @total = 0
  end

  def choose(item, quantity)
    fail_message unless @menu.any? { |list| list[item] }
    quantity.times { @items << item }
    @items
  end

  def confirm_order
    send_message
    "You have ordered: #{@items.join(" and ")}. Total due: £#{total}"
  end

  private

  def fail_message
    fail "This item is not on the menu: choose something else"
  end

  def total
    @items.each do |pizza|
      @menu.each do |menu_item|
        @total += menu_item[pizza] unless menu_item[pizza].nil?
      end
    end
    @total
  end
end
