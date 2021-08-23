# AthensMC

AthensMC is a gaming community founded in 2014 that works to promote a sense of community between players. Our services range from Vanilla Minecraft, to Modded Minecraft packs off the shelf to even our own customized Modpacks.

We strive to promote a fair playing experience for all members and want to encourage growth. This application provides the backbone of the community, with the Whitelist Requesting/Approval System that has been built out.

## Setting up local development environment

1. Install Ruby (2.7.1)
2. Install Bundler
3. Install Rails (6.0 currently)
4. Install PostgreSQL/all requirements for OS (Redis needed!)
5. Run

- `cp config/secrets.yml.example config/secrets.yml`
- Make the changes to config/secrets.yml and config/database.yml relating to your development install. Then continue.
- `bundle install`
- `rails db:create`
- `rails db:migrate`

Then you should be good to go!

## Server

We don't explicitly require you to use Foreman but if you're so inclined..

`gem install foreman`

Then you can start the server with the included Procfile by running

```
foreman start -f Procfile.dev
```
