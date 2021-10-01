class Section::ShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :variant, :header, :view_id, :id

  def attributes(*args)
    hash = super
    hash[:buttons] = object.buttons if object.regular?
    hash[:description] = object.description unless object.carousel?
    hash[:image] = image if object.regular?
    hash[:cards] = object.cards if object.carousel?
    hash 
  end

  private

  def image
    return unless object.image

    url = if Rails.env.test? || Rails.env.development?
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
