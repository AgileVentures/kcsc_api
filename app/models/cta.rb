
class Cta < ApplicationRecord
  belongs_to :section
  validate :is_regular?

  private
  def is_regular?
    section.regular?
  end
end
