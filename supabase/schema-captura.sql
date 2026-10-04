-- RODAR UMA VEZ no Supabase: SQL Editor > New query > Run.
-- Tabela que recebe o e-mail da pagina de captura (raiz do site).
-- O site publico so consegue INSERIR (nunca ler, alterar ou apagar).

create extension if not exists pgcrypto;

create table if not exists public.leads_captura (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz not null default now(),
  email       text not null
);

alter table public.leads_captura enable row level security;

drop policy if exists "anon_can_insert_captura" on public.leads_captura;
create policy "anon_can_insert_captura"
  on public.leads_captura
  for insert
  to anon
  with check (true);
