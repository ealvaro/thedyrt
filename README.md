# README
## Requirements (v20210414)

1. Implement a RESTful API that will be used to manage campground availability and pricing

2. The models must contain the following:
- a. Campground
-     i. name: every Campground has a name
-    ii. campsites: each Campground requires a minimum of one associated
campsite
-   iii. booked_dates: Campgrounds can derive a list of booked dates from their
associated Campsites
-    iv. price_range: Campground derive a price range from their associated
Campsite

- b. Campsite
-      i. name: every Campsite has a name
-     ii. campground: every Campsite is associated with a Campground
-    iii. booked_dates: each Campsite keeps track of which nights it is booked
-     iv. price: each Campsite has a single price per night

3. You may implement additional models to support the Campground and Campsite if you see fit.

4. Attached to this challenge you should have received a CSV with campground data to
seed the database. Implement a means of loading this data. There doesn’t have to be an API endpoint for this, a console based solution is perfectly acceptable.

5. The API must implement all CRUD methods for all models

6. The API must have an endpoint that returns a list of Campgrounds that are available on a specific date range.

7. API must have an endpoint that returns a list of Campgrounds ordered by price, both low to high, and high to low

## Specs:

* Ruby version

2.7.2

* System dependencies

`faker` gem for seeds
`rspec` gem for testing
`pg` gem for postgres DB
`jbuilder` for templating
`dotenv-rails` for env. vars. management

* System generation
```shell
rails g scaffold campground name:string
rails g scaffold campsite name:string price:integer campground:references
rails g scaffold booked_date check_in_date:date check_out_date:date campsite:references
```
* Webapp VM creation

```shell
sudo docker build .
```

* Webapp & Database VMs composition and start
```shell
sudo docker-compose build
sudo docker-compose up
```

* Database initialization (run from a different console)
```shell
sudo docker-compose run app rake db:create db:migrate db:seed
```

* How to run the test suite

```shell
sudo docker-compose run app rspec spec/requests/validate_user.rb
```

* How to test it from a web browser

** Get all users
<http://localhost:3000/users.json>

* How to stop the webapp and database

```shell
sudo docker-compose stop
```

## Assumptions

Some of the system requirements/specs were not determined so the following assumptions were made:

* DBMS used is `postgres`
* CREATE endpoints are a POST and must have a body with the Request parameters in json format
* The date `booked_date` is treated the same as in a hotel room. That is `check_in_date` is the first night and `check_out_date` is not allowed to stay that night.

* Testing the CREATE `Campground` endpoint would be

```shell
curl -i -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{
  "first_name": "Ji",
  "last_name": "Legros",
  "phone_number": "853-715-9077",
  "college_id": 4,
  "exam_id": 16,
  "start_time": "2021-04-24 11:30:00"
}' http://localhost:3000/users/
```

* Testing the `list of Campgrounds` endpoint
```shell
curl -i -X GET -H "Content-Type: application/json" -H "Accept: application/json" http://localhost:3000/campgrounds.json
```
