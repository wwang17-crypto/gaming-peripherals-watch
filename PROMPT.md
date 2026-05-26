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

**Date-freshness rule (critical — verify before including any finding).** The source article's publish date must be within the last 48 hours of today (today = the date in this prompt). Verify by checking each candidate URL:

- **Tech-press articles** (Tom's Hardware, PC Gamer, The Verge, etc.) — look for the byline date ("Published Jan 12, 2024" style) or the `<meta property="article:published_time">` tag. If the article is dated months/years ago, omit the finding even if the headline looks "new".
- **Brand newsroom press releases** — check the release date on the press page itself.
- **X / Twitter posts** — tweet timestamp is visible on the post.
- **Reddit / forum threads** — post date is visible.

Two failure modes this rule catches:
1. **Stale article masquerading as new** — the news genuinely IS old (e.g., a 2024 Tom's Hardware article surfacing again in 2026 search results). Omit the finding entirely.
2. **Today's news, wrong source** — the news is genuinely new but you cited an older article that mentioned the product tangentially. Find the actual recent source (today's press release, today's launch tweet, today's article) and use that URL instead.

The post-generation audit verifies this: any Section 1 source older than 7 days **aborts the commit** (the report does not get pushed). Articles 2–7 days old produce a warning but do not block. Don't ship findings whose source URL pre-dates the announcement by months or years.

**Empty Section 1 is acceptable — even expected on slow news days.** It is CORRECT (not a failure) for some or all Section 1 subsections to render `<p class="empty">No new findings.</p>`. A report shipped with 0 announcements across all four categories is a valid daily report. Do NOT pad Section 1 by reaching back to weeks-old or months-old launches just to fill the page. The bar for inclusion is "a fresh source from the last 48 hours exists" — if that bar isn't met, the item is omitted, full stop. A 0-announcement day with honest empty subsections is a valid report; a 4-announcement day held together by stale sources is not.

**Do not recycle prior reports.** If you find that a previous day's report covered a SKU and you cannot find genuinely fresh news for it today, do not re-list it. Section 1 is "what's new in the last 48 hours" — not "what's been newsworthy lately". Check the last 7 days of `reports/*.html` before listing any SKU.

For each finding capture: brand, product name, category, key specs (category-appropriate — e.g. sensor/switches for mice/keyboards; torque/rotation/connection for sim wheels; sticks/triggers/connectivity for controllers), MSRP if known, availability date, source URL, source type tag (Press release / Launch / Leak / Teaser / Event coverage).

## Search 2 — Logitech feedback signals

Search for wishlist requests, feature requests, and complaints about **Logitech G gaming mice, keyboards, AND sim gear** posted in the last 7 days. Cover the full Logitech G gaming line:

- Mice (G Pro X Superlight, G502, G703, G305)
- Keyboards (G Pro, G915, G715, Pro X TKL Rapid)
- Sim wheels (G PRO Racing Wheel, G29, G920, G923)

Skip Logitech controllers (F310/F710 are EOL / niche, not worth tracking).

Sources: r/LogitechG, r/MouseReview, r/MechanicalKeyboards, r/simracing, r/Logitech_G_Sim, Logitech community forums, recent YouTube review comments (incl. Boosted Media / Super GT for sim), X/Twitter mentions of @LogitechG, **Amazon customer reviews** for current Logitech G gaming SKUs (look at recent 1–3 star reviews for complaints, and "verified purchase" reviewer wishlists in the body text).

For each finding capture: **product category** (mouse / keyboard / sim gear), **sentiment** (Complaint / Wishlist / Comparison), SKU, summary (1–2 sentences), source URL, **sentiment volume** (low/medium/high based on whether it's a single mention vs recurring theme).

The report groups Section 2 findings by product category first (matching Section 1's structure), then surfaces sentiment via a per-item tag. There is no Logitech controller subsection content (F310/F710 are EOL — not tracked) — that subsection always renders empty.

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
- **Section 2 structure — four subsections (same shape as Section 1).** Wrap Section 2's content in exactly four `<div class="subsection">` blocks in this order: Mice, Keyboards, Sim Gear, Controllers. Each subsection wraps a `<div class="column">` containing a `<ul class="feedback-list">`. Pattern:
  ```html
  <div class="subsection">
    <h3 class="subhead">{Category} <span class="subcount">{N} items</span></h3>
    <div class="column">
      <ul class="feedback-list">
        <li class="feedback-item">
          <span class="sku">{SKU}</span>
          <p>{1–2 sentence summary}</p>
          <div class="meta">
            <span class="tag sent-{complaint|wishlist|comparison}">{Complaint|Wishlist|Comparison}</span>
            <span class="tag vol-{high|medium|low}">{High|Medium|Low} volume</span>
            <span><a href="{deep link}" target="_blank" rel="noopener">{source label}</a></span>
          </div>
        </li>
      </ul>
    </div>
  </div>
  ```
  For an empty subsection, omit the `<ul>` and put `<p class="empty">No new findings.</p>` directly inside the `<div class="column">`. The **Controllers subsection always renders empty** — Logitech gaming controllers (F310/F710) are EOL and not tracked. Use this body: `<p class="empty">No new findings. (Logitech gaming controllers — F310/F710 — are EOL and not tracked.)</p>`
- Sentiment tag classes (Section 2 only):
  - `tag sent-complaint` (red) for complaints
  - `tag sent-wishlist` (green) for wishlist / feature requests
  - `tag sent-comparison` (blue) for competitive comparisons
- Always include the "Today's takeaways" notes block at the end — one or two sentences linking the day's signals to something actionable. Cross-category observations (e.g., "Logitech and Fanatec both refreshed mid-tier wheels this week") are valuable.
- Update strip at top must show: generated timestamp, per-category announcement counts, and Logitech signal breakdown by sentiment. Format:
  ```
  Generated: {timestamp} · Mice: {N} · Keyboards: {N} · Sim: {N} · Controllers: {N} · Logitech signals: {X complaints · Y wishlist · Z comparisons}
  ```
  The Logitech-signals breakdown stays by sentiment (not by product) because product is already visible in each subsection header.
- Use real source URLs in `<a href="..." target="_blank" rel="noopener">`. Never use `#` placeholder in real reports. The whole announcement card is clickable via stretched-link CSS — the footer source URL is the destination, so it must be the canonical link for that finding.
- Section 2 feedback items are also clickable via stretched-link. Each feedback item must have exactly ONE `<a>` inside its `.meta` block, and that link must be the canonical source URL for that signal.
- **Deep-link requirement applies to BOTH sections.** The rule below covers Section 1 announcements AND Section 2 feedback items. Common Section 1 violations to avoid: `razer.com/newsroom` (brand newsroom root), `logitech.com/en-us` (brand homepage), `x.com/{brand}` (brand profile), `corsair.com/us/en/blog` (blog index). For an announcement, the canonical link is one of: the SPECIFIC press release page on the brand newsroom (e.g. `/newsroom/product-news/{product-slug}`), the brand's product detail page for the SKU, the specific tweet announcing the SKU, OR a specific tech-press article covering the launch. The same omit-if-can't-link rule applies — skip the announcement before linking to a landing page.
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

  **Cross-thread / recurring-theme exception.** When a feedback item summarizes a sentiment seen across MULTIPLE threads/videos/reviews (not one specific post), you MAY link to a search URL that surfaces those threads. The search URL must contain a relevant query specific to the signal — never a bare landing page. Accepted search-URL patterns per platform:

  - **Reddit:** `https://www.reddit.com/r/{sub}/search/?q={query}&restrict_sr=1&sort=new`
    - ✅ `https://www.reddit.com/r/LogitechG/search/?q=PowerPlay&restrict_sr=1&sort=new`
    - ❌ `https://www.reddit.com/r/LogitechG/` (bare subreddit)
    - ❌ `https://www.reddit.com/r/LogitechG/top/` (sorted landing)
  - **Logitech community forums (and other Salesforce/SAP-style forums where direct thread URLs are fragile):** `https://www.google.com/search?q=site%3Acommunity.logitech.com+{query}`
    - ✅ `https://www.google.com/search?q=site%3Acommunity.logitech.com+G915+X+dongle+disconnect`
    - ❌ `https://community.logitech.com/` (forum root)
  - **YouTube (for cross-video creator coverage):** `https://www.youtube.com/results?search_query={query}` — but prefer a specific video URL when one exists.
    - ✅ `https://www.youtube.com/results?search_query=Boosted+Media+PRO+Racing+Wheel+vs+Fanatec+CSL+DD`
    - ✅ `https://www.youtube.com/watch?v=xxxxxxxxxxx` (specific video — preferred)
    - ❌ `https://www.youtube.com/@BoostedMedia` (channel page)
  - **X / Twitter:** prefer a specific post URL. If summarizing a thread of replies, link the originating post, not the profile.
    - ❌ `https://x.com/LogitechG` (profile page)
  - **Amazon (for cross-review patterns on a single SKU):** the product reviews page anchored to the SKU is acceptable, but the bare product page is not.
    - ✅ `https://www.amazon.com/product-reviews/B0XXXXX/?filterByStar=one_star&reviewerType=verified_purchase` (filtered reviews — preferred for complaints)
    - ❌ `https://www.amazon.com/dp/B0XXXXX/` (bare product page)

  Bare subreddit / channel / forum-root / profile / product URLs are NEVER acceptable. If you cannot deep-link AND cannot construct a search URL that surfaces the signal, omit the item.
- The theme-toggle button block (two SVG icons) must be present in the topbar — copy verbatim from the sample.
- Topbar nav for report pages: `<a href="../index.html">← All reports</a>` and `<a href="../about.html">About</a>`. Do not link to .md files from HTML pages — they render as raw text in browsers.

## Index update rules

- Newest at top.
- Stats line: `<span>X announcements</span><span>Y complaints</span><span>Z wishlist</span>` where X is the sum across all four categories.
- Update count display if needed.

Keep prose tight — bullets and short summaries, not paragraphs. Match the visual density of the sample report.
