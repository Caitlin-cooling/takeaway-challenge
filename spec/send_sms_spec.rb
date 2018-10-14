require 'send_sms'

describe SendSMS do
  let(:confirmation) { SendSMS.new }

  describe '#time' do
    it 'tells me the time that my order is due to be delivered' do
      time = Time.new + 3600
      expect(confirmation.time).to eq time.strftime("%k:%M")
    end
  end
end
