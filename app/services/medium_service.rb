class MediumService
  attr_accessor :uri, :list

  def get_latest_articles
    response = HTTP.get('https://medium.com/feed/@polkamarkets')

    unless response.status.success?
      raise "MediumService #{response.status} :: #{response.body.to_s}"
    end

    xml = Nokogiri::XML(response.body.to_s)
    xml.search('item').map do |item|
      content = Nokogiri::HTML(item.content)

      {
        url: item.at('link').text,
        title: item.at('title').text,
        description: content.search('p')[1].text,
        image: content.at('img')['src'],
        published_at: DateTime.parse(item.at('pubDate').text)
      }
    end
  end
end
