# Mindkeep Logo Integration Design

## Goal

Replace the temporary Lucide brand mark with the provided Mindkeep SVG in the app shell, covering the sidebar brand area and the browser tab icon.

## Scope

- Add the provided SVG to the repository as the canonical brand asset.
- Replace the sidebar header Lucide icon with the brand SVG while keeping the `Mindkeep` wordmark.
- Wire the browser tab icon to the same brand asset.
- Add a regression test that checks brand asset wiring in `index.html`.

## Decisions

- Use the provided SVG directly as the source of truth instead of recreating the logo in CSS or SVG code.
- Keep the existing `Mindkeep` text label beside the logo to preserve current information hierarchy.
- Use SVG favicon wiring in `index.html` so the browser tab icon stays visually consistent with the sidebar branding.

## Risks

- Some browsers may render SVG favicons differently, but this is acceptable for the current static app and keeps the asset pipeline minimal.
- The provided file name contains a space, so the repo copy should use a sanitized asset path.
