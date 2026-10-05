import { Test } from '@nestjs/testing';
import { PrismaService } from '../prisma/prisma.service';
import { HealthController } from './health.controller';

describe('HealthController', () => {
  let controller: HealthController;
  const prisma = { isHealthy: jest.fn<Promise<boolean>, []>() };

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      controllers: [HealthController],
      providers: [{ provide: PrismaService, useValue: prisma }],
    }).compile();

    controller = moduleRef.get(HealthController);
  });

  it('reports ok when the database is reachable', async () => {
    prisma.isHealthy.mockResolvedValue(true);

    const result = await controller.check();

    expect(result).toMatchObject({ status: 'ok', database: 'up' });
    expect(new Date(result.timestamp).toISOString()).toBe(result.timestamp);
  });

  it('reports degraded when the database is down', async () => {
    prisma.isHealthy.mockResolvedValue(false);

    await expect(controller.check()).resolves.toMatchObject({
      status: 'degraded',
      database: 'down',
    });
  });
});
