# Daily run prompt

Paste the block below into Claude (or `/loop 24h <prompt>` while a session is open).

---

You are running the daily gaming-peripherals watch for project `d:\03_Claude\Research\gaming-peripherals-watch`.

**Steps:**
1. Read `sources.md` for the brand list (4 categories: Mice, Keyboards, Sim gear, Controllers).
2. Run the two searches below.
3. Write findings to `reports/YYYY-MM-DD.html` using the template in `reports/2026-05-20.html` as the exact structural reference (same CSS classes, same section order, same subsection markup, same card markup). Use today's actual date in the filename and the page title.
4. Update `index.html` — add a new `<li class="index-card">` at the TOP of the `<ul class="index-list">`, with today's date, a one-line summary, and stat counts. Remove the "Sample report" entry if it's still there.

## Search 1 — New product announcements (last 24–48 hours)

Search for new announcements, launches, or leaks across **four product categories** from any brand in `sources.md`:

- **Mice** — gaming mice (wired / wireless / superlight / esports).
- **Keyboards** — gaming keyboards (mech, optical, magnetic / Hall-effect).
- **Sim gear** — sim racing wheels, pedals, wheelbases (direct drive / belt / gear), shifters, handbrakes.
- **Controllers** — gamepads for console / PC / mobile (Xbox, PlayStation, Switch, third-party pro controllers, mobile clip controllers).

