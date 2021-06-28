# README

Please follow the below instructions for setting the application up.

This application have following relationships 

# Models
* User
* Post
* Comment
* Image

# Relations
* User ```has_many``` sessions (For being logged in on multiple devices)
* User ```has_many``` posts
* User ```has_one``` image (polymorphic using imageable for profile_picure)
* User ```has_many``` comments
* Post ```has_many``` comments
* Post ```has_one``` image (polymorphic using imageable for banner)

# How to Setup and Run:

* Ruby version ``` 3.0.0 ```
* Rails Version ```6.1.1 ```
* Please clone the above repository
* Run ``` bundle install ``` to install gems
* Run ``` rake db:setup  ``` to setup database
* Run ``` rails s ``` to start the application
* Use the following to test apis using Postman ``` https://www.getpostman.com/collections/115112606a1dfe60d446 ```
* While testing APIs please make sure to signup/login first before running all other Apis you'd need to add ```Authorization``` in header with value ```Bearer YOUR_API_TOKEN```# blog-test
