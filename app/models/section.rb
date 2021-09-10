class Section < ApplicationRecord
  enum variant: { regular: 0, no_image: 1, carousel: 2 }
  belongs_to :view
  validates_presence_of :header
  has_one :image, ensuring_owner_was: regular || carousel, dependent: :destroy_async
  has_many :buttons, dependent: :destroy, class_name: 'Cta'
  has_many :cards, dependent: :destroy
  validates_associated :buttons
end