Prefer official press releases, brand newsrooms, and reputable outlets (The Verge, Tom's Hardware, PCGamer, RTINGS, Eurogamer, Push Square, Pure Xbox; for sim: Boosted Media, Sim Racing Today, Race Department, OverTake). Skip rumors older than 48 hours and skip products already covered in the last 7 days of reports.

For each finding capture: brand, product name, category, key specs (category-appropriate — e.g. sensor/switches for mice/keyboards; torque/rotation/connection for sim wheels; sticks/triggers/connectivity for controllers), MSRP if known, availability date, source URL, source type tag (Press release / Launch / Leak / Teaser / Event coverage).

## Search 2 — Logitech feedback signals

Search for wishlist requests, feature requests, and complaints about **Logitech G gaming mice, keyboards, AND sim gear** posted in the last 7 days. Cover the full Logitech G gaming line:

- Mice (G Pro X Superlight, G502, G703, G305)
- Keyboards (G Pro, G915, G715, Pro X TKL Rapid)
- Sim wheels (G PRO Racing Wheel, G29, G920, G923)

Skip Logitech controllers (F310/F710 are EOL / niche, not worth tracking).

Sources: r/LogitechG, r/MouseReview, r/MechanicalKeyboards, r/simracing, r/Logitech_G_Sim, Logitech community forums, recent YouTube review comments (incl. Boosted Media / Super GT for sim), X/Twitter mentions of @LogitechG, **Amazon customer reviews** for current Logitech G gaming SKUs (look at recent 1–3 star reviews for complaints, and "verified purchase" reviewer wishlists in the body text).

Group findings into **Complaints**, **Wishlist**, **Comparisons**. For each, capture: SKU, summary (1–2 sentences), source URL, sentiment volume (low/medium/high based on whether it's a single mention vs recurring theme).

## HTML output rules

- Stylesheet path from a report file is `../assets/style.css`. Theme script path is `../assets/theme.js`. Include both, plus the early-theme inline script in `<head>`. Copy these verbatim from the sample.
- Do not inline styles or invent classes — reuse what's in the sample.
- Every card must include a `<div class="card-logo"><img src="https://www.google.com/s2/favicons?domain={BRAND_DOMAIN}&sz=128" alt="{BRAND}" loading="lazy"></div>` block. Use the brand's primary domain (razer.com, logitech.com, wooting.io, lamzu.com, asus.com, corsair.com, steelseries.com, hyperx.com, roccat.com, glorious.gg, pulsar.gg, endgamegear.com, zowie.benq.com, fanatec.com, moza-racing.com, thrustmaster.com, simagic.com, asetek.com, simucube.com, heusinkveld.com, xbox.com, playstation.com, nintendo.com, 8bitdo.com, gamesir.hk, scufgaming.com, playbackbone.com, turtlebeach.com, hori.jp, etc.).
- **Section 1 structure — four subsections.** Wrap Section 1's content in exactly four `<div class="subsection">` blocks in this order: Mice, Keyboards, Sim Gear, Controllers. Each subsection has:
  ```html
  <div class="subsection">
    <h3 class="subhead">{Category} <span class="subcount">{N} items</span></h3>
    <div class="grid">
      <!-- cards, or <p class="empty">No new findings.</p> if zero -->
    </div>
  </div>
  ```
  Empty subsections still render — never omit a category.
- Card category tag classes:
  - `tag category-mouse` for mice
  - `tag category-keyboard` for keyboards
  - `tag category-sim` for sim gear
  - `tag category-controller` for controllers
- Volume tag: `tag vol-high`, `tag vol-medium`, or `tag vol-low`.
- If a Logitech feedback column (Complaints / Wishlist / Comparisons) has zero findings, render `<p class="empty">No new findings.</p>` inside that column rather than omitting the column.
- Always include the "Today's takeaways" notes block at the end — one or two sentences linking the day's signals to something actionable. Cross-category observations (e.g., "Logitech and Fanatec both refreshed mid-tier wheels this week") are valuable.
- Update strip at top must show: generated timestamp, per-category announcement counts, and Logitech signal breakdown. Format:
  ```
  Generated: {timestamp} · Mice: {N} · Keyboards: {N} · Sim: {N} · Controllers: {N} · Logitech signals: {X complaints · Y wishlist · Z comparisons}
  ```
- Use real source URLs in `<a href="..." target="_blank" rel="noopener">`. Never use `#` placeholder in real reports. The whole announcement card is clickable via stretched-link CSS — the footer source URL is the destination, so it must be the canonical link for that finding.
- Feedback items in the Complaints / Wishlist / Comparisons columns are also clickable via stretched-link. Each feedback item must have exactly ONE `<a>` inside its `.meta` block, and that link must be the canonical source URL for that signal.
- **Deep-link requirement for feedback sources.** The `<a>` URL must point to the SPECIFIC thread / post / comment / review that contains the signal — never to a landing page or homepage. Examples of correct vs wrong:
  - ✅ `https://www.reddit.com/r/LogitechG/comments/1abc234/g_pro_x_superlight_2_scroll_wheel_issue/`
  - ❌ `https://www.reddit.com/r/LogitechG/` (subreddit homepage)
  - ✅ `https://www.youtube.com/watch?v=xxxxxxxxxxx&lc=UgxAbCdEf...` (deep-linked comment)
  - ❌ `https://www.youtube.com/@RocketJumpNinja` (channel page)
  - ✅ `https://www.amazon.com/gp/customer-reviews/R1A2B3C4D5E6F7/` (specific review)
  - ❌ `https://www.amazon.com/dp/B0XXXXX/` (product page)
  - ✅ `https://x.com/username/status/1234567890123456789` (specific post)
  - ❌ `https://x.com/LogitechG` (profile page)
  - ✅ `https://community.logitech.com/s/question/0D5...../some-thread-title` (specific thread)
  - ❌ `https://community.logitech.com/` (forum root)

  If you cannot produce a deep link to the originating thread/post/comment/review, **omit the finding entirely** — do not list it with a fallback to a landing page. A shorter, fully-linkable report is better than padding with unverifiable items.

  **Cross-thread / recurring-theme exception.** When a feedback item summarizes a sentiment seen across MULTIPLE threads (not one specific post), you MAY link to a Reddit search URL that surfaces those threads. The search URL must include `restrict_sr=1` and a relevant query — never a bare subreddit. Examples:
  - ✅ `https://www.reddit.com/r/LogitechG/search/?q=PowerPlay&restrict_sr=1&sort=new`
  - ✅ `https://www.reddit.com/r/simracing/search/?q=Logitech+G923+successor&restrict_sr=1&sort=new`
  - ❌ `https://www.reddit.com/r/LogitechG/` (bare subreddit — FORBIDDEN even for cross-thread themes)
  - ❌ `https://www.reddit.com/r/LogitechG/top/` (sorted subreddit landing — also forbidden)

  Bare subreddit / channel / forum-root URLs are never acceptable. If you cannot deep-link AND cannot construct a search URL that surfaces the signal, omit the item.
- The theme-toggle button block (two SVG icons) must be present in the topbar — copy verbatim from the sample.
- Topbar nav for report pages: `<a href="../index.html">← All reports</a>` and `<a href="../about.html">About</a>`. Do not link to .md files from HTML pages — they render as raw text in browsers.

## Index update rules

- Newest at top.
- Stats line: `<span>X announcements</span><span>Y complaints</span><span>Z wishlist</span>` where X is the sum across all four categories.
- Update count display if needed.

Keep prose tight — bullets and short summaries, not paragraphs. Match the visual density of the sample report.
