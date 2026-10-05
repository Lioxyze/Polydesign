import 'dotenv/config';
import { PrismaMariaDb } from '@prisma/adapter-mariadb';
import { PrismaClient } from '../src/generated/prisma/client';

const databaseUrl = process.env.DATABASE_URL;
if (!databaseUrl) {
  throw new Error('DATABASE_URL is not set, copy .env.example to .env first.');
}

const prisma = new PrismaClient({ adapter: new PrismaMariaDb(databaseUrl) });

const roles = [
  { name: 'USER', description: 'Registered user' },
  { name: 'CREATOR', description: 'User who can publish 3D models' },
  { name: 'ADMIN', description: 'Moderator' },
];

const categories: Record<string, string[]> = {
  Personnages: ['Humains', 'Créatures', 'Robots'],
  Animaux: ['Mammifères', 'Oiseaux', 'Reptiles'],
  Véhicules: ['Voitures', 'Motos', 'Avions', 'Vaisseaux'],
  Architecture: ['Bâtiments', 'Intérieurs', 'Ruines'],
  Mobilier: ['Salon', 'Cuisine', 'Bureau'],
  Nature: ['Plantes', 'Arbres', 'Rochers'],
  Objets: ['Électronique', 'Outils', 'Décoration'],
  Armes: ['Armes blanches', 'Armes à feu', 'Science-fiction'],
};

const licenses = [
  { name: 'CC0 Domaine public', commercialUse: true, modificationsAllowed: true },
  { name: 'CC BY 4.0 Attribution', commercialUse: true, modificationsAllowed: true },
  { name: 'Usage personnel uniquement', commercialUse: false, modificationsAllowed: true },
  {
    name: 'Usage commercial sans redistribution',
    commercialUse: true,
    modificationsAllowed: false,
  },
];

const tags = [
  'Cyberpunk',
  'Sci-Fi',
  'Fantasy',
  'Low-poly',
  'Réaliste',
  'Cartoon',
  'Médiéval',
  'Stylisé',
];

function slugify(value: string): string {
  return value
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '');
}

async function main(): Promise<void> {
  for (const role of roles) {
    await prisma.role.upsert({ where: { name: role.name }, update: role, create: role });
  }

  for (const [name, subcategories] of Object.entries(categories)) {
    const slug = slugify(name);
    const parent = await prisma.category.upsert({
      where: { slug },
      update: { name },
      create: { name, slug },
    });

    for (const subName of subcategories) {
      const subSlug = `${slug}-${slugify(subName)}`;
      await prisma.category.upsert({
        where: { slug: subSlug },
        update: { name: subName, parentId: parent.id },
        create: { name: subName, slug: subSlug, parentId: parent.id },
      });
    }
  }

  for (const license of licenses) {
    await prisma.license.upsert({
      where: { name: license.name },
      update: license,
      create: license,
    });
  }

  for (const name of tags) {
    await prisma.tag.upsert({ where: { name }, update: {}, create: { name } });
  }

  console.log('Seed completed.');
}

main()
  .catch((error: unknown) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(() => void prisma.$disconnect());
