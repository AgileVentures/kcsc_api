# frozen_string_literal: true

Chewy.root_strategy = :atomic
Chewy.use_after_commit_callbacks = !Rails.env.test?

if !ENV['CHEWY'] && Rails.env.test?
  # we skip setting the port if running tests
elsif Rails.env.production?
  Chewy.settings = { host: ENV['BONSAI_URL'] }
else
  Chewy.settings = { host: 'localhost:9200' }
end
