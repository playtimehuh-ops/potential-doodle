# SnackDrop

A responsive, single-page snack poll built with HTML, CSS, JavaScript and Supabase. No build step required.

## Connect the database

1. Open your Supabase project and go to **SQL Editor**.
2. Paste and run the contents of `supabase/schema.sql`.
3. Open **Project Settings → API Keys** (or the API settings page) and copy your **Project URL** and a **publishable key**. The older `anon` key is also suitable for browser use.
4. In `index.html`, replace `PASTE_YOUR_PROJECT_URL_HERE` and `PASTE_YOUR_PUBLISHABLE_OR_ANON_KEY_HERE` with those values.
5. Commit the edit and deploy the repository as a static site (Vercel or GitHub Pages).

**Never put a Supabase `service_role` or secret key in browser code.** The public key is usable in a browser because Row Level Security is enabled and the policy only allows anonymous inserts.

## View results

In Supabase, open **Table Editor → snack_survey_responses** to view submitted votes. To see totals by snack, run:

```sql
select snack, count(*) as votes
from public.snack_survey_responses
group by snack
order by votes desc;
```

The public site cannot read the results; this avoids exposing respondents' submissions. Results stay in your Supabase dashboard.

## Fields collected

Snack choice, price preference, buying frequency, optional suggested snack, and submission timestamp. No name, email, or phone number is requested.
