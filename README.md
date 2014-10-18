Medicine Tracker
================

Simple inventory tracking application to track medicine.

## Installation

### Run bundler

   bundle install

### Setup the database

   rake db:setup

### Running the server

   unicorn_rails

### Visit [http://localhost:8080/](http://localhost:8080)

### System Information

Ruby: Developed on 2.1.1p76 -- Should work for 1.9.3+

Database: SQLite3 was chosen because this is not meant to be a production application.

## Tests

### Run RSpec

    rspec

### CURL

After starting up the server, below is an example list of capabilities.

#### Signing In

The `rake db:seed` task will create a test user for you. If you already ran the `rake db:setup` task, this has been done for you.

The users credentials are: test@test.com/password

Submit the curl request as follows, **this is required before making any other requests!**. You will receive a 401 response otherwise.

    curl -b cookies -c cookies -H "Content-Type: application/json" -XPOST http://localhost:8080/users/sign_in.json -d '{"user":{"email":"test@test.com","password":"password"}}'

    {"success":true}

Notice the `-b cookies -c cookies`, this is curl's cookie jar. You'll need to make sure every request has `-b cookies -c cookies` in order to keep you signed in.

Also, any request which sends in JSON data such as this one, will also need the content type header to specify how to parse the request body.

#### Creating a package

We want to be able to create a new package with two different drugs in it. The first being "Propofol", which has been mixed from two separate containers and so it has two different expiration dates. Second, a drug named "Epinephrine" with just a single expiration date. Here's how we would curl it:

    curl -b cookies -c cookies -H "Content-Type: application/json" -XPOST http://localhost:8080/packages.json -d '{"package":{"name": "cURLed package", "drugs":[{"name":"Propofol","expiration_dates":["2013/10/11","2013/01/30"]},{"name":"Epinephrine","expiration_dates":["2014/10/11"]}]}}'

    {"id":1,"name":"cURLed package","serial":null,"created_at":"2014-10-18T05:10:47.735Z","updated_at":"2014-10-18T05:10:47.735Z","drugs":[{"id":1,"name":"Propofol","created_at":"2014-10-18T05:10:47.736Z","updated_at":"2014-10-18T05:10:47.736Z","package_id":1,"expiration_dates":[{"id":1,"date":"2013-10-11","created_at":"2014-10-18T05:10:47.737Z","updated_at":"2014-10-18T05:10:47.737Z","drug_id":1},{"id":2,"date":"2013-01-30","created_at":"2014-10-18T05:10:47.738Z","updated_at":"2014-10-18T05:10:47.738Z","drug_id":1}]},{"id":2,"name":"Epinephrine","created_at":"2014-10-18T05:10:47.739Z","updated_at":"2014-10-18T05:10:47.739Z","package_id":1,"expiration_dates":[{"id":3,"date":"2014-10-11","created_at":"2014-10-18T05:10:47.739Z","updated_at":"2014-10-18T05:10:47.739Z","drug_id":2}]}]}

#### Updating the package

We need to update the package as well, we can add new drugs to the existing package with the following statement. Be sure to update the URL to change the ID of the package if you are updating anything other than `1` as shown below.

    curl -b cookies -c cookies -H "Content-Type: application/json" -XPUT http://localhost:8080/packages/1.json -d '{"package":{"drugs":[{"name":"Epinephrine","expiration_dates":["2013/10/11"]}]}}'

No response is returned for a successful update (this is very UNIX like, no response for success).

#### Listing out all packages

Performing a GET request on `/packages.json` will give a more detailed view of all packages.

    curl -b cookies -c cookies -XGET http://localhost:8080/packages.json

    [{"id":1,"created_at":"2014-10-18T05:10:47.735Z","updated_at":"2014-10-18T05:10:47.735Z","drugs":["Propofol","Epinephrine","Epinephrine"],"expiration_date":"2013-01-30","url":"http://localhost:8080/packages/1.json"}]

We can see that this one package contains 3 drugs: "Propofol", "Epinephrine", and "Epinephrine". Of all of them, the date when the package will first begin to expire is 2013-01-30. If you look at the examples above, its because of the Propofol, it has two expiration dates with one of them being 2013-01-30.

#### Nested Data

##### Drugs

