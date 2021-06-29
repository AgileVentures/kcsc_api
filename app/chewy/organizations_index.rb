class OrganizationsIndex < Chewy::Index
  index_scope Organization
  field :name, type: :text
  field :description, type: :text
  field :website, type: :text
  field :telephone, type: :text
  field :email, type: :text
end
