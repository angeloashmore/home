# Creating Pull Requests

- Always use the `gh` CLI to create pull requests
- For the PR description, prefer the current repository's own template: check `.github/PULL_REQUEST_TEMPLATE.md` (also `.github/pull_request_template.md`, the `.github/PULL_REQUEST_TEMPLATE/` directory, the repo root, or `docs/`). Only if the repo has no template of its own, fall back to the global one at `/Users/angeloashmore/projects/prismic/.github/.github/PULL_REQUEST_TEMPLATE.md`.
- PR titles must follow Conventional Commits (e.g., `feat: support new field type`)
- PR descriptions should be simple and direct—avoid explaining implementation details unless that is the focus of the PR
- Always include all sections in the template. If a section is not needed, leave it blank.
