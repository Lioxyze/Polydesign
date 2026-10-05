/*
  Warnings:

  - You are about to drop the `aime` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `categorie` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `commentaire` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `favori` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `image_modele` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `licence` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `modele_3d` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `signalement` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `utilisateur` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `vue_modele` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `aime` DROP FOREIGN KEY `fk_aime_modele`;

-- DropForeignKey
ALTER TABLE `aime` DROP FOREIGN KEY `fk_aime_utilisateur`;

-- DropForeignKey
ALTER TABLE `commentaire` DROP FOREIGN KEY `fk_commentaire_modele`;

-- DropForeignKey
ALTER TABLE `commentaire` DROP FOREIGN KEY `fk_commentaire_utilisateur`;

-- DropForeignKey
ALTER TABLE `favori` DROP FOREIGN KEY `fk_favori_modele`;

-- DropForeignKey
ALTER TABLE `favori` DROP FOREIGN KEY `fk_favori_utilisateur`;

-- DropForeignKey
ALTER TABLE `image_modele` DROP FOREIGN KEY `fk_image_modele`;

-- DropForeignKey
ALTER TABLE `modele_3d` DROP FOREIGN KEY `fk_modele_categorie`;

-- DropForeignKey
ALTER TABLE `modele_3d` DROP FOREIGN KEY `fk_modele_licence`;

-- DropForeignKey
ALTER TABLE `modele_3d` DROP FOREIGN KEY `fk_modele_utilisateur`;

-- DropForeignKey
ALTER TABLE `signalement` DROP FOREIGN KEY `fk_signalement_modele`;

-- DropForeignKey
ALTER TABLE `signalement` DROP FOREIGN KEY `fk_signalement_utilisateur`;

-- DropForeignKey
ALTER TABLE `utilisateur` DROP FOREIGN KEY `fk_utilisateur_role`;

-- DropForeignKey
ALTER TABLE `vue_modele` DROP FOREIGN KEY `fk_vue_modele`;

-- DropTable
DROP TABLE `aime`;

-- DropTable
DROP TABLE `categorie`;

-- DropTable
DROP TABLE `commentaire`;

-- DropTable
DROP TABLE `favori`;

-- DropTable
DROP TABLE `image_modele`;

-- DropTable
DROP TABLE `licence`;

-- DropTable
DROP TABLE `modele_3d`;

-- DropTable
DROP TABLE `role`;

-- DropTable
DROP TABLE `signalement`;

-- DropTable
DROP TABLE `utilisateur`;

-- DropTable
DROP TABLE `vue_modele`;

-- CreateTable
CREATE TABLE `roles` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(255) NULL,

    UNIQUE INDEX `roles_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(180) NOT NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `username` VARCHAR(50) NOT NULL,
    `first_name` VARCHAR(100) NULL,
    `last_name` VARCHAR(100) NULL,
    `bio` TEXT NULL,
    `avatar_key` VARCHAR(500) NULL,
    `gdpr_accepted_at` DATETIME(3) NULL,
    `email_verified_at` DATETIME(3) NULL,
    `failed_login_attempts` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    `locked_until` DATETIME(3) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `deleted_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `role_id` INTEGER UNSIGNED NOT NULL,

    UNIQUE INDEX `users_email_key`(`email`),
    UNIQUE INDEX `users_username_key`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subscriptions` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `plan` VARCHAR(30) NOT NULL DEFAULT 'premium_monthly',
    `status` ENUM('active', 'canceled', 'expired') NOT NULL DEFAULT 'active',
    `starts_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ends_at` DATETIME(3) NOT NULL,
    `payment_reference` VARCHAR(255) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `user_id` INTEGER UNSIGNED NOT NULL,

    INDEX `subscriptions_user_id_ends_at_idx`(`user_id`, `ends_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_tokens` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` ENUM('email_verification', 'password_reset') NOT NULL,
    `token_hash` CHAR(64) NOT NULL,
    `expires_at` DATETIME(3) NOT NULL,
    `used_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `user_id` INTEGER UNSIGNED NOT NULL,

    UNIQUE INDEX `user_tokens_token_hash_key`(`token_hash`),
    INDEX `user_tokens_user_id_type_idx`(`user_id`, `type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `refresh_tokens` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `token_hash` CHAR(64) NOT NULL,
    `expires_at` DATETIME(3) NOT NULL,
    `revoked_at` DATETIME(3) NULL,
    `user_agent` VARCHAR(255) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `user_id` INTEGER UNSIGNED NOT NULL,

    UNIQUE INDEX `refresh_tokens_token_hash_key`(`token_hash`),
    INDEX `refresh_tokens_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_links` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `platform` ENUM('website', 'artstation', 'sketchfab', 'instagram', 'youtube', 'x') NOT NULL,
    `url` VARCHAR(500) NOT NULL,
    `user_id` INTEGER UNSIGNED NOT NULL,

    UNIQUE INDEX `user_links_user_id_platform_key`(`user_id`, `platform`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `follows` (
    `follower_id` INTEGER UNSIGNED NOT NULL,
    `creator_id` INTEGER UNSIGNED NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `follows_creator_id_idx`(`creator_id`),
    PRIMARY KEY (`follower_id`, `creator_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categories` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `parent_id` INTEGER UNSIGNED NULL,

    UNIQUE INDEX `categories_slug_key`(`slug`),
    UNIQUE INDEX `categories_parent_id_name_key`(`parent_id`, `name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `licenses` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(120) NOT NULL,
    `commercial_use` BOOLEAN NOT NULL DEFAULT false,
    `modifications_allowed` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `licenses_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tags` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,

    UNIQUE INDEX `tags_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `models` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(150) NOT NULL,
    `slug` VARCHAR(180) NOT NULL,
    `description` TEXT NULL,
    `status` ENUM('draft', 'published', 'removed') NOT NULL DEFAULT 'draft',
    `visibility` ENUM('public', 'unlisted', 'private') NOT NULL DEFAULT 'public',
    `model_type` ENUM('cgi', 'print_3d') NOT NULL DEFAULT 'cgi',
    `is_premium` BOOLEAN NOT NULL DEFAULT false,
    `is_downloadable` BOOLEAN NOT NULL DEFAULT true,
    `allow_comments` BOOLEAN NOT NULL DEFAULT true,
    `is_ai_generated` BOOLEAN NOT NULL DEFAULT false,
    `is_age_restricted` BOOLEAN NOT NULL DEFAULT false,
    `has_textures` BOOLEAN NOT NULL DEFAULT false,
    `has_materials` BOOLEAN NOT NULL DEFAULT false,
    `is_pbr` BOOLEAN NOT NULL DEFAULT false,
    `is_rigged` BOOLEAN NOT NULL DEFAULT false,
    `is_animated` BOOLEAN NOT NULL DEFAULT false,
    `is_game_ready` BOOLEAN NOT NULL DEFAULT false,
    `uv_unwrapping` ENUM('yes', 'no', 'overlapping', 'mixed') NULL,
    `geometry` ENUM('polygon_mesh', 'subdivision', 'nurbs', 'mixed') NULL,
    `polygon_count` INTEGER UNSIGNED NULL,
    `vertex_count` INTEGER UNSIGNED NULL,
    `software` VARCHAR(100) NULL,
    `plugins_used` VARCHAR(255) NULL,
    `version` VARCHAR(20) NOT NULL DEFAULT '1.0',
    `download_count` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `view_count` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `published_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `user_id` INTEGER UNSIGNED NOT NULL,
    `category_id` INTEGER UNSIGNED NOT NULL,
    `license_id` INTEGER UNSIGNED NOT NULL,

    UNIQUE INDEX `models_slug_key`(`slug`),
    INDEX `models_status_visibility_published_at_idx`(`status`, `visibility`, `published_at`),
    INDEX `models_category_id_idx`(`category_id`),
    INDEX `models_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `model_files` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `file_name` VARCHAR(255) NOT NULL,
    `format` ENUM('glb', 'gltf', 'fbx', 'obj', 'stl', 'blend', 'usdz') NOT NULL,
    `mime_type` VARCHAR(100) NOT NULL,
    `size_bytes` BIGINT UNSIGNED NOT NULL,
    `checksum_sha256` CHAR(64) NULL,
    `storage_key` VARCHAR(500) NOT NULL,
    `upload_status` ENUM('pending', 'uploaded', 'rejected') NOT NULL DEFAULT 'pending',
    `uploaded_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `model_id` INTEGER UNSIGNED NOT NULL,

    UNIQUE INDEX `model_files_storage_key_key`(`storage_key`),
    INDEX `model_files_model_id_idx`(`model_id`),
    INDEX `model_files_format_idx`(`format`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `model_tags` (
    `model_id` INTEGER UNSIGNED NOT NULL,
    `tag_id` INTEGER UNSIGNED NOT NULL,

    INDEX `model_tags_tag_id_idx`(`tag_id`),
    PRIMARY KEY (`model_id`, `tag_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `model_images` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `storage_key` VARCHAR(500) NOT NULL,
    `mime_type` VARCHAR(50) NOT NULL,
    `position` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `upload_status` ENUM('pending', 'uploaded', 'rejected') NOT NULL DEFAULT 'pending',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `model_id` INTEGER UNSIGNED NOT NULL,

    UNIQUE INDEX `model_images_storage_key_key`(`storage_key`),
    UNIQUE INDEX `model_images_model_id_position_key`(`model_id`, `position`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `downloads` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `user_id` INTEGER UNSIGNED NOT NULL,
    `model_id` INTEGER UNSIGNED NOT NULL,
    `file_id` INTEGER UNSIGNED NULL,

    INDEX `downloads_user_id_created_at_idx`(`user_id`, `created_at`),
    INDEX `downloads_model_id_created_at_idx`(`model_id`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `model_views` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `ip_hash` CHAR(64) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `model_id` INTEGER UNSIGNED NOT NULL,

    INDEX `model_views_model_id_ip_hash_created_at_idx`(`model_id`, `ip_hash`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `comments` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `content` TEXT NOT NULL,
    `is_hidden` BOOLEAN NOT NULL DEFAULT false,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `user_id` INTEGER UNSIGNED NOT NULL,
    `model_id` INTEGER UNSIGNED NOT NULL,
    `parent_id` INTEGER UNSIGNED NULL,

    INDEX `comments_model_id_created_at_idx`(`model_id`, `created_at`),
    INDEX `comments_parent_id_idx`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ratings` (
    `user_id` INTEGER UNSIGNED NOT NULL,
    `model_id` INTEGER UNSIGNED NOT NULL,
    `score` TINYINT UNSIGNED NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    INDEX `ratings_model_id_idx`(`model_id`),
    PRIMARY KEY (`user_id`, `model_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `likes` (
    `user_id` INTEGER UNSIGNED NOT NULL,
    `model_id` INTEGER UNSIGNED NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `likes_model_id_idx`(`model_id`),
    PRIMARY KEY (`user_id`, `model_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `favorites` (
    `user_id` INTEGER UNSIGNED NOT NULL,
    `model_id` INTEGER UNSIGNED NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `favorites_model_id_idx`(`model_id`),
    PRIMARY KEY (`user_id`, `model_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `collections` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `description` VARCHAR(500) NULL,
    `is_public` BOOLEAN NOT NULL DEFAULT false,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `user_id` INTEGER UNSIGNED NOT NULL,

    INDEX `collections_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `collection_models` (
    `collection_id` INTEGER UNSIGNED NOT NULL,
    `model_id` INTEGER UNSIGNED NOT NULL,
    `added_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `collection_models_model_id_idx`(`model_id`),
    PRIMARY KEY (`collection_id`, `model_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reports` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `reason` VARCHAR(120) NOT NULL,
    `details` TEXT NULL,
    `status` ENUM('pending', 'resolved', 'rejected') NOT NULL DEFAULT 'pending',
    `resolved_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `user_id` INTEGER UNSIGNED NOT NULL,
    `model_id` INTEGER UNSIGNED NOT NULL,
    `resolved_by_id` INTEGER UNSIGNED NULL,

    INDEX `reports_status_created_at_idx`(`status`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `subscriptions` ADD CONSTRAINT `subscriptions_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_tokens` ADD CONSTRAINT `user_tokens_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `refresh_tokens` ADD CONSTRAINT `refresh_tokens_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_links` ADD CONSTRAINT `user_links_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `follows` ADD CONSTRAINT `follows_follower_id_fkey` FOREIGN KEY (`follower_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `follows` ADD CONSTRAINT `follows_creator_id_fkey` FOREIGN KEY (`creator_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `categories` ADD CONSTRAINT `categories_parent_id_fkey` FOREIGN KEY (`parent_id`) REFERENCES `categories`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `models` ADD CONSTRAINT `models_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `models` ADD CONSTRAINT `models_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `models` ADD CONSTRAINT `models_license_id_fkey` FOREIGN KEY (`license_id`) REFERENCES `licenses`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `model_files` ADD CONSTRAINT `model_files_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `model_tags` ADD CONSTRAINT `model_tags_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `model_tags` ADD CONSTRAINT `model_tags_tag_id_fkey` FOREIGN KEY (`tag_id`) REFERENCES `tags`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `model_images` ADD CONSTRAINT `model_images_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `downloads` ADD CONSTRAINT `downloads_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `downloads` ADD CONSTRAINT `downloads_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `downloads` ADD CONSTRAINT `downloads_file_id_fkey` FOREIGN KEY (`file_id`) REFERENCES `model_files`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `model_views` ADD CONSTRAINT `model_views_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comments` ADD CONSTRAINT `comments_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comments` ADD CONSTRAINT `comments_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comments` ADD CONSTRAINT `comments_parent_id_fkey` FOREIGN KEY (`parent_id`) REFERENCES `comments`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ratings` ADD CONSTRAINT `ratings_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ratings` ADD CONSTRAINT `ratings_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `likes` ADD CONSTRAINT `likes_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `likes` ADD CONSTRAINT `likes_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `favorites` ADD CONSTRAINT `favorites_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `favorites` ADD CONSTRAINT `favorites_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `collections` ADD CONSTRAINT `collections_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `collection_models` ADD CONSTRAINT `collection_models_collection_id_fkey` FOREIGN KEY (`collection_id`) REFERENCES `collections`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `collection_models` ADD CONSTRAINT `collection_models_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reports` ADD CONSTRAINT `reports_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reports` ADD CONSTRAINT `reports_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reports` ADD CONSTRAINT `reports_resolved_by_id_fkey` FOREIGN KEY (`resolved_by_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
