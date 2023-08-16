# Movie Rental API - Technical Challenge

## Fixes

- Removed the unique index rule for movie rentals to allow multiple rentals of the same movie, especially for those
  frequently requested. Replaced it with a non-unique index to maintain performance.
- Eliminated referencing `user_id` in requests due to security concerns, especially when used as a query parameter.
  Implemented the usage of JWT for enhanced security. JWT is harder to intercept and can be securely placed in headers,
  encrypted when transmitted via SSL. It also has a 1-hour expiration.
- Adjusted the Ruby version from 2.2 to 2.3 in the project's configuration to match the dependencies required by the
  bundled packages.
- Implemented a transactional approach to the rent procedure to ensure database consistency.

## Refactors

- Segregated API RESTs into separate controllers to improve the clarity of the codebase. Separated movie recommendations
  from the main movie functionalities. Created a distinct controller for rental operations.
- Introduced the practice of using services for operations within controllers, even for simple model calls. This
  practice aids in unit testing and maintains a cleaner code structure.

## Features

- Implemented an authorization layer using a secure cryptographic mechanism to compare passwords. This new service also
  generates the JWT token for enhanced security.
- Added the ability for users to mark movies as favorites. Users can now maintain a list of their preferred movies using
  this feature.

## API Docs

## Base URL and Authentication

The base URL for all endpoints is `http://localhost:3000`. Make sure to include the necessary authentication token in
your requests to access protected endpoints.

Authentication is required for some endpoints. Use the bearer token provided during authentication in
the `Authorization` header.

```markdown
Headers:
Authorization: Bearer {{_.token}}
```

## Endpoints

### Rentals

#### Rent a Movie

- Method: POST
- URL: `/rentals`
- Description: Rent a movie by providing the `movie_id`.
- Body:
  ```json
  {
    "movie_id": 1
  }
  ```
- Headers:
  ```
  Content-Type: application/json
  ```
- Authentication: Bearer Token
- Returns: No content

#### Get Rented Movies

- Method: GET
- URL: `/rentals`
- Description: Retrieve a list of rented movies.
- Authentication: Bearer Token
- Returns: List of rented movies

### Movies

#### List All Movies

- Method: GET
- URL: `/movies`
- Description: Get a list of all available movies.
- Authentication: None
- Returns: List of movies

#### Get Movie Recommendations

- Method: GET
- URL: `/movies/recommendations`
- Description: Get movie recommendations.
- Authentication: Bearer Token
- Returns: List of recommended movies

#### List Favorite Movies

- Method: GET
- URL: `/movies/favorites`
- Description: Get a list of user's favorite movies.
- Authentication: Bearer Token
- Returns: List of favorite movies

#### Mark Movie as Favorite

- Method: POST
- URL: `/movies/favorites`
- Description: Mark a movie as a favorite by providing the `movie_id`.
- Body:
  ```json
  {
    "movie_id": 2
  }
  ```
- Headers:
  ```
  Content-Type: application/json
  ```
- Authentication: Bearer Token
- Returns: No content

### Authentication

#### Authenticate User

- Method: POST
- URL: `/auth`
- Description: Authenticate a user by providing the email and password.
- Body:
  ```json
  {
    "email": "user1@example.org",
    "password": "password"
  }
  ```
- Authentication: None
- Returns: User authentication token

#### Get User Information

- Method: GET
- URL: `/auth`
- Description: Get authenticated user information.
- Authentication: Bearer Token
- Returns: User information