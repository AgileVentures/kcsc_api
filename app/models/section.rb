class Section < ApplicationRecord
  enum variant: { regular: 0, no_image: 1, carousel: 2, slider: 3 }
  belongs_to :view
  validates_presence_of :header
  has_one :image, ensuring_owner_was: regular || slider || carousel, dependent: :destroy_async
  has_many :buttons, dependent: :destroy, class_name: 'Cta'
  validates_associated :buttons
  has_many :slides, ensuring_owner_was: slider, dependent: :destroy, class_name: 'Image'
end
