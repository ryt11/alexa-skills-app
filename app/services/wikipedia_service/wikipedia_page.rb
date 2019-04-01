class WikipediaPage

  attr_reader :page_data

  def initialize(page_data)
    @page_id = page_data.keys.first
    @page_data = page_data[@page_id]
  end

  def content
    page_data['revisions'].first['*']
  end

  def title
    page_data['title']
  end

  def encompassed_data
    {
      title: title,
      content: content
    }
  end
end
