class Section < ApplicationRecord
  enum variant: { regular: 0, no_image: 1, carousel: 2, slider: 3 }
  belongs_to :view
  validates_presence_of :header
  has_one :image, -> { where variant: %w[regular carousel slider] }, dependent: :destroy
  has_many :buttons, -> { where variant: %w[regular] }, dependent: :destroy, class_name: 'Cta'
  has_many :slides, -> { where variant: %w[slider] }, dependent: :destroy, class_name: 'Image'
end
