-- Runs once, when the MySQL volume is created (docker-entrypoint-initdb.d).
-- Prisma Migrate (`prisma migrate dev`) needs to create and drop a temporary
-- "shadow" database to detect schema drift. The app user only gets that right
-- on databases whose name starts with prisma_migrate_shadow_db (least privilege).
GRANT ALL PRIVILEGES ON `prisma\_migrate\_shadow\_db%`.* TO 'polydesign'@'%';
FLUSH PRIVILEGES;
