class Image < ApplicationRecord
  belongs_to :article
  has_one_attached :file
end
