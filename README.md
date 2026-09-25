# BillRemind — ASP.NET Web Forms (.NET Framework)

A Bill Payment Reminder System with a sidebar dashboard UI, built on classic ASP.NET Web Forms (.NET Framework 4.8). Every element is wired to real, working code — no placeholder/static UI.

## Features

- **Authentication**: Login and Logout functionality using Session variables.
- **Dashboard**: Live summary cards, upcoming bills table, a mini calendar, and quick-action links.
- **Calendar View**: Full month view with functioning Prev/Next navigation. Click any day to see the bills due that day.
- **Bill Management (My Bills)**: Full list with working search, category filters, status filters, plus Edit and Delete capabilities.
- **Payment History**: View paid bills and mark them as pending if needed.
- **Reports**: View totals and pending amount breakdowns by category.
- **User Settings & Profile**: Edit display name, set default reminder windows for new bills, and a "Clear all my bills" action.
- **Data Storage**: Bills are currently stored in-memory on the server (`App_Code/BillRepository.cs`), so no database setup is required to run the demo.

## How to Run

1. **Prerequisites**: Windows + Visual Studio with the "ASP.NET and web development" workload.
2. Clone this repository to your local machine.
3. Open Visual Studio.
4. Go to **File → Open → Web Site...** and select the inner `BillLedgerWebForms/BillLedgerWebForms` folder.
5. Press **F5** to start the application. It will open to `Login.aspx`.
6. Enter any username to sign in and view the Dashboard.
