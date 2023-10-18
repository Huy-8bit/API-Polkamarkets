class NewsApiService
  attr_accessor :service

  def initialize
    @service = News.new(Rails.application.config_for(:news).newsapi_api_key)
  end

  def get_latest_news(category, subcategory)
    articles = service.get_everything(q: "#{category}%20AND%20#{subcategory}",
      language: 'en',
      sortBy: 'relevancy',
      pageSize: 9)

    latest_news = articles.map do |article|
      {
        source: article.name,
        title: article.title,
        description: article.description,
        url: article.url,
        image_url: article.urlToImage
      }
    end

    latest_news
  end
end
