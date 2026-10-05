import { prisma } from './db';
import { getHealthStatus } from './health';

jest.mock('./db', () => ({ prisma: { $queryRaw: jest.fn() } }));

const queryRaw = prisma.$queryRaw as unknown as jest.Mock;

describe('getHealthStatus', () => {
  it('reports ok when the database is reachable', async () => {
    queryRaw.mockResolvedValue([]);

    const result = await getHealthStatus();

    expect(result).toMatchObject({ status: 'ok', database: 'up' });
    expect(new Date(result.timestamp).toISOString()).toBe(result.timestamp);
  });

  it('reports degraded when the database is down', async () => {
    queryRaw.mockRejectedValue(new Error('connection refused'));

    await expect(getHealthStatus()).resolves.toMatchObject({
      status: 'degraded',
      database: 'down',
    });
  });
});
