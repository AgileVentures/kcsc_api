class InformationItem < ApplicationRecord
  validates_presence_of :header, :description, :link, :pinned, :publish
end
