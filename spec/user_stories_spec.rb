require 'menu'
require 'order'
require 'confirmation'

# As a customer
# So that I can check if I want to order something
# I would like to see a list of dishes with prices
describe Menu do
  let(:menu) { Menu.new }
  let(:items) { [{ "Margherita" => 8 }, { "Roasted Vegetable" => 9 }, { "Chorizo" => 12 }] }

  it 'should show me a list of dishes with prices' do
    expect(menu.show(items)).to eq items
  end
end

# As a customer
# So that I can order the meal I want
# I would like to be able to select some number of several available dishes
describe Order do
  let(:order) { Order.new(menu.show) }
  let(:menu) { double(:menu, show: [{ "Margherita" => 8 }, { "Roasted Vegetable" => 9 }, { "Chorizo" => 12 }]) }

  describe '#choose' do
    it 'lets me choose the item that I want' do
      expect(order.choose("Margherita")).to eq ["Margherita"]
    end

    it 'should let me choose multiple items from the menu' do
      order.choose("Margherita")
      expect(order.choose("Chorizo")).to eq ["Margherita", "Chorizo"]
    end

    it 'should not allow me to choose items that are not on the menu' do
      expect { order.choose("Toast") }.to raise_exception "This item is not on the menu: choose something else"
    end
  end

  # As a customer
  # So that I can verify that my order is correct
  # I would like to check that the total I have been given matches the sum of the various dishes in my order
  describe '#total' do
    it 'should show me the order total and the item that I have ordered' do
      order.choose("Roasted Vegetable")
      expect(order.total).to eq "Total due: £9"
    end
    it 'should show me the order total and the items that I have ordered' do
      order.choose("Margherita")
      order.choose("Chorizo")
      expect(order.total).to eq "Total due: £20"
    end
  end
end

# As a customer
# So that I am reassured that my order will be delivered on time
# I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered

describe Confirmation do
  let(:confirmation) { Confirmation.new }

  describe '#time' do
    it 'tells me the time that my order was placed' do
      time = Time.new
      expect(confirmation.time). to eq time.strftime("%k:%M")
    end
  end
end
