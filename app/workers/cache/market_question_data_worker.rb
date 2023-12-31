class Cache::MarketQuestionDataWorker
  include Sidekiq::Worker

  def perform(market_id)
    market = Market.find_by(id: market_id)
    return if market.blank?

    market.question_data(refresh: true)
  end
end
