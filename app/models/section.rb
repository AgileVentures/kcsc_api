class Section < ApplicationRecord
  enum variant: { services: 0, about_us: 1, about_self_care: 2, information: 3 }
  belongs_to :view
end
