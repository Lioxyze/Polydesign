# PolyDesign

A French-speaking platform to **publish, share and download 3D models**.
Independent 3D creators publish their models (free, paid or premium); users search, filter,
preview and download them, and interact through likes, favorites and comments.

> Final project for the _Concepteur Développeur d'Applications_ certification (RNCP 37873).
> Work in progress.

## Tech stack

| Layer        | Technologies                                                                  |
| ------------ | ----------------------------------------------------------------------------- |
| Web app      | Next.js 16 (App Router), React 19, TypeScript, Tailwind CSS 4, TanStack Query |
| API          | NestJS 12, TypeScript, Zod (validation), JWT (authentication)                 |
| Database     | MySQL 8.4, Prisma 7 (ORM + migrations)                                        |
| File storage | S3-compatible object storage with presigned upload URLs (planned)             |
| Tooling      | npm workspaces, Docker Compose, Jest, ESLint, Prettier, GitHub Actions        |

## Repository structure

| Path                 | Content                                           |
| -------------------- | ------------------------------------------------- |
| `apps/api`           | NestJS REST API, Prisma schema, migrations, seed  |
| `apps/web`           | Next.js web app                                   |
| `docs`               | Architecture, data model, API routes              |
| `docker`             | Configuration of the local services               |
| `docker-compose.yml` | Development environment: MySQL, Adminer, API, web |

## Getting started

### Prerequisites

- [Node.js 24 LTS](https://nodejs.org/), version 24.15 or later (see `.nvmrc`)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (runs MySQL, Adminer, the API and the web app)

### 1. Install dependencies

```bash
npm install
```

### 2. Configure the environment

```bash
cp .env.example .env
cp apps/api/.env.example apps/api/.env
cp apps/web/.env.example apps/web/.env.local
```

The default values match the Docker Compose services, nothing to change for local development.

### 3. Start the development environment

```bash
npm run services:up      # docker compose up -d
```

This starts MySQL, Adminer, the API and the web app. Code changes in the containers need
`docker compose restart api` (or `web`).

### 4. Create the database schema and seed it

```bash
npm run db:migrate -w @polydesign/api    # applies the Prisma migrations
npm run db:seed -w @polydesign/api       # roles, categories, licenses
```

### 5. Open the web app

The API and the web app already run in Docker. To run them on your machine instead
(with hot reload), stop the containers first, then start them:

```bash
docker compose stop api web
npm run dev:api     # http://localhost:4000/api
npm run dev:web     # http://localhost:3000
```

The home page shows whether the web app can reach the API and the database.

### Local URLs

| Service          | URL                              | Credentials                                 |
| ---------------- | -------------------------------- | ------------------------------------------- |
| Web app          | http://localhost:3000            |                                             |
| API              | http://localhost:4000/api        |                                             |
| API health check | http://localhost:4000/api/health |                                             |
| Adminer (tables) | http://localhost:8080            | server `mysql`, `polydesign` / `polydesign` |
| MySQL            | `localhost:3306`                 | `polydesign` / `polydesign`                 |

## Scripts

Run from the repository root:

| Command                 | Description                               |
| ----------------------- | ----------------------------------------- |
| `npm run dev:api`       | Start the API in watch mode               |
| `npm run dev:web`       | Start the web app in development mode     |
| `npm run build`         | Build every workspace                     |
| `npm run lint`          | ESLint + TypeScript type check everywhere |
| `npm test`              | Run the unit tests                        |
| `npm run format`        | Format the code with Prettier             |
| `npm run services:up`   | Start MySQL, Adminer, the API and the web |
| `npm run services:down` | Stop the local services                   |

Database scripts (`-w @polydesign/api`): `db:migrate`, `db:seed`, `db:reset`, `db:studio`, `db:generate`.

## Documentation

- [Architecture](docs/architecture.md)
- [Data model](docs/data-model.md)
- [API routes](docs/api-routes.md)
- [Contributing & Git conventions](CONTRIBUTING.md)

## Author

Lorenzo Ghiotti
