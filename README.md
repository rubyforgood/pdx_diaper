= README

{<img src="https://travis-ci.org/rubyforgood/pdx_diaper.svg?branch=master" alt="Build Status" />}[https://travis-ci.org/rubyforgood/pdx_diaper]

== Ruby Version
This app uses Ruby version 2.3.0, indicated in `/.ruby-version`, which will be auto-selected if you use a Ruby versioning manager like `rvm` or `rbenv`.

== Database Configuration
This app uses PostgreSQL for all environments. When you first clone this app, you will need to create a `.env` file in the root of the application, and populate it with:

```
DEV_DB_USERNAME=dev_username
DEV_DB_PASSWORD=dev_password
TEST_DB_USERNAME=test_username
TEST_DB_PASSWORD=test_password
```

You'll also need to create the `dev` and `test` databases, the app is expecting them to be named `pdxdb_development` and `pdxdb_test`, respectively.

== Dealing with ActiveAdmin Quirks
This app addresses a few outstanding bugs in `ActiveAdmin` by patching them in a fork of `ActiveAdmin` and then using that fork. Efforts have been made to submit those corrections to the source app, but for the time being this is the solution. If you discover bugs in ActiveAdmin, feel free to clone http://github.com/armahillo/activeadmin and submit pull-requests against it. 


== Contributing
Please feel free to contribute! While we welcome all contributions to this app, pull-requests that address outstanding Issues *and* have appropriate test coverage for them will be strongly prioritized. In particular, addressing issues that are tagged with the next milestone should be prioritized higher.

Standard Github community processes apply -- fork the repo, make your changes, submit a pull-request with your change. Please indicate which issue it addresses in your pull-request title.
