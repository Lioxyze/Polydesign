/** @type {import('jest').Config} */
module.exports = {
  moduleFileExtensions: ['js', 'json', 'ts'],
  rootDir: 'src',
  testRegex: '.*\\.spec\\.ts$',
  transform: { '^.+\\.ts$': ['ts-jest', { tsconfig: '<rootDir>/../tsconfig.spec.json' }] },
  collectCoverageFrom: ['**/*.ts', '!main.ts', '!**/*.module.ts', '!generated/**'],
  coverageDirectory: '../coverage',
  testEnvironment: 'node',
  // The generated Prisma client uses ESM-style ".js" import paths
  moduleNameMapper: { '^(\\.{1,2}/.*)\\.js$': '$1' },
};
