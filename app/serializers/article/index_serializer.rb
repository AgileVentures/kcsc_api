class Article::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :date, :image, :published
  belongs_to :author, serializer: Users::Serializer

  def teaser
    object.body.truncate(100)
  end

  def date
    object.created_at.strftime('%Y-%m-%d')
  end

  def image
    url = if Rails.env.test?
            object.image.file
          else
            object.image.file.url(expires_in: 1.hour, disposition: 'inline')
          end
    {
      url: url,
      alt: object.image.alt_text
    }
  end
end
