require 'order'

describe Order do
  let(:items) { [{ "Margherita" => 8 }, { "Roasted Vegetable" => 9 }, { "Chorizo" => 12 }] }
  let(:menu) { double(:menu, new: items) }
  let(:order) { Order.new(menu.new) }
  let(:notification) { double(:send_sms, send_message: "Message Sent") }

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

  describe '#place_order' do
    context 'when I have chosen what I want' do
      it 'shows the items ordered, and the total cost' do
        order.choose("Roasted Vegetable")
        order.choose("Chorizo")
        expect(order.confirm_order(notification)).to eq "You have ordered: Roasted Vegetable and Chorizo. Total due: £21"
      end
      it 'shows the item ordered, and the total cost' do
        order.choose("Roasted Vegetable")
        expect(order.confirm_order(notification)).to eq "You have ordered: Roasted Vegetable. Total due: £9"
      end
    end

    before do
      allow(order).to receive(:send_message)
    end
    it 'sends a confirmation message' do
      order.choose("Roasted Vegetable")
      expect(notification).to receive(:send_message)
      order.confirm_order(notification)
    end
  end
end
