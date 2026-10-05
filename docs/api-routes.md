# API routes

Base URL: `http://localhost:4000/api`. Planned routes — the status column is updated as the
features are delivered.

Legend — **Access**: `public`, `user` (any signed-in user), `creator`, `owner` (creator of
the resource), `admin`.

## Health

| Method | Route     | Access | Description             | Status |
| ------ | --------- | ------ | ----------------------- | ------ |
| GET    | `/health` | public | API and database status | ✅     |

## Authentication

| Method | Route            | Access | Description                               | Status |
| ------ | ---------------- | ------ | ----------------------------------------- | ------ |
| POST   | `/auth/register` | public | Create an account (GDPR consent required) | ⬜     |
| POST   | `/auth/login`    | public | Sign in, returns a JWT                    | ⬜     |
| GET    | `/auth/me`       | user   | Current user                              | ⬜     |

## Users

| Method | Route              | Access | Description                         | Status |
| ------ | ------------------ | ------ | ----------------------------------- | ------ |
| GET    | `/users/:username` | public | Public profile and published models | ⬜     |
| PATCH  | `/users/me`        | user   | Update my profile                   | ⬜     |
| DELETE | `/users/me`        | user   | Delete my account (GDPR)            | ⬜     |
| GET    | `/users/me/export` | user   | Export my data (GDPR)               | ⬜     |

## 3D models

| Method | Route                  | Access        | Description                                                 | Status |
| ------ | ---------------------- | ------------- | ----------------------------------------------------------- | ------ |
| GET    | `/models`              | public        | Search + filters (category, price, format, sort), paginated | ⬜     |
| GET    | `/models/:id`          | public        | Model details (records a view)                              | ⬜     |
| POST   | `/models`              | creator       | Publish a model                                             | ⬜     |
| PATCH  | `/models/:id`          | owner / admin | Update a model                                              | ⬜     |
| DELETE | `/models/:id`          | owner / admin | Delete a model                                              | ⬜     |
| GET    | `/models/:id/download` | user          | Presigned download URL, increments the counter              | ⬜     |
| GET    | `/models/mine`         | creator       | My models with statistics                                   | ⬜     |

## Uploads

| Method | Route                | Access  | Description                             | Status |
| ------ | -------------------- | ------- | --------------------------------------- | ------ |
| POST   | `/uploads/model-url` | creator | Presigned URL to upload a 3D file       | ⬜     |
| POST   | `/uploads/image-url` | creator | Presigned URL to upload a preview image | ⬜     |

## Reference data

| Method | Route         | Access | Description         | Status |
| ------ | ------------- | ------ | ------------------- | ------ |
| GET    | `/categories` | public | List the categories | ⬜     |
| GET    | `/licenses`   | public | List the licenses   | ⬜     |

## Community

| Method | Route                  | Access        | Description           | Status |
| ------ | ---------------------- | ------------- | --------------------- | ------ |
| POST   | `/models/:id/like`     | user          | Like a model          | ⬜     |
| DELETE | `/models/:id/like`     | user          | Remove my like        | ⬜     |
| POST   | `/models/:id/favorite` | user          | Add to favorites      | ⬜     |
| DELETE | `/models/:id/favorite` | user          | Remove from favorites | ⬜     |
| GET    | `/users/me/favorites`  | user          | My favorites          | ⬜     |
| GET    | `/models/:id/comments` | public        | Comments of a model   | ⬜     |
| POST   | `/models/:id/comments` | user          | Add a comment         | ⬜     |
| DELETE | `/comments/:id`        | owner / admin | Delete a comment      | ⬜     |
| POST   | `/models/:id/reports`  | user          | Report a model        | ⬜     |

## Back office

| Method | Route               | Access | Description                                | Status |
| ------ | ------------------- | ------ | ------------------------------------------ | ------ |
| GET    | `/admin/reports`    | admin  | Reports to handle                          | ⬜     |
| PATCH  | `/admin/models/:id` | admin  | Change a model's status                    | ⬜     |
| GET    | `/admin/users`      | admin  | List the accounts                          | ⬜     |
| PATCH  | `/admin/users/:id`  | admin  | Enable/disable an account, change its role | ⬜     |
