module Api
  class ArticlesController < BaseController
    def index
      articles = Rails.cache.fetch("api:articles", expires_in: 24.hours) do
        MediumService.new.get_latest_articles
      end

      render json: articles, status: :ok
    end
  end
end
