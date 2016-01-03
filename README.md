iAdvize Backend challenge
==================

This application let you fetch the last 200 records from [VDM website](http://viedemerde.fr) and store them into the database.
You can then retrieved them via the dedicated JSON REST API.

I've decided to use Ruby on Rails for this test as agreed before.

Retrieve VDM posts
-------------

You can fetch the last 200 posts from [VDM website](http://viedemerde.fr) by using this simple command:
```ruby
rake vdm:get_posts
```

You can also specify the number of posts to fetch with the parameter <code>NB_OF_VDM_TO_GET</code>
```ruby
rake vdm:get_posts NB_OF_VDM_TO_GET=100
```

For test purpose, you can go to [this page](https://iadvize-challenge.herokuapp.com/vdm) to see a preview of the result (this will execute the command).


Use the API
-------------
You can test the API in [Heroku](https://iadvize-challenge.herokuapp.com/api/v1/posts), this will give you all the posts in JSON. You can use optionals parameters (from, to, author).

* Get all posts: [/api/v1/posts](https://iadvize-challenge.herokuapp.com/api/v1/posts)
* Get all posts from Anonyme: [/api/v1/posts?author=Anonyme](https://iadvize-challenge.herokuapp.com/api/v1/posts?author=Anonyme)
* Get all posts since 2015/01/01: [/api/v1/posts?from=2015-01-01](https://iadvize-challenge.herokuapp.com/api/v1/posts?from=2015-01-01)
* Get all posts from Anonyme between two dates: [/api/v1/posts?author=Anonyme&from=2015-01-01&to=2016-01-01](https://iadvize-challenge.herokuapp.com/api/v1/posts?author=Anonyme&from=2015-01-01&to=2016-01-01)


Unit tests
-------------
You can find the tests under <code>test/</code>.
There is multiple unit tests for the <code>Post</code> model and the API. Tests can be executed with the command:
```ruby
rake test
```