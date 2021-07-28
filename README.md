# Rails Engine
### Commerce-based API designed to view merchant inventory, manage items and analyze sales.
**Powers the corresponding front-end project [Rails Driver](#)**

Built with Ruby 2.7 and Rails 5, Rails Engine exposes endpoints to return merchant inventory, perform CRUD operations on their items and provide revenue analytics. The project specs are based off the Turing School of Software and Design's [associated project](#). **This project is recommended for backend beginners to:**
- Learn the basics of building an API in Rails
- Exploring API endpoints in [Postman](#)
- Visualizing the front-end/back-end interaction using [Rails Driver](#)

## Set Up
Ruby 2.7.2 and [PostgreSQL](#) are the only prerequisites needed to get started. Documentation assumes user has prior knowledge of using a command-line interface, and I will be referring to the Terminal/Console, etc as *Console* throughout documentation.
*Note: It is generally recommended to use either [rvm](#) or [rbenv](#) to manage Ruby versions.*

Rails Engine's dependencies are mangaged with [Bundler](#). Run `gem install bundler` if not already installed, and then `bundle install` in the project directory to download all dependencies.

### Database
Rails Engine includes a database dump file under `db/data` that is used to seed a PostgreSQL database for development and is used in lieu of migrations.
1. Run `rake db:{create,migrate,seed}`; warnings from `pg_restore` are to be expected.
2. Verify whether database seeding was successful by running `rails db` and then `\dt` once in psqgl to show all database tables. Exit psql with `\q`.
3. Run `rails db:schema:dump` and verify that `db/schema.rb` has been updated to reflect the database's schema. **This is vital to ensure Rails Engine's core functionality**

### Server
After database setup, serve the API with `rails s`. Endpoints can then be examined using a tool like [Postman](#), [HttPie](#), or serving the Rails/JavaScript front-end, [Rails Driver](#), alongside.

## Endpoints
Endpoints for Rails Engine mostly follow a RESTful convention.
```
Example 1: get '/api/v1/merchants'
{
    "data": [
        {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        },
	    ...
    ]
}
```
### RESTful
Rails Engine exposes the following RESTful endpoints:
- `get` '/api/v1/items'
- `get` '/api/v1/items/:id'
- `patch` '/api/v1/items/:id'
- `put` '/api/v1/items/:id'
- `delete` '/api/v1/items/:id'
- `post` '/api/v1/items'
- `get` '/api/v1/items/merchant'
- `get` '/api/v1/merchants'
- `get` '/api/v1/merchants/:id'
- `get` '/api/v1/merchants/:id/items'

### Non-RESTful
#### Search
Rails Engine features basic search functionality and allows for finding multiple items or a single merchant by name.
- `get` '/api/v1/merchants/find?name=example'
- `get` '/api/v1/items/find_all?name=example'
*Note: A straightforward exercise in hacking on models and controllers in Rails would be to build out a `find_all` endpoint for merchants and `find` for items. PR's gladly accepted.*

#### Revenue Analysis
Rails Engine also features endpoints for sales analysis, including:
- Overall revenue:
    - `get` '/api/v1/revenue'
- Revenue across time-frame:
    - `get` '/api/v1/revenue?start_date=2020-06-23&end_date=2021-06-23'
- Revenue of single merchant:
    - `get` '/api/v1/revenue/merchants/:id'
- List of merchants by top revenue:
    - `get` '/api/v1/revenue/merchants?quantity=10'
- Weekly revenue:
    - `get` '/api/v1/revenue/weekly'

## Other Notes
- [FactoryBot](#) and [Rspec]() were utilized for tests throughout the project. Test suite can be run with `bundle exec rspec`.
- Postman tests are also included under `spec/postman-tests` if one is inclined to utilize them. Not all tests pass, but core functionality is commessurate with the tests' intent.
- If you are used to Rails, but haven't delved into JavaScript yet, the associated [Rails Driver](#) project can be served alongside to hack on a Rails/JavaScript front-end.
- Known issues are logged under repo Issues in Github, and will likely not be reviewed unless someone comments on them.
