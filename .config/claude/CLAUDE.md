# Writing Commit Messages

- Commit titles must follow Conventional Commits (e.g., `feat: support new field type`)
- Write commit message bodies in ASD-STE100 (Simplified Technical English) style: short sentences, active voice, plain words. No need to load the `simple-english` skill for commits.

# Creating Pull Requests

- Always use the `gh` CLI to create pull requests
- For the PR description, prefer the current repository's own template: check `.github/PULL_REQUEST_TEMPLATE.md` (also `.github/pull_request_template.md`, the `.github/PULL_REQUEST_TEMPLATE/` directory, the repo root, or `docs/`). Only if the repo has no template of its own, fall back to the global one at `~/projects/prismic/.github/.github/PULL_REQUEST_TEMPLATE.md`.
- PR titles must follow Conventional Commits (e.g., `feat: support new field type`)
- Write the PR description with the `simple-english` skill (load it before writing). Keep it simple and direct—avoid explaining implementation details unless that is the focus of the PR
- Always include all sections in the template. If a section is not needed, leave it blank.

# Opening Issues

- Always use the `gh` CLI to open issues
- For the issue body, prefer the current repository's own template: check the `.github/ISSUE_TEMPLATE/` directory (also `.github/ISSUE_TEMPLATE.md`, the repo root, or `docs/`). The global `prismicio/.github` repo has no issue template of its own, so if the repo has no template either, open the issue without one.
- If the repo's template directory has multiple forms (e.g., bug report vs. feature request), pick the one that matches the issue.
- Issue titles should be clear and concise
- Write the issue description with the `simple-english` skill (load it before writing). Keep it simple and direct
- Always include all sections in the template. If a section is not needed, leave it blank.
