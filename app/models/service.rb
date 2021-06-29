class Service < ApplicationRecord
  update_index('services') { self }
end
