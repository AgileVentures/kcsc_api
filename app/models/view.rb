class View < ApplicationRecord

  validates_presence_of :name
  enum variant: { services: 0, about_us: 1, about_self_care: 2, information: 3 }

  has_many :sections
end
