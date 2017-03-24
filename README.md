# README


## Description

This application is a json-api complient service that will list a number of films,
get details on a particular film and allow a user to submit a rating for a particular film.

## Downloading the Films API

At the command line got to the directory you wish to download the code and type:
```
git clone https://www.github.com/darmou/films.git
```

## Installing Dependencies

Check that you have Ruby 2.3.0 or greater. RVM is one way of installing different ruby versions.
The documentation for RVM can be found at:
https://rvm.io/

Ensure that Postgresql is installed, a detailed descriptions on how to install the Postgresql on various operating systems is available at:
https://wiki.postgresql.org/wiki/Detailed_installation_guides

At the command line go to the films root directory and type:
```
bundle install
```
Which will install all the required gems in the Gemfile.

## Creating the Database

To create the database type the following commands in the films root dir:
```
rake db:create
rake db:migrate
rake db:seed 
```
**Note:** The rake db:seed command provides some sample data which can be used to show pagination and filtering.

## Running the tests

To run the spec tests type:
```
rspec
```
In the films root directory.

## Running the Server Locally

In the films root directory type:

```
rails s
```

To start the server locally.

## What Can You do with Films?

- Get single film, example request with curl:
```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/films/1" 
```
- Get a list of films, example request with curl:
```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/films" 
```
- Get a list of films and specify paging details. Note: By default it is 2 per page to demonstrate paging, in a real application this would be at least 10. Example of more per page:
```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/films?page%5Bnumber%5D=1&page%5Bsize%5D=10"
```
Example of next page:
```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/films?page%5Bnumber%5D=2&page%5Bsize%5D=2"
```
- Get a filtered list of films.  The list of films can be filtered by title, url-slug and year. For example:
```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/films?filter\[url-slug\]=lotr_fotr"
```
- Sort a list of films. The list of films can also be sorted by all it's attributes such as title, url-slug and year. For example:
```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/films?sort=title&page%5Bsize%5D=10
```
- Specify the field attributes to return. Using the filter get parameter we can specify which attributes to return. Example:
```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/films?fields\[films\]=title,description&page%5Bsize%5D=10"
```
And for a single film:
```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/films/1?fields\[films\]=title,description"
```
- Create a film, example:
```
curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X POST -d '{"data": {"type":"films", "attributes":{"title":"Test", "description":"Desc", "url-slug":"test_url_slug"}}}' "http://localhost:3000/api/v1/films"
```
- Submit a rating for a user id, example:
```
url -i -H "Accept: application/vnd.api+json" -H 'Content-Type: application/vnd.api+json' -X POST -d '{"rating":"2.3","user_id":"testing"}' "http://localhost:3000/api/v1/films/1/submit_rating"
```


## More documentation

There is a full swagger documentation to describe each of the operations, their parameters etc. To view this documentation go to the films root dir and type these commands to start up the swagger node server.

```
cd swagger-ui
yarn
npm run dev
```

The last command will open a browser for http://localhost:3200 and list the operations for the film resource. It will error initially but after everything loads the browser window can be refreshed. Ensure that the main server is running (rails s).
