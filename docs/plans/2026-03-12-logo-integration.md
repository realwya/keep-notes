# Mindkeep Logo Integration Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace the temporary Lucide brand mark with the provided Mindkeep SVG in the sidebar header and browser tab icon.

**Architecture:** Store the user-provided SVG as a static asset in the repo, reference it from `index.html` for both the sidebar brand image and the favicon, and keep a shell test that validates the wiring. Styling changes stay limited to the brand block in `styles.css`.

**Tech Stack:** Static HTML, CSS, shell-script tests with `rg`

---

### Task 1: Add a failing regression test

**Files:**
- Create: `tests/logo-branding.test.sh`
- Modify: none
- Test: `tests/logo-branding.test.sh`

**Step 1: Write the failing test**

Add checks that require:
- `index.html` to include a favicon link pointing at the Mindkeep logo asset
- `index.html` sidebar branding to use an `<img>` logo instead of the Lucide `book-open` icon

**Step 2: Run test to verify it fails**

Run: `bash tests/logo-branding.test.sh`
Expected: `FAIL` because the current markup still uses the Lucide icon and has no favicon wiring.

**Step 3: Write minimal implementation**

Add the logo asset to the repo and update `index.html` and `styles.css` to satisfy the test with minimal markup and styling changes.

**Step 4: Run test to verify it passes**

Run: `bash tests/logo-branding.test.sh`
Expected: `PASS`

### Task 2: Verify no regressions

**Files:**
- Modify: `index.html`, `styles.css`
- Test: `tests/*.test.sh`

**Step 1: Run the relevant existing tests**

Run: `bash tests/feather-icons.test.sh`
Expected: `PASS`

**Step 2: Run the full test suite**

Run: `bash tests/*.test.sh`
Expected: all tests pass.

**Step 3: Review the resulting diff**

Run: `git diff -- index.html styles.css tests/logo-branding.test.sh docs/plans/2026-03-12-logo-integration-design.md docs/plans/2026-03-12-logo-integration.md`
Expected: only the intended brand integration changes are present.
