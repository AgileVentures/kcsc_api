class Section::ShowSerializer < ActiveModel::Serializer
  attributes :variant, :header, :view_id, :id

  def attributes(*args)
    hash = super
    hash[:buttons] = object.buttons if object.regular?
    hash[:description] = object.description unless object.carousel?
    hash[:cards] = object.cards if object.carousel?
    hash 
  end
end
