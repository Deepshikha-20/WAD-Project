# BillRemind — ASP.NET Web Forms (.NET Framework)

A Bill Payment Reminder System with a sidebar dashboard UI (matching the
BillRemind reference design), built on classic ASP.NET Web Forms
(.NET Framework 4.8). Every element is wired to real, working code — no
placeholder/static UI.

## How to run

1. **Requires Windows + Visual Studio** with the "ASP.NET and web
   development" workload (Web Forms/.NET Framework doesn't run on
   macOS/Linux — it needs IIS/IIS Express).
2. **File → Open → Web Site...** → select this `BillLedgerWebForms` folder.
3. Press **F5**. It opens to `Login.aspx`.
4. Enter any username (no password in this demo) → you land on the
   Dashboard.

Visual Studio auto-generates `.designer.cs` files the first time it opens
the project — that's expected for Web Site projects.

## Pages / features

- **Login / Logout** — `Session["Username"]` is set at login; every page
  (via `Site.Master`) checks `Session["Username"] == null` and redirects
  back to Login if not signed in. `Logout.aspx` calls `Session.Clear()` +
  `Session.Abandon()` before redirecting. Test it: sign in, browse around,
  hit Logout, then use the browser back button — you'll be bounced back to
  Login since the session is gone.
- **Dashboard** — 5 live summary cards, an upcoming-bills table (top 5,
  pulled from real data), a mini calendar (dots mark days with bills due,
  today is highlighted), and quick-action links.
- **Calendar** — full month view with working Prev/Next navigation and a
  "Jump to Today" button. Click any day to see the bills due that day in
  the side panel.
- **My Bills** — full list with **working** search-by-name, category
  filter, and status filter (all postback-driven, not client-side fakes),
  plus Edit/Delete.
- **Add / Edit Bill** — same page; `?id=` switches it into edit mode.
  New bills default their reminder window to whatever you set in Settings.
- **Payment History** — paid bills, with a "Mark as Pending" action to
  reverse a payment.
- **Reports** — totals plus a pending-amount breakdown by category.
- **Profile** — edit your display name (shown in the top-right avatar/chip).
- **Settings** — set your default reminder window for new bills, and a
  "Clear all my bills" danger action (with a confirm prompt).
- **Notification bell** — badge count of bills due within 3 days; links to
  the Reminders page.
- **Sidebar collapse** — the hamburger button collapses/expands the
  sidebar and remembers your choice (via `localStorage`, which is fine
  here since this is a real deployed site, not a sandboxed artifact).

## Data storage note

Bills are stored **in memory** on the server (`App_Code/BillRepository.cs`,
a thread-safe static list scoped by username) — no SQL Server setup
required, so you can run it immediately. Data resets if IIS restarts.
Say the word if you'd like it swapped for a SQL Server + Entity Framework
(or plain ADO.NET) backed repository instead — only that one file would
need to change.
