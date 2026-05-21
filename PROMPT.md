# Daily run prompt

Paste the block below into Claude (or `/loop 24h <prompt>` while a session is open).

---

You are running the daily gaming-peripherals watch for project `d:\03_Claude\Research\gaming-peripherals-watch`.

**Steps:**
1. Read `sources.md` for the brand list.
2. Run the two searches below.
3. Write findings to `reports/YYYY-MM-DD.html` using the template in `reports/2026-05-20.html` as the exact structural reference (same CSS classes, same section order, same card markup). Use today's actual date in the filename and the page title.
4. Update `index.html` — add a new `<li class="index-card">` at the TOP of the `<ul class="index-list">`, with today's date, a one-line summary, and stat counts. Remove the "Sample report" entry if it's still there.

## Search 1 — New product announcements (last 24–48 hours)
Search for new gaming mice and keyboard announcements, launches, or leaks from any brand in `sources.md`. Prefer official press releases, brand newsrooms, and reputable outlets (The Verge, Tom's Hardware, PCGamer, RTINGS). Skip rumors older than 48 hours and skip products already covered in the last 7 days of reports.

For each finding capture: brand, product name, category (mouse/keyboard), key specs (sensor / switches / wireless / weight / battery / polling), MSRP if known, availability date, source URL, source type tag (Press release / Launch / Leak / Teaser / Event coverage).

## Search 2 — Logitech feedback signals
Search for wishlist requests, feature requests, and complaints about Logitech gaming mice and keyboards posted in the last 7 days. Cover: r/LogitechG, r/MouseReview, r/MechanicalKeyboards, Logitech community forums, recent YouTube review comments, X/Twitter mentions of @LogitechG.

Group findings into **Complaints**, **Wishlist**, **Comparisons**. For each, capture: SKU, summary (1–2 sentences), source URL, sentiment volume (low/medium/high based on whether it's a single mention vs recurring theme).

## HTML output rules

- Stylesheet path from a report file is `../assets/style.css`. Theme script path is `../assets/theme.js`. Include both, plus the early-theme inline script in `<head>`. Copy these verbatim from the sample.
- Do not inline styles or invent classes — reuse what's in the sample.
- Every card must include a `<div class="card-logo"><img src="https://www.google.com/s2/favicons?domain={BRAND_DOMAIN}&sz=128" alt="{BRAND}" loading="lazy"></div>` block. Use the brand's primary domain (razer.com, logitech.com, wooting.io, lamzu.com, asus.com, corsair.com, steelseries.com, hyperx.com, roccat.com, glorious.gg, pulsar.gg, endgamegear.com, zowie.benq.com, etc.).
- Card category tag: `tag category-mouse` for mice, `tag category-keyboard` for keyboards.
- Volume tag: `tag vol-high`, `tag vol-medium`, or `tag vol-low`.
- If a section has zero findings, render `<p class="empty">No new findings.</p>` inside that column/grid rather than omitting the section.
- Always include the "Today's takeaways" notes block at the end — one or two sentences linking the day's signals to something actionable.
- Update strip at top must show: generated timestamp, announcement count, and Logitech signal breakdown (X complaints · Y wishlist · Z comparisons).
- Use real source URLs in `<a href="..." target="_blank" rel="noopener">`. Never use `#` placeholder in real reports. The whole announcement card is clickable via stretched-link CSS — the footer source URL is the destination, so it must be the canonical link for that finding.
- Feedback items in the Complaints / Wishlist / Comparisons columns are also clickable via stretched-link. Each feedback item must have exactly ONE `<a>` inside its `.meta` block, and that link must be the canonical source URL for that signal.
- The theme-toggle button block (two SVG icons) must be present in the topbar — copy verbatim from the sample.
- Topbar nav for report pages: `<a href="../index.html">← All reports</a>` and `<a href="../about.html">About</a>`. Do not link to .md files from HTML pages — they render as raw text in browsers.

## Index update rules

- Newest at top.
- Stats line: `<span>X announcements</span><span>Y complaints</span><span>Z wishlist</span>` matching the day's totals.
- Update count display if needed.

Keep prose tight — bullets and short summaries, not paragraphs. Match the visual density of the sample report.
