class Section < ApplicationRecord
  enum variant: { regular: 0, no_image: 1, carousel: 2, slider: 3 }
  belongs_to :view
  validates_presence_of :header
  has_one :image, -> { where variant: %w[regular carousel slider] }, dependent: :destroy
end
