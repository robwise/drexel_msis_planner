require "support/helpers/feature_specs_helpers"
require "support/helpers/service_specs_helpers"
require "support/helpers/model_specs_helpers"
RSpec.configure do |config|
  config.include FeatureSpecsHelpers::SessionHelpers, type: :feature
  config.include ServiceSpecsHelpers::TMSScraperHelpers, type: :service
  config.include ModelSpecsHelpers::BehaviorHelpers, type: :model
  config.include ModelSpecsHelpers::GeneralHelpers, type: :service
  config.include ModelSpecsHelpers::GeneralHelpers, type: :model
end
