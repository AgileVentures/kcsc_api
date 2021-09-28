class Article::ShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :body, :date, :image, :published
  belongs_to :author, serializer: Users::Serializer

  def date
    object.created_at.strftime('%Y-%m-%d')
  end

  def image
    return unless object.image

    url = if Rails.env.test?
            rails_blob_path(object.image.file, only_path: true)
          else
            object.image.file.url(expires_in: 1.hour, disposition: 'inline')
          end
    {
      url: url,
      alt: object.image.alt_text
    }
  end
end
