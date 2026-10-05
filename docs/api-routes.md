# API routes

Base URL: `http://localhost:4000/api`. Planned routes, the status column is updated as the
features are delivered.

Access levels: `public`, `user` (any signed-in user), `creator`, `owner` (creator of the
resource), `admin`.

## Health

| Method | Route     | Access | Description             | Status |
| ------ | --------- | ------ | ----------------------- | ------ |
| GET    | `/health` | public | API and database status | Done   |

## Authentication

| Method | Route                   | Access | Description                                          | Status |
| ------ | ----------------------- | ------ | ---------------------------------------------------- | ------ |
| POST   | `/auth/register`        | public | Create an account (GDPR consent required)            | Todo   |
| POST   | `/auth/verify-email`    | public | Confirm the e-mail address with the link token       | Todo   |
| POST   | `/auth/login`           | public | Sign in, returns an access token and a refresh token | Todo   |
| POST   | `/auth/refresh`         | public | New access token from a refresh token (rotation)     | Todo   |
| POST   | `/auth/logout`          | user   | Revoke the refresh token                             | Todo   |
| POST   | `/auth/forgot-password` | public | Send a password reset link                           | Todo   |
| POST   | `/auth/reset-password`  | public | Set a new password with the link token               | Todo   |
| GET    | `/auth/me`              | user   | Current user                                         | Todo   |

## Upload and consultation of a 3D model (main feature)

| Method | Route                                | Access        | Description                                                              | Status |
| ------ | ------------------------------------ | ------------- | ------------------------------------------------------------------------ | ------ |
| POST   | `/models`                            | creator       | Create a model as a draft (metadata and technical details)               | Todo   |
| PATCH  | `/models/:id`                        | owner / admin | Update a model                                                           | Todo   |
| POST   | `/models/:id/files`                  | owner         | Declare a file, returns a presigned upload URL                           | Todo   |
| POST   | `/models/:id/files/:fileId/complete` | owner         | Check the uploaded object in S3 and mark the file as uploaded            | Todo   |
| DELETE | `/models/:id/files/:fileId`          | owner         | Remove a file                                                            | Todo   |
| POST   | `/models/:id/images`                 | owner         | Declare a preview image, returns a presigned upload URL                  | Todo   |
| POST   | `/models/:id/publish`                | owner         | Publish (at least one uploaded file required)                            | Todo   |
| DELETE | `/models/:id`                        | owner / admin | Remove a model (status removed)                                          | Todo   |
| GET    | `/models`                            | public        | Search and filters (text, category, tags, format, premium...), paginated | Todo   |
| GET    | `/models/:slug`                      | public        | Model page, records a view                                               | Todo   |
| POST   | `/models/:id/download`               | user          | Presigned download URL, records the download                             | Todo   |
| GET    | `/users/me/models`                   | creator       | My models with their statistics                                          | Todo   |

## Reference data

| Method | Route         | Access | Description                         | Status |
| ------ | ------------- | ------ | ----------------------------------- | ------ |
| GET    | `/categories` | public | Categories with their subcategories | Todo   |
| GET    | `/licenses`   | public | Licenses                            | Todo   |
| GET    | `/tags`       | public | Tags                                | Todo   |

## Users

| Method | Route                 | Access | Description                         | Status |
| ------ | --------------------- | ------ | ----------------------------------- | ------ |
| GET    | `/users/:username`    | public | Public profile and published models | Todo   |
| PATCH  | `/users/me`           | user   | Update my profile and links         | Todo   |
| DELETE | `/users/me`           | user   | Anonymize my account (GDPR)         | Todo   |
| GET    | `/users/me/export`    | user   | Export my data (GDPR)               | Todo   |
| GET    | `/users/me/downloads` | user   | My downloads                        | Todo   |

## Community

| Method | Route                              | Access        | Description                 | Status |
| ------ | ---------------------------------- | ------------- | --------------------------- | ------ |
| PUT    | `/models/:id/like`                 | user          | Like a model                | Todo   |
| DELETE | `/models/:id/like`                 | user          | Remove my like              | Todo   |
| PUT    | `/models/:id/favorite`             | user          | Add to favorites            | Todo   |
| DELETE | `/models/:id/favorite`             | user          | Remove from favorites       | Todo   |
| PUT    | `/models/:id/rating`               | user          | Rate a model (1 to 5)       | Todo   |
| GET    | `/models/:id/comments`             | public        | Comments and replies        | Todo   |
| POST   | `/models/:id/comments`             | user          | Comment or reply            | Todo   |
| PATCH  | `/comments/:id`                    | owner         | Edit my comment             | Todo   |
| DELETE | `/comments/:id`                    | owner / admin | Delete a comment            | Todo   |
| PUT    | `/users/:id/follow`                | user          | Follow a creator            | Todo   |
| DELETE | `/users/:id/follow`                | user          | Unfollow a creator          | Todo   |
| POST   | `/collections`                     | user          | Create a collection         | Todo   |
| PUT    | `/collections/:id/models/:modelId` | owner         | Add a model to a collection | Todo   |
| POST   | `/models/:id/reports`              | user          | Report a model              | Todo   |

## Subscription

| Method | Route                    | Access | Description                      | Status |
| ------ | ------------------------ | ------ | -------------------------------- | ------ |
| POST   | `/subscriptions`         | user   | Subscribe to premium (simulated) | Todo   |
| DELETE | `/subscriptions/current` | user   | Cancel at the end of the period  | Todo   |

## Back office

| Method | Route                 | Access | Description                                   | Status |
| ------ | --------------------- | ------ | --------------------------------------------- | ------ |
| GET    | `/admin/reports`      | admin  | Reports to handle                             | Todo   |
| PATCH  | `/admin/reports/:id`  | admin  | Resolve or reject a report                    | Todo   |
| PATCH  | `/admin/models/:id`   | admin  | Change the status of a model                  | Todo   |
| PATCH  | `/admin/comments/:id` | admin  | Hide or show a comment                        | Todo   |
| GET    | `/admin/users`        | admin  | List the accounts                             | Todo   |
| PATCH  | `/admin/users/:id`    | admin  | Enable or disable an account, change its role | Todo   |
