A Simple Kittens API project from [The Odin Project](http://www.theodinproject.com/ruby-on-rails/apis).

The app renders JSON data instead of HTML.

To get the data on the kittens, fire up <code>irb</code> and type <code>require 'rest_client''</code> (assuming rest_client gem is installed).
Then type: <code> response = RestClient.get("http://localhost:3000/kittens", :accept => :json)</code>

To get data on an individual kitten, type: <code> response = RestClient.get("http://localhost:3000/kittens/2", :accept => :json)</code>
