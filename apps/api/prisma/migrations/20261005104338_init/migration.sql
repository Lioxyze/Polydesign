-- CreateTable
CREATE TABLE `role` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL,
    `description` VARCHAR(255) NULL,

    UNIQUE INDEX `role_nom_key`(`nom`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categorie` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(80) NOT NULL,

    UNIQUE INDEX `categorie_nom_key`(`nom`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `licence` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(50) NOT NULL,
    `nom` VARCHAR(120) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `utilisateur` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(180) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `username` VARCHAR(50) NOT NULL,
    `first_name` VARCHAR(100) NULL,
    `last_name` VARCHAR(100) NULL,
    `bio` TEXT NULL,
    `avatar_url` VARCHAR(500) NULL,
    `is_creator` BOOLEAN NOT NULL DEFAULT false,
    `is_premium` BOOLEAN NOT NULL DEFAULT false,
    `premium_until` DATETIME(0) NULL,
    `gdpr_accepted_at` DATETIME(0) NULL,
    `active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `role_id` INTEGER UNSIGNED NOT NULL,

    UNIQUE INDEX `utilisateur_email_key`(`email`),
    UNIQUE INDEX `utilisateur_username_key`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `modele_3d` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `titre` VARCHAR(150) NOT NULL,
    `description` TEXT NULL,
    `fichier_url` VARCHAR(500) NOT NULL,
    `thumbnail_url` VARCHAR(500) NULL,
    `downloads` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `vues` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `prix` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    `est_premium` BOOLEAN NOT NULL DEFAULT false,
    `polycount` INTEGER UNSIGNED NULL,
    `logiciel` VARCHAR(100) NULL,
    `est_rigge` BOOLEAN NOT NULL DEFAULT false,
    `est_anime` BOOLEAN NOT NULL DEFAULT false,
    `usage_commercial` BOOLEAN NOT NULL DEFAULT false,
    `modifications_autorisees` BOOLEAN NOT NULL DEFAULT false,
    `statut` ENUM('brouillon', 'en_revision', 'publie', 'retire') NOT NULL DEFAULT 'brouillon',
    `version` VARCHAR(20) NULL,
    `publie_le` DATETIME(0) NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `utilisateur_id` INTEGER UNSIGNED NOT NULL,
    `categorie_id` INTEGER UNSIGNED NOT NULL,
    `licence_id` INTEGER UNSIGNED NOT NULL,

    INDEX `idx_modele_statut`(`statut`),
    INDEX `idx_modele_categorie`(`categorie_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `image_modele` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `image_url` VARCHAR(500) NOT NULL,
    `position` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `modele_id` INTEGER UNSIGNED NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vue_modele` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `adresse_ip` VARCHAR(45) NOT NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modele_id` INTEGER UNSIGNED NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `commentaire` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `contenu` TEXT NOT NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `utilisateur_id` INTEGER UNSIGNED NOT NULL,
    `modele_id` INTEGER UNSIGNED NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `signalement` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `raison` VARCHAR(120) NOT NULL,
    `details` TEXT NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `utilisateur_id` INTEGER UNSIGNED NOT NULL,
    `modele_id` INTEGER UNSIGNED NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `aime` (
    `utilisateur_id` INTEGER UNSIGNED NOT NULL,
    `modele_id` INTEGER UNSIGNED NOT NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`utilisateur_id`, `modele_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `favori` (
    `utilisateur_id` INTEGER UNSIGNED NOT NULL,
    `modele_id` INTEGER UNSIGNED NOT NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`utilisateur_id`, `modele_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `utilisateur` ADD CONSTRAINT `fk_utilisateur_role` FOREIGN KEY (`role_id`) REFERENCES `role`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `modele_3d` ADD CONSTRAINT `fk_modele_utilisateur` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `modele_3d` ADD CONSTRAINT `fk_modele_categorie` FOREIGN KEY (`categorie_id`) REFERENCES `categorie`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `modele_3d` ADD CONSTRAINT `fk_modele_licence` FOREIGN KEY (`licence_id`) REFERENCES `licence`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `image_modele` ADD CONSTRAINT `fk_image_modele` FOREIGN KEY (`modele_id`) REFERENCES `modele_3d`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vue_modele` ADD CONSTRAINT `fk_vue_modele` FOREIGN KEY (`modele_id`) REFERENCES `modele_3d`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `commentaire` ADD CONSTRAINT `fk_commentaire_utilisateur` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `commentaire` ADD CONSTRAINT `fk_commentaire_modele` FOREIGN KEY (`modele_id`) REFERENCES `modele_3d`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `signalement` ADD CONSTRAINT `fk_signalement_utilisateur` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `signalement` ADD CONSTRAINT `fk_signalement_modele` FOREIGN KEY (`modele_id`) REFERENCES `modele_3d`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `aime` ADD CONSTRAINT `fk_aime_utilisateur` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `aime` ADD CONSTRAINT `fk_aime_modele` FOREIGN KEY (`modele_id`) REFERENCES `modele_3d`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `favori` ADD CONSTRAINT `fk_favori_utilisateur` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `favori` ADD CONSTRAINT `fk_favori_modele` FOREIGN KEY (`modele_id`) REFERENCES `modele_3d`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
