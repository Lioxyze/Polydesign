import { prisma } from './db';

export interface HealthStatus {
  status: 'ok' | 'degraded';
  database: 'up' | 'down';
  timestamp: string;
}

async function isDatabaseUp(): Promise<boolean> {
  try {
    await prisma.$queryRaw`SELECT 1`;
    return true;
  } catch {
    return false;
  }
}

export async function getHealthStatus(): Promise<HealthStatus> {
  const databaseUp = await isDatabaseUp();

  return {
    status: databaseUp ? 'ok' : 'degraded',
    database: databaseUp ? 'up' : 'down',
    timestamp: new Date().toISOString(),
  };
}
