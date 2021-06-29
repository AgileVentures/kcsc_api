class Organization < ApplicationRecord

  update_index('organizations') { self }
end
