import { validateEnv } from './env';

const validEnv = {
  DATABASE_URL: 'mysql://user:password@localhost:3306/polydesign',
};

describe('validateEnv', () => {
  it('accepts a valid configuration and applies defaults', () => {
    const env = validateEnv(validEnv);

    expect(env.NODE_ENV).toBe('development');
  });

  it('rejects a database URL that is not MySQL', () => {
    expect(() => validateEnv({ DATABASE_URL: 'postgres://localhost/polydesign' })).toThrow(
      /DATABASE_URL/,
    );
  });

  it('rejects a missing database URL', () => {
    expect(() => validateEnv({})).toThrow(/DATABASE_URL/);
  });
});
