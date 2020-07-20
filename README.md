# Example Rails API

## Installation

```
  bundle install
  rake db:setup
  rake test
```

## Run the API

```
  rails server
```

## API methods

### GET /content

Returns a list of all movies and seasons, showing latest additions first.
Includes episodes for seasons.
Includes purchase options.

#### Params

* type (optional): movie|season to filter only movies or seasons

### GET /purchase

Returns a list of all the active purchases for a user.

#### Params

* user_id (required): id of the user

### POST /purchase

Performs a purchase for a content (movie or season) and a quality.
Only one purchase for the same content and quality can be active at a time.

#### Params

* user_id (required): id of the user making the purchase
* content_id (required): id of the content to purchase
* quality (required): SD|HD quality of the content for this purchase
