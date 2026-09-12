-- BÙI HOÀNG DỂ — Portfolio / Supabase setup
-- Có thể chạy lại an toàn trong Supabase SQL Editor.
-- Không cần service_role key trong website.

create table if not exists public.portfolio_state (
  id integer primary key check (id = 1),
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.portfolio_state enable row level security;

drop policy if exists "portfolio_state_public_read" on public.portfolio_state;
drop policy if exists "portfolio_state_admin_insert" on public.portfolio_state;
drop policy if exists "portfolio_state_admin_update" on public.portfolio_state;
drop policy if exists "portfolio_state_admin_delete" on public.portfolio_state;

create policy "portfolio_state_public_read"
on public.portfolio_state for select
using (true);

create policy "portfolio_state_admin_insert"
on public.portfolio_state for insert
to authenticated
with check (lower(coalesce(auth.jwt() ->> 'email','')) = 'hoangdeb751@gmail.com');

create policy "portfolio_state_admin_update"
on public.portfolio_state for update
to authenticated
using (lower(coalesce(auth.jwt() ->> 'email','')) = 'hoangdeb751@gmail.com')
with check (lower(coalesce(auth.jwt() ->> 'email','')) = 'hoangdeb751@gmail.com');

create policy "portfolio_state_admin_delete"
on public.portfolio_state for delete
to authenticated
using (lower(coalesce(auth.jwt() ->> 'email','')) = 'hoangdeb751@gmail.com');

insert into public.portfolio_state (id, state)
values (1, '{}'::jsonb)
on conflict (id) do nothing;

-- Storage bucket for public portfolio images.
insert into storage.buckets (id, name, public)
values ('portfolio-images', 'portfolio-images', true)
on conflict (id) do update set public = true;

drop policy if exists "portfolio_images_public_read" on storage.objects;
drop policy if exists "portfolio_images_admin_insert" on storage.objects;
drop policy if exists "portfolio_images_admin_update" on storage.objects;
drop policy if exists "portfolio_images_admin_delete" on storage.objects;

create policy "portfolio_images_public_read"
on storage.objects for select
to public
using (bucket_id = 'portfolio-images');

create policy "portfolio_images_admin_insert"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'portfolio-images'
  and lower(coalesce(auth.jwt() ->> 'email','')) = 'hoangdeb751@gmail.com'
);

create policy "portfolio_images_admin_update"
on storage.objects for update
to authenticated
using (
  bucket_id = 'portfolio-images'
  and lower(coalesce(auth.jwt() ->> 'email','')) = 'hoangdeb751@gmail.com'
)
with check (
  bucket_id = 'portfolio-images'
  and lower(coalesce(auth.jwt() ->> 'email','')) = 'hoangdeb751@gmail.com'
);

create policy "portfolio_images_admin_delete"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'portfolio-images'
  and lower(coalesce(auth.jwt() ->> 'email','')) = 'hoangdeb751@gmail.com'
);

-- Quick verification after running:
select
  exists(select 1 from public.portfolio_state where id = 1) as portfolio_state_ready,
  exists(select 1 from storage.buckets where id = 'portfolio-images') as image_bucket_ready;
