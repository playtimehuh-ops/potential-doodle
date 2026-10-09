-- SnackDrop survey database
-- Run in Supabase Dashboard -> SQL Editor.
create table if not exists public.snack_survey_responses (
  id bigint generated always as identity primary key,
  snack text not null check (snack in ('Blue Takis', 'Red Takis', 'KitKat', 'Sour Patch Kids', 'Skittles', 'Other')),
  price text not null check (price in ('5 SAR', '6 SAR', '7 SAR', '8+ SAR')),
  frequency text not null check (frequency in ('Every day', 'A few times a week', 'Once a week', 'Occasionally')),
  other_snack text check (other_snack is null or char_length(other_snack) <= 100),
  created_at timestamptz not null default now()
);

alter table public.snack_survey_responses enable row level security;
revoke all on table public.snack_survey_responses from anon, authenticated;
grant insert on table public.snack_survey_responses to anon;
grant usage, select on sequence public.snack_survey_responses_id_seq to anon;

drop policy if exists "Anyone can submit snack votes" on public.snack_survey_responses;
create policy "Anyone can submit snack votes"
on public.snack_survey_responses for insert to anon
with check (
  snack in ('Blue Takis', 'Red Takis', 'KitKat', 'Sour Patch Kids', 'Skittles', 'Other')
  and price in ('5 SAR', '6 SAR', '7 SAR', '8+ SAR')
  and frequency in ('Every day', 'A few times a week', 'Once a week', 'Occasionally')
);

-- Owner-only results: view rows in Table Editor, or run:
-- select snack, count(*) as votes from public.snack_survey_responses group by snack order by votes desc;
