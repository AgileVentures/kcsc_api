class Service < ApplicationRecord
  update_index('services') { self }

  geocoded_by :full_address
  after_validation :geocode, if: -> { not_geocoded? }

  private

  def full_address
    return address if postcode.blank?
    return postcode if address.blank?

    "#{address}, #{postcode}"
  end

  def not_geocoded?
    latitude.blank? and longitude.blank?
  end
end
