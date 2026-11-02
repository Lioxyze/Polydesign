# PolyDesign

A French-speaking platform to **publish, share and download 3D models**.
Creators publish their models, users browse the catalog, preview the models in 3D and download them.
Free models for everyone, premium models with a subscription (Bronze, Argent, Gold).

> Final project for the _Concepteur Développeur d'Applications_ certification (RNCP 37873).

## Project status

The development environment is ready. The features are built step by step, one branch per feature.

| Step                                                   | Status |
| ------------------------------------------------------ | ------ |
| Next.js app, Docker, MySQL, CI                         | Done   |
| Data model (Prisma schema and migrations)              | To do  |
| Authentication (JWT, roles, subscription plans)        | To do  |
| Upload, publication, catalog and download of 3D models | To do  |

## Tech stack

One Next.js application: the pages and the API (route handlers in `src/app/api`).

| Layer        | Technologies                                                                    |
| ------------ | ------------------------------------------------------------------------------- |
| Application  | Next.js 16 (App Router), React 19, TypeScript 6, Tailwind CSS 4, TanStack Query |
| API          | Next.js route handlers, Zod (validation)                                        |
| Database     | MySQL 8.4, Prisma 7                                                             |
| File storage | S3-compatible object storage (planned)                                          |
| Tooling      | Docker Compose, Jest, ESLint, Prettier, GitHub Actions                          |

## Repository structure

| Path                   | Content                                                   |
| ---------------------- | --------------------------------------------------------- |
| `src/app`              | URLs only: pages in `(web)`, route handlers in `api`      |
| `src/api`              | Back end: environment, database, business logic           |
| `src/web`              | Front end: React components, API client, styles           |
| `prisma/schema.prisma` | Prisma schema                                             |
| `docker/mysql`         | MySQL init script (rights for the Prisma shadow database) |
| `docker-compose.yml`   | Development environment: MySQL, Adminer, Next.js          |

## Getting started

### Prerequisites

- [Node.js 24 LTS](https://nodejs.org/) (see `.nvmrc`)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### 1. Install the dependencies

```bash
npm install
```

### 2. Configure the environment

```bash
cp .env.example .env
```

The default values match the Docker Compose services, nothing to change for local development.

### 3. Start the environment

```bash
npm run services:up      # docker compose up -d
```

This starts MySQL, Adminer and the Next.js app.

To run the app on your machine instead (faster hot reload):

```bash
docker compose stop web
npm run dev              # http://localhost:3000
```

The home page shows whether the app can reach the database.

### Local URLs

| Service          | URL                              | Credentials                                 |
| ---------------- | -------------------------------- | ------------------------------------------- |
| Application      | http://localhost:3000            |                                             |
| API health check | http://localhost:3000/api/health |                                             |
| Adminer          | http://localhost:8080            | server `mysql`, `polydesign` / `polydesign` |
| MySQL            | `localhost:3306`                 | `polydesign` / `polydesign`                 |

## Database

The Prisma schema has no model yet. To add one:

1. Write the model in `prisma/schema.prisma`.
2. Create and apply the migration: `npm run db:migrate -- --name <name>`
3. Generate the Prisma client: `npm run db:generate`

## Scripts

| Command                 | Description                                |
| ----------------------- | ------------------------------------------ |
| `npm run services:up`   | Start MySQL, Adminer and the app in Docker |
| `npm run services:down` | Stop the Docker services                   |
| `npm run dev`           | Start the app in development mode          |
| `npm run build`         | Build the app                              |
| `npm run lint`          | ESLint + TypeScript type check             |
| `npm test`              | Run the unit tests                         |
| `npm run format`        | Format the code with Prettier              |

Database scripts: `db:migrate`, `db:generate`, `db:reset`, `db:studio`.

## Contributing

Branches, commit messages and checks before a push: see [CONTRIBUTING.md](CONTRIBUTING.md).

## Author

Lorenzo Ghiotti ([@Lioxyze](https://github.com/Lioxyze))
