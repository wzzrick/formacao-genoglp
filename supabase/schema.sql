-- Execute este script no Supabase: SQL Editor > New query > Run.
-- Cria a tabela que armazena os envios do formulario de nutricionistas
-- e configura RLS para que o site publico so consiga INSERIR registros
-- (nunca ler, alterar ou apagar leads existentes).

create extension if not exists pgcrypto;

create table if not exists public.form_leads_nutricionistas (
  id                    uuid primary key default gen_random_uuid(),
  created_at            timestamptz not null default now(),
  firstname             text not null,
  phone                 text not null,
  email                 text not null,
  occupation            text not null,
  patient_portfolio     text,
  authority_perception  text,
  current_price_range   text,
  patients_served       text
);

comment on table public.form_leads_nutricionistas is
  'Leads capturados pelo formulario /FormsGabiMAH (substitui a integracao antiga com HubSpot).';

alter table public.form_leads_nutricionistas enable row level security;

-- Permite que qualquer visitante (role "anon", usada pela chave publica
-- do frontend) INSIRA um novo lead. Nao ha policy de SELECT/UPDATE/DELETE
-- para anon, entao visitantes NAO conseguem consultar, editar ou apagar
-- leads existentes.
drop policy if exists "anon_can_insert_leads" on public.form_leads_nutricionistas;
create policy "anon_can_insert_leads"
  on public.form_leads_nutricionistas
  for insert
  to anon
  with check (true);

-- Nenhuma policy de select/update/delete e criada de proposito:
-- por padrao, com RLS habilitado e sem policy, o acesso e negado.
-- Para consultar os leads, use o painel do Supabase (Table Editor) ou
-- o SQL Editor logado como administrador (bypassa RLS), ou a
-- Service Role Key em um ambiente de backend seguro (NUNCA no frontend).
