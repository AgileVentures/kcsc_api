class ServicesIndex < Chewy::Index
  index_scope Service
  field :name, type: :text
  field :description, type: :text
  field :website, type: :text
  field :telephone, type: :text
  field :email, type: :text
  field :category, type: :text
  field :category_secondary, type: :text
end
