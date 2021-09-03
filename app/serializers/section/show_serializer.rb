class Section::ShowSerializer < ActiveModel::Serializer
  attributes :variant, :header, :description, :view_id 
end
