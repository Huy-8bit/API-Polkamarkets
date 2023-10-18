class Cache::PortfolioFeedWorker
  include Sidekiq::Worker

  def perform(portfolio_id)
    portfolio = Portfolio.find_by(id: portfolio_id)
    return if portfolio.blank?

    portfolio.feed_events(refresh: true)
  end
end
