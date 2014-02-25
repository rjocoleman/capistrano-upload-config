# Capistrano-Upload-Config

Upload, initialize and maintain configuration files for Capistrano 3.x outside of SCM.
(or in SCM just different files for different stages - the choice is yours!)

Say you're working in a small team on a Rails app, you've got a couple of environments and you have a `config/database.yml` that's got some secrets that differ per stage in it.
You'd like to maintain these secrets outside of source control but placing a `config/database.yml` on the server manually makes you nervous. What happens if it's lost? Did you upload the right one? Chaos. Stress. Sad face.

Capistrano-upload-config to the rescue. You can maintain a version of `config/database.yml` per stage, with different contents if you wish, keep these outside of your source control and still upload them without manual fiddling.

Equally this could be used to manage many other text based configuration files and used if you're in a team or not.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano', '~> 3.1.0'
gem 'capistrano-upload-config'
```

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install capistrano-upload-config`

## Usage

Require the module in your `Capfile`:

```ruby
require 'capistrano-upload-config'
```

`capistrano-upload-config` comes with 3 tasks:

* `config:check`
* `config:init`
* `config:push`


#### config:check

This task checks to see if all your set configuration files exist for the current stage:

```shell
$ cap staging config:check
 INFO Found: config/database.staging.yml
 WARN Not found: config/example.staging.yml
```


#### config:init

This creates the configured config files for the current stage if it doesn't already exist.
Bonus: It copies from an example file if one exists.


```shell
$ cap staging config:init
 WARN Already Exists: config/database.staging.yml
 INFO Copied: config/example.yml-example to config/example.staging.yml
 Created: config/foobar.staging.yml as empty file
```


#### config:push

This task creates the config on the remote server.


```shell
$ cap staging config:init
 WARN Already Exists: config/database.staging.yml
 INFO Copied: config/example.yml-example to config/example.staging.yml
 Created: config/foobar.staging.yml as empty file
```

Can be used during a deploy, If your `:config_files` and `:linked_files` are going to be the same I suggest hooking in before
`deploy:starting` to that the config files exist before symlinks are created:

```ruby
# add to config/deploy.rb

before 'deploy:starting', 'config:push'
```


### Configuration

Configurable options, shown here with defaults:

```ruby
set :config_files, fetch(:linked_files)
set :config_example_prefix, '-example'
```

By default your `:linked_files` are assumed to be config files, this might be totally wrong for your environment, never fear just:

```ruby
# in deploy.rb (or similar)

set :config_files, %w{dir1/config.toml config/example.ini hidden/secrets.json}

```

Note, capistrano-upload-config can only upload confir to your shared folder (and it's sub directories) so it's likely that `:config_files` will be a subset of `:linked_files`.

#### Example files

Do you use example files checked into your source control? e.g. `config/database.yml-example`
These will be used when running `config:init`. If your prefix differs, e.g. `config/database.yml.eg` set this as:

```ruby
# in deploy.rb (or similar)

set :config_example_prefix, '.eg'

```

Note, only prefixes (i.e. after the whole filename) are supported.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
