# More info at https://github.com/guard/guard#readme

clearing :on
notification :growl

guard :bundler do
  watch('Gemfile')
  # Uncomment next line if your Gemfile contains the `gemspec' command.
  # watch(/^.+\.gemspec/)
end

guard 'rails' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
  watch('.env')
  watch('config/routes.rb')
end


# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rsspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separetly)
#  * 'just' rspec: 'rspec'
guard :rspec, cmd: 'spring rspec' do
  # Rerun all tests
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('spec/rails_helper.rb')                       { "spec" }
  watch('config/routes.rb')                           { "spec" }
  watch('app/controllers/application_controller.rb')  { "spec" }

  # Rerun all tests if file directly in support folder was changed
  watch(%r{^spec/support/(\w+)\.rb$})                 { "spec" }

  # Rerun entire category of tests when associated helper is changed
  watch(%r{^spec/support/helpers/(.+)_helpers\.rb}) do |m|
    "spec/#{m[1]}"
  end

  # Rerun tests from spec if that spec was changed
  watch(%r{^spec/.+_spec\.rb})

  # Rerun model spec and feature specs if associated model is changed
  watch(%r{^app/models/(.+)\.rb$}) do |m|
    ["spec/models/#{m[1]}_spec.rb", "spec/features/#{m[1]}s"]
  end

  # Rerun feature specs when associated view is changed
  watch(%r{^app/views/(\w+)/(.+)$}) do |m|
    "spec/features/#{m[1]}"
  end

  # Rerun feature specs when associated view helper is changed
  watch(%r{^app/helpers/(.+)_helper\.rb$}) do |m|
    "spec/features/#{m[1]}"
  end

  # Rerun feature specs when associated controller is changed
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  do |m|
    "spec/features/#{m[1]}"
  end

  # Rerun policy spec for associated policy
  watch(%r{^app/policies/(.+)\.rb$}) do |m|
    "spec/policies/#{m[1]}_spec.rb"
  end
end

guard 'livereload', notify: true do
  watch(%r{app/views/.+\.(erb|haml|slim)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
end
