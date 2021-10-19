class Article < ApplicationRecord
  validates_presence_of :title, :body
  validates_inclusion_of :published, in: [true, false]
  belongs_to :author, class_name: 'User'
  has_one :image, dependent: :destroy

  default_scope { where(case_study: false) }
end
