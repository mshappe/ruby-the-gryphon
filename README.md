[![Build
Status](https://snap-ci.com/mshappe/ruby-the-gryphon/branch/master/build_image)](https://snap-ci.com/mshappe/ruby-the-gryphon/branch/master) [![Code Climate](https://codeclimate.com/github/mshappe/ruby-the-gryphon/badges/gpa.svg)](https://codeclimate.com/github/mshappe/ruby-the-gryphon) [![Test Coverage](https://codeclimate.com/github/mshappe/ruby-the-gryphon/badges/coverage.svg)](https://codeclimate.com/github/mshappe/ruby-the-gryphon)

# Ruby the Gryphon

"...all gryphons are girls..."

This is -- or will be -- the code repository for the New Web Application project
for the [Kingdom of Northshield](http://northshield.org), a division of the
[Society for Creative Anachronism](http://sca.org). If you don't know what that
means, you're in the wrong place! :-)

If you would like to contribute to this project, please contact the Chief Cook
and Bottle Washer, [Michael Shappe (aka Yehudah elteber ben Yitzhak)](mailto:yehudah.ns@zoho.com).
Note that all direct contributors must be willing to assign copyright to the SCA, Inc.,
although credit will be retained in a the [CONTRIBUTORS](CONTRIBUTORS) file.
As this is licensed under the [MIT License](LICENSE), others may fork this project at will and
do whatever they like with it, but contributions to **this** project, specifically,
require that assignment.

Stay tuned for more details!

## If you're trying to set this up to run for yourself locally

You can actually set this up to run from scratch locally, with a few dependencies.

0. Do the usual stuff -- set up a database, run `rake db:create db:migrate`, that sort of thing.
1. In `db/fixtures/admin_user.rb`, change the e-mail address and password to be something useful to you. This ties in to the `/admin` interface, which in turn allows some manipulation of low-level stuff (not as much as I originally expected to use it, but might be expanded).
2. Run `rake db:seed_fu` to run all the fixtures. **This is important** as it sets up certain defaults for internal data types. Yes, the IDs are all a little strange if you read the files. Almost all of these are pulled out of an older design where they were all mashed together in a couple of tables instead of having their own discrete types.

If you wind up making changes to the fixtures for any reason, rerun db:seed_fu.

There is not yet a lot of dummy seed data beyond the stuff that's actual configuration data. That could stand to be fleshed out.
