create table progress (
  user_id uuid primary key references auth.users on delete cascade,
  marks jsonb not null default '{}',
  updated_at timestamptz not null default now()
);

alter table progress enable row level security;

create policy "own row" on progress
  for all using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
