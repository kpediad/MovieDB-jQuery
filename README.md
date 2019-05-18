# MovieDB

A rails based MVC web app for users to list and review movies.

A movie has:

* a title
* a release year and
* a synopsis

A review has a rating and optional text content. Each review belongs to a specific movie and a user.
Anyone can view the available movies and reviews. No log-in is required for these two actions.

A user can create their own application account or can also sign-up/log-in using their google account. A user needs to be logged in order to add new movies, add and/or update their reviews. Reviews can also be deleted by their owners. A user can also delete their application account. Once a user account is deleted, the associated reviews with this user account are deleted also.

Movies, once added can be updated by any logged-in user, however movies can never be deleted by anyone.An average rating is calculated for each movie based on the individual user reviews submitted for it.

## Usage

To use this app in a development environment, after forking and/or cloning the repository, run `bundle install`, `rails db:migrate` and then run `rails server`.
Everything should be set up.

## Contributing Bugfixes or Features

For submitting something back, be it a patch, some documentation, or new feature requires some level of community interactions.

Committing code is easy:

- Fork the this repository
- Create a local development branch for the bugfix or feature
- Commit and push changes to github
- Submit a pull request for your changes to be included

## License
MovieDB is licensed under the [MIT license](http://opensource.org/licenses/MIT).
