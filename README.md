# Garter - A Mutli-Server Plesk Admin Tool

Garter connects multiple Plesk servers together in one interface to help manage administrative tasks.

## Dev environment

### Do the usual Rails things

```
$ cd ~/code/garter
$ rbenv install 2.3.1
$ rbenv local 2.3.1
$ bundle install
$ bower install
```

### Setup the database

```
$ cp .env.example .env
```

Examine the file and edit as necessary.

### Add your server(s)

Now with your server(s) setup in the db, populate the domains and assoicated data:

```
$ rails c
\> PleskServer.create!(host: 'my-web-server.com')
\> exit
$ rake plesk:sync_servers
$ rake plesk:sync_domains
$ rake plesk:domain_stats
$ rake domains:lookup
$ rake domains:pagespeed_test
```
