# Rails 6 upsert_all demo app

This app demos how to use the `upsert_all` API added in Rails 6 to take
advantage of the `INSERT… ON CONFLICT`
[feature](https://www.postgresql.org/docs/9.5/sql-insert.html#SQL-ON-CONFLICT)
of modern databases to more efficiently batch updates.

## Running the example script

First, install dependencies and set up the database:

```
$ bundle
$ bin/rake db:setup
```

Next, you'll want to set this environment variable by [creating a free API
key](https://orghunter.3scale.net/#plans") (if placed in `.env`, it will be
loaded automatically):

```
ORG_HUNTER_API_KEY="123456789"
```

Then run the example script

```
$ ./script/download_and_update_charities
```

Then, from `psql` or `bin/rails console`, you should be able to inspect the
results.  To just make sure that some records were persisted, you can run:

```
$ bin/rails runner "p Charity.count"
9025
```

## Points of interest

* The [migration](/db/migrate/20200401023456_add_cities_and_charities.rb) to
  create all the appropriate tables; note the timestamp defaults and unique
  indices (both are necessary)

* The actual calls to [upsert_all](/app/lib/upserts_charities.rb)
