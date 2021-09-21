class Card::ShowSerializer < ActiveModel::Serializer
  attributes :id, :organization, :description, :date, :section_id, :logo, :alt, :web, :facebook, :twitter, :published

  def date
    object.created_at.strftime('%Y-%m-%d')
  end

  def logo
    return unless object.image

    url = if Rails.env.test?
            object.image.file
          else
            object.image.file.url(expires_in: 1.hour, disposition: 'inline')
          end
  end

  def alt
    object.image.alt_text
  end
end
