require "support/helpers/features_helpers"
require "support/helpers/services_helpers"
RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include ServicesHelpers::TMSScraperHelpers, type: :service
end
