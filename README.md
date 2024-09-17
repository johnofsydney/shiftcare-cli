# shiftcare-cli

## TO set up the CLI application

- `$ bundle install`

## TO Run the tests

- `$ bundle exec rspec`

## TO Run the CLI application

- `$ ruby cli.rb`
- enter a coommand
  - if the command is `search` also add the search term, eg `search doe`

## Extensions

- the clients file could be read in from a command line argument
- the field to search could be read in from a command line argument
- neither the Duplicates or Search class should require modifications, as the changes would be handled at the CLI class level

- To offer the same functionality on a REST API rather than CLI

  - the CLI class is replaced with a controller method. The args are read in as the params
  - The the Duplicates and Search classes should (hopefully) not require modifications - they can be called from CLI, controller, or anywhere else in the application

- To offer the capability at scale
  - perhaps the search and duplicate functionality would have to run against data in the database
    - the ruby `group_by` and `select` methods would be replaced by ActiveRecord methods
    - indexes on fullname and email would of course be helpful
    - Maybe use a full-text search engine like Elasticsearch
  - perhaps the user (or other calling service) does not need to be blocked waiting for the result. Can the invocation be handed off to a queue (eg Sidekiq) and the results delivered asynchronously?
  - The application could be scalled, such that more instances of the application are instantiated to deal with more load.
    - Worth thinking about if the Duplicates and Search services can be deployed as Lambdas, and scale independently from the full scale application.
  - Cache results so that repeat invocations can be served faster
