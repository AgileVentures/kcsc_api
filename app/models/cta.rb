
class Cta < ApplicationRecord
  belongs_to :section

  private
  def is_regular?
    section.regular?
  end
end
