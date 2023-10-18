class Discord::Bot
  attr_accessor :bot

  # checks if discord is configured
  def self.configured?
    Rails.application.config_for(:discord).bot_token.present?
  end

  def initialize
    @bot = Discordrb::Bot.new(token: Rails.application.config_for(:discord).bot_token)
  end

  def send_message_to_channel(channel, message)
    @bot.send_message(channel, message)
  end
end
