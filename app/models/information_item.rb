class InformationItem < ApplicationRecord
  validates_presence_of :header, :description, :link
  validates_inclusion_of :pinned, in: [true, false]
  validates_inclusion_of :publish, in: [true, false]
end
