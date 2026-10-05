ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_score_check` CHECK (`score` BETWEEN 1 AND 5);

ALTER TABLE `model_files`
  ADD CONSTRAINT `model_files_size_bytes_check` CHECK (`size_bytes` > 0);

ALTER TABLE `models`
  ADD CONSTRAINT `models_published_at_check` CHECK (`status` <> 'published' OR `published_at` IS NOT NULL);

ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_period_check` CHECK (`ends_at` > `starts_at`);
