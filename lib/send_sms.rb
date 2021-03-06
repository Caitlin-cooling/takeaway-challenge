require 'twilio-ruby'

module SendSMS

  def time
    time = Time.new + 3600
    time.strftime("%k:%M")
  end

  def send_message
    client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
    @time = time

    from = ENV['TWILIO_PHONE_NUMBER']
    to = '+447598190395'
    body = "Thanks! Your order was placed and will be delivered before #{@time}"

    client.api.account.messages.create(
    from: from,
    to: to,
    body: body
    )
  end
end
