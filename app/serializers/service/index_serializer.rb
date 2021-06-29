class Service::IndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :telephone, :email, :address, :postcode, :website, :coords

  def coords
    {
      latitude: object.latitude,
      longitude: object.longitude
    }
  end

  def email
    object.email == ('') ? nil : object.email
  end

  def telephone
    object.telephone == ('') ? nil : object.telephone
  end

  def website
    object.website == ('') ? nil : object.website
  end

  def address
    object.address == ('') ? nil : object.address
  end

  def postcode
    object.postcode == ('') ? nil : object.postcode
  end
end
