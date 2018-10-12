class Order

  attr_reader :items

  def initialize(menu)
    @menu = menu
    @items = []
  end

  def choose(item)
    fail_message unless @menu.any? { |list| list[item] }
    @items << item
  end

  def total
    total = 0
    @items.each do |pizza|
      @menu.each do |menu_item|
        total += menu_item[pizza] unless menu_item[pizza].nil?
      end
    end
    "Total due: £#{total}"
  end

  private

  def fail_message
    fail "This item is not on the menu: choose something else"
  end
end
