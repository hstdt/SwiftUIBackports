# Issue Tracker: GitHub

Issues and PRDs for this repo live as GitHub issues in `shaps80/SwiftUIBackports`. Use the `gh` CLI for operations when connector tools are not already handling GitHub work.

## Conventions

- Create an issue: `gh issue create --title "..." --body "..."`
- Read an issue: `gh issue view <number> --comments`
- List issues: `gh issue list --state open --json number,title,body,labels,comments`
- Comment on an issue: `gh issue comment <number> --body "..."`
- Apply or remove labels: `gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- Close an issue: `gh issue close <number> --comment "..."`

Infer the repo from `git remote -v`; `gh` does this automatically inside the clone.

## When A Skill Says "Publish To The Issue Tracker"

Create a GitHub issue.

## When A Skill Says "Fetch The Relevant Ticket"

Run `gh issue view <number> --comments`.

## Release Labels

Pull requests must have exactly one of:

- `release:major`
- `release:minor`

The GitHub Actions release label check fails if neither or both are present.
