# Git conventions

## Branches

- `main`: always stable, deployable
- one branch per feature or fix, created from `main`:
  - `feature/<short-name>`, e.g. `feature/auth-jwt`
  - `fix/<short-name>`, e.g. `fix/favorite-duplicate`
  - `chore/<short-name>`, `docs/<short-name>`

Branches are merged into `main` through a pull request once the CI is green.

## Commit messages

[Conventional Commits](https://www.conventionalcommits.org/), in English:

```
<type>(<scope>): <short summary in the imperative>

<optional body: what and why>
```

- **types**: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `ci`, `perf`, `style`
- **scopes**: `api`, `web`, `db`, or none for repository-wide changes

Examples:

```
feat(api): add JWT authentication
fix(web): keep the favorite state after a page reload
test(api): cover the model publication rules
```

## Before pushing

```bash
npm run lint
npm test
npm run format:check
```
