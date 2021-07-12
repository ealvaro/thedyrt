# README
## Requirements (v20210414)

1. Implement a RESTful API that will be used to manage campground availability and pricing

2. The models must contain the following:
- a. Campground
-     i. name: every Campground has a name
-     ii. campsites: each Campground requires a minimum of one associated campsite
-     iii. booked_dates: Campgrounds can derive a list of booked dates from their associated Campsites
-     iv. price_range: Campground derive a price range from their associated
Campsite

- b. Campsite
-     i. name: every Campsite has a name
-     ii. campground: every Campsite is associated with a Campground
-     iii. booked_dates: each Campsite keeps track of which nights it is booked
-     iv. price: each Campsite has a single price per night

3. You may implement additional models to support the Campground and Campsite if you see fit.

4. Attached to this challenge you should have received a CSV with campground data to seed the database. Implement a means of loading this data. There doesn’t have to be an API endpoint for this, a console based solution is perfectly acceptable.

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
`rubocop` for sanity and linting

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
or if you want to load a csv file then run the following and make sure you put the file in the /loads folder.
```shell
sudo docker-compose run app rake db:load
```

* How to run the test suite

```shell
sudo docker-compose run app rspec spec/requests/
```

* How to test it from a web browser

** Get all Campgrounds
<http://localhost:3000/campgrounds.json>

* How to stop the webapp and database

```shell
sudo docker-compose stop
```

## Assumptions

Some of the system requirements/specs were not determined so the following assumptions were made:

* DBMS used is `postgres`
* CREATE endpoints are a POST and must have a body with the Request parameters in json format
* The date `booked_date` is treated the same as in a hotel room. That is `check_in_date` is the first night and `check_out_date` is not allowed to stay that night.

## Testing

* Testing the `list of Campgrounds` endpoint
```shell
curl -i -X GET -H "Content-Type: application/json" -H "Accept: application/json" http://localhost:3000/campgrounds.json
```

* Testing the CREATE `Campground` endpoint would be

```shell
curl -i -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{
    "name": "The Best Campground"
}' http://localhost:3000/campgrounds/
```

* Testing the CREATE `Campsite` endpoint would be

```shell
curl -i -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{
  "name": "D-12",
  "price": "83",
  "campground_id": 11
}' http://localhost:3000/campsites/
```

* Testing the Booking of a `Campsite` endpoint would be

```shell
curl -i -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{
  "check_in_date": "2021-07-17",
  "check_out_date": "2021-07-18",
  "campsite_id": 11
}' http://localhost:3000/booked_dates/
```

* When an invalid endpoint is invoked

```
{
"routing_error": "/campground"
}
```

* Testing using POSTMAN
<https://www.getpostman.com/collections/a5e67fb515f13b91baf7>
