# Páginas - Formação GENOGLP

Fluxo: captura de e-mail (`index.html`) -> vídeo (`pagObrigadoGabi/`) -> perguntas (`FormsGabiMAH/`) -> grupo do WhatsApp.

## Antes de subir: rodar o SQL da captura (uma vez)
Supabase > SQL Editor > New query > cole `supabase/schema-captura.sql` > Run.
Cria a tabela `leads_captura`. A tabela do formulário (`form_leads_nutricionistas`) já existe.

## Subir no GitHub Pages
1. github.com > New repository > dê um nome > Public > Create.
2. Na página do repositório: "uploading an existing file" > arraste TODO o conteúdo desta pasta
   (index.html, foto-capa.jpg, as pastas assets, FormsGabiMAH, pagObrigadoGabi...) > Commit changes.
3. Settings > Pages > Source: "Deploy from a branch" > Branch: main / (root) > Save.
4. Em 1-2 minutos o site fica em https://SEU-USUARIO.github.io/NOME-DO-REPO/

O `assets/config.js` (URL + chave pública do Supabase) vai junto e precisa estar no repositório.
A chave é pública por natureza; as tabelas só permitem inserir dados, nunca ler.

## Data do evento
Em `index.html`: constante `TARGET_DATE` (contador) e o texto do `.date-pill`.

## Netlify (opcional)
Também funciona no Netlify: arrastar a pasta, ou conectar o repositório (o `build.js` gera o config
a partir de SUPABASE_URL e SUPABASE_PUBLIC_TOKEN).
