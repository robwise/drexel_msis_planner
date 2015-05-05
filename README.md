[![Code Climate](https://codeclimate.com/github/robwise/drexel_msis_planner/badges/gpa.svg)](https://codeclimate.com/github/robwise/drexel_msis_planner)
[![Test Coverage](https://codeclimate.com/github/robwise/drexel_msis_planner/badges/coverage.svg)](https://codeclimate.com/github/robwise/drexel_msis_planner)
# Drexel MSIS Planner
The Drexel MSIS Planner is a Ruby on Rails web application that assists students earning their [Master of Science in Information Systems](http://catalog.drexel.edu/graduate/collegeofinformationscienceandtechnology/informationsystems/) at Drexel University's College of Computing and Informatics (CCI) to plan their course curriculums. Drexel has a very complex ruleset for prerequisite and corequisite courses and does not offer courses every quarter. Therefore, without the aid of a tool such as this, it can be difficult to plan one's degree ahead of time.

The app is currently still in development, but a preview version can be found [online on Heroku](https://still-sands-7957.herokuapp.com/). The app allows users to create an account, specify the courses they have already taken, and then browse and add other courses to their plan. Planned courses are automatically checked for issues such as planning to take a course without also planning to have taken the needed prerequisite courses.

## Getting Started
Clone the repo and ensure all tests are passing. Note that one of the tests is checking the external connection to the Drexel-TMS-Scraper app and will fail in an offline situation. This test is tagged with `external_api` and can thus be excluded from the test suite if necessary.

```
git clone https://github.com/robwise/drexel_msis_planner.git
cd drexel_msis_planner
bundle install --without production
bundle exec rake db:migrate
bundle exec rake db:test:prepare
bundle exec rspec spec/
```

<!-- ## Documentation and Support -->

## Issues
The application is still currently in development and therefore is not yet fully functional.

<!-- ## Similar Projects -->

## Contributing
I doubt anyone will really be interested in helping me with this—that's okay, I'm just trying to learn! If you do happen to be interested, feel free to contact me or just [submit a pull request](https://github.com/robwise/drexel_msis_planner/pulls).

## Credits

- __Rails Apps:__ This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem provided by the [RailsApps Project](http://railsapps.github.io/).

## License
See [LICENSE.MD](LICENSE.MD)
