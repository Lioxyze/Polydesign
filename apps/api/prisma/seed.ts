/**
 * Reference data needed for the app to work: roles, categories and licenses.
 * Idempotent (upserts) — safe to run several times: `npm run db:seed`.
 */
import 'dotenv/config';
import { PrismaMariaDb } from '@prisma/adapter-mariadb';
import { PrismaClient } from '../src/generated/prisma/client';

const databaseUrl = process.env.DATABASE_URL;
if (!databaseUrl) {
  throw new Error('DATABASE_URL is not set — copy .env.example to .env first.');
}

const prisma = new PrismaClient({ adapter: new PrismaMariaDb(databaseUrl) });

const roles = [
  { name: 'USER', description: 'Registered user: download, comment, like, favorite, report' },
  { name: 'CREATOR', description: 'User who can also publish and manage their own 3D models' },
  { name: 'ADMIN', description: 'Moderation: manage models, accounts, reports and comments' },
];

// Category names are user-facing content, so they stay in French.
const categories = [
  'Personnages',
  'Animaux',
  'Véhicules',
  'Architecture',
  'Mobilier',
  'Nature',
  'Objets',
  'Armes & accessoires',
];

const licenses = [
  { type: 'free', name: 'CC0 — Domaine public' },
  { type: 'free', name: 'CC BY 4.0 — Attribution' },
  { type: 'paid', name: 'Licence standard — usage personnel et commercial' },
  { type: 'paid', name: 'Licence éditoriale — usage non commercial' },
];

async function main(): Promise<void> {
  for (const role of roles) {
    await prisma.role.upsert({ where: { name: role.name }, update: role, create: role });
  }

  for (const name of categories) {
    await prisma.category.upsert({ where: { name }, update: {}, create: { name } });
  }

  for (const license of licenses) {
    const existing = await prisma.license.findFirst({ where: { name: license.name } });
    if (!existing) {
      await prisma.license.create({ data: license });
    }
  }

  console.log(
    `Seeded ${roles.length} roles, ${categories.length} categories, ${licenses.length} licenses.`,
  );
}

main()
  .catch((error: unknown) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(() => void prisma.$disconnect());