Say we want to zoom in on the data contained within a particular package, just the drugs of a package that we know the ID of. We can use nested routing to retrieve just those objects.

    curl -b cookies -c cookies -XGET http://localhost:8080/packages/1/drugs.json

    [{"id":1,"name":"Propofol","created_at":"2014-10-18T05:10:47.736Z","updated_at":"2014-10-18T05:10:47.736Z","expiration_date":"2013-01-30","package_id":1,"url":"http://localhost:8080/packages/1/drugs/1.json","package_url":"http://localhost:8080/packages/1.json"},{"id":2,"name":"Epinephrine","created_at":"2014-10-18T05:10:47.739Z","updated_at":"2014-10-18T05:10:47.739Z","expiration_date":"2014-10-11","package_id":1,"url":"http://localhost:8080/packages/1/drugs/2.json","package_url":"http://localhost:8080/packages/1.json"},{"id":3,"name":"Epinephrine","created_at":"2014-10-18T05:14:12.371Z","updated_at":"2014-10-18T05:14:12.371Z","expiration_date":"2013-10-11","package_id":1,"url":"http://localhost:8080/packages/1/drugs/3.json","package_url":"http://localhost:8080/packages/1.json"}]

We can also create new drugs for a specific package. Since we are zooming, we need only specify the drug data.

    curl -b cookies -c cookies -H "Content-Type: application/json" -XPOST http://localhost:8080/packages/1/drugs.json -d '{"drug":{"name":"AnotherDrug","expiration_dates":["2014-10-30"]}}'

    {"id":5,"name":"AnotherDrug","created_at":"2014-10-18T05:38:27.269Z","updated_at":"2014-10-18T05:38:27.269Z","package_id":1,"expiration_dates":[{"id":6,"date":"2014-10-30","created_at":"2014-10-18T05:38:27.270Z","updated_at":"2014-10-18T05:38:27.270Z","drug_id":5}]}

Or fetch a specific drug that we know the ID of:

    curl -b cookies -c cookies -XGET http://localhost:8080/packages/1/drugs/5.json

    {"id":5,"name":"AnotherDrug","created_at":"2014-10-18T05:38:27.269Z","updated_at":"2014-10-18T05:38:27.269Z","expiration_date":"2014-10-30","package_id":1,"url":"http://localhost:8080/packages/1/drugs/5.json","package_url":"http://localhost:8080/packages/1.json"}

And even update that drug if we need to change something:

    curl -b cookies -c cookies -H "Content-Type: application/json" -XPUT http://localhost:8080/packages/1/drugs/5.json -d '{"drug":{"name":"ChangedName"}}'

No response is returned, this is expected and it means the update was successful. You can always fetch it to see:

    curl -b cookies -c cookies -XGET http://localhost:8080/packages/1/drugs/5.json

    {"id":5,"name":"ChangedName","created_at":"2014-10-18T05:38:27.269Z","updated_at":"2014-10-18T05:43:13.362Z","expiration_date":"2014-10-30","package_id":1,"url":"http://localhost:8080/packages/1/drugs/5.json","package_url":"http://localhost:8080/packages/1.json"}

Removing a drug can be done also. (Notice I'm removing a different drug than the `5` we've been using)

    curl -b cookies -c cookies -XDELETE http://localhost:8080/packages/1/drugs/2.json

Again, no response in this case is a good response.

##### Expiration Dates

Zooming in further to the expiration dates is also possible.

    curl -b cookies -c cookies -XGET http://localhost:8080/packages/1/drugs/5/expiration_dates.json

    [{"id":6,"date":"2014-10-30","created_at":"2014-10-18T05:38:27.270Z","updated_at":"2014-10-18T05:38:27.270Z","drug_id":5,"url":"http://localhost:8080/packages/1/drugs/5/expiration_dates/6.json","drug_url":"http://localhost:8080/packages/1/drugs/5.json"}]

And adding a new date is also simple.

    curl -b cookies -c cookies -H "Content-Type: application/json" -XPOST http://localhost:8080/packages/1/drugs/5/expiration_dates.json -d '{"expiration_date":{"date":"2015-12-31"}}'

    {"id":7,"date":"2015-12-31","created_at":"2014-10-18T05:50:57.589Z","updated_at":"2014-10-18T05:50:57.589Z","drug_id":5}

We can fetch just that expiration date back again as well.

    curl -b cookies -c cookies -XGET http://localhost:8080/packages/1/drugs/5/expiration_dates/7.json

    {"id":7,"date":"2015-12-31","created_at":"2014-10-18T05:50:57.589Z","updated_at":"2014-10-18T05:50:57.589Z","drug_id":5,"url":"http://localhost:8080/packages/1/drugs/5/expiration_dates/7.json","drug_url":"http://localhost:8080/packages/1/drugs/5.json"}

Same with updating it (though this sounds like it may be some kind of health code violation).

    curl -b cookies -c cookies -H "Content-Type: application/json" -XPUT http://localhost:8080/packages/1/drugs/5/expiration_dates/7.json -d '{"expiration_date":{"date":"2016-01-30"}}'

No response again, good. Lastly we can delete it, there will not be a response for that either:

    curl -b cookies -c cookies -XDELETE http://localhost:8080/packages/1/drugs/5/expiration_dates/7.json
