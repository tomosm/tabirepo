module ArticlesHelper
  FIRST_INDEX = 0
  def paragraph_index(article)
    index = FIRST_INDEX
    if (article.paragraphs)
      index += article.paragraphs.length
    end
    index
  end
end
