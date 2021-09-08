class InformationItem::ShowSerializer < ActiveModel::Serializer
  attributes :id, :date, :header, :description, :link, :pinned, :publish

  def date
    object.created_at.strftime('%Y-%m-%d')
  end
end
