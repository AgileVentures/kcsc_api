class Section::ShowSerializer < ActiveModel::Serializer
  attributes :variant, :header, :description, :view_id 

  def attributes(*args)
    hash = super
    hash[:buttons] = object.buttons if object.regular?
    hash
  end
end
