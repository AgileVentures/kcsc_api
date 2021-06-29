class Notes::Serializer < ActiveModel::Serializer
  attributes :body, :id, :date, :creator 

  def date
    object.created_at.strftime("%d %b %Y")
  end

  def creator
    return 'System' unless object.creator
    Users::Serializer.new(object.creator)
  end
end