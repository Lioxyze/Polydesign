import 'dotenv/config';
import { defineConfig } from 'prisma/config';

export default defineConfig({
  schema: 'prisma/schema.prisma',
  migrations: {
    path: 'prisma/migrations',
    seed: 'tsx prisma/seed.ts',
  },
  datasource: {
    // Not required by `prisma generate` (run on install, before .env exists);
    // migrate/seed/studio fail with a clear error if it is missing.
    url: process.env.DATABASE_URL ?? '',
  },
});
