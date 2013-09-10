Bifrost
=======

Generic search interface for all collections in Bifrost


to run on a local development machine:
$ bundle install
$ rake db:migrate
$ rails generate blacklight:jetty
$ cd jetty; java -jar start.jar &
OR start another jetty/solr insance. Preferable with data from either DIAS or Bifrost-Billeder.
$ rails server