# Domain Docs

How engineering skills should consume this repo's domain documentation.

## Before Exploring, Read These

- `CONTEXT.md` at the repo root.
- Relevant ADRs under `docs/adr/`, if present.

If these files do not exist or no ADR matches the task area, proceed silently.

## File Structure

This is a single-context repo:

```text
/
|-- CONTEXT.md
|-- AGENTS.md
|-- docs/
|   |-- agents/
|   `-- adr/
`-- Sources/
    `-- SwiftUIBackports/
```

## Use Glossary Vocabulary

When output names a project concept, use the term as defined in `CONTEXT.md`. Do not drift to synonyms where the glossary has a preferred term.

If the needed concept is missing from the glossary, note the gap and add it only when the term is stable enough to help future work.

## Flag ADR Conflicts

If proposed work contradicts an ADR, surface the conflict explicitly before implementing.
