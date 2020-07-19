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

#### Params

* type (optional): movie|season to filter only movies or seasons