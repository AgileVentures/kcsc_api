class Card < ApplicationRecord
  validates_presence_of :organization, :description
  belongs_to :section, required: true
  has_one :image, dependent: :destroy
end
