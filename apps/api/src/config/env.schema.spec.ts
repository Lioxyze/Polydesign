import { validateEnv } from './env.schema';

const validEnv = {
  DATABASE_URL: 'mysql://polydesign:polydesign@localhost:3306/polydesign',
  JWT_SECRET: 'a-very-long-secret-used-only-in-the-unit-tests',
  S3_ENDPOINT: 'http://localhost:9000',
  S3_BUCKET: 'polydesign',
  S3_ACCESS_KEY: 'key',
  S3_SECRET_KEY: 'secret',
};

describe('validateEnv', () => {
  it('accepts a valid configuration and applies defaults', () => {
    const env = validateEnv(validEnv);

    expect(env.PORT).toBe(4000);
    expect(env.NODE_ENV).toBe('development');
  });

  it('rejects a JWT secret that is too short', () => {
    expect(() => validateEnv({ ...validEnv, JWT_SECRET: 'short' })).toThrow(/JWT_SECRET/);
  });

  it('rejects a missing database URL', () => {
    const { DATABASE_URL: _omitted, ...withoutDb } = validEnv;

    expect(() => validateEnv(withoutDb)).toThrow(/DATABASE_URL/);
  });
});
