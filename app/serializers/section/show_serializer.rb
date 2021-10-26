class Section::ShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :variant, :header, :view_id, :id, :order

  def attributes(*args)
    hash = super
    hash[:buttons] = object.buttons if object.regular?
    hash[:description] = object.description unless object.carousel?
    hash[:image] = image if object.regular?
    hash[:cards] = list_of_cards if object.carousel?
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

  def list_of_cards
    cards = Card.all
    cards.map do |card|
      image_environment(card) if card.image.present?
      {
        id: card.id,
        logo: @url,
        alt: @alt,
        published: card.published,
        description: card.description,
        organization: card.organization,
        web: card.web,
        facebook: card.facebook,
        twitter: card.twitter,
        section_id: card.section_id
      }
    end
  end

  def image_environment(card)
    @alt = card.image.alt_text
    @url = if Rails.env.test? || Rails.env.development?
             rails_blob_path(card.image.file, only_path: true)
           else
             card.image.file.url(expires_in: 1.hour, disposition: 'inline')
           end
  end
end
