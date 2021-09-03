class View < ApplicationRecord

  validates_presence_of :name
  has_many :sections
end
