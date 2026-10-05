import { PrismaMariaDb } from '@prisma/adapter-mariadb';
import { PrismaClient } from './generated/prisma/client';
import { validateEnv } from './env';

const env = validateEnv(process.env);

const globalForPrisma = globalThis as unknown as { prisma?: PrismaClient };

export const prisma =
  globalForPrisma.prisma ?? new PrismaClient({ adapter: new PrismaMariaDb(env.DATABASE_URL) });

if (env.NODE_ENV !== 'production') {
  globalForPrisma.prisma = prisma;
}
