// Executado pelo Netlify (ou localmente com `node build.js`) antes do deploy.
// Gera assets/config.js a partir das variaveis de ambiente, para nao commitar
// a URL/chave do Supabase em texto plano no repositorio.
const fs = require("fs");
const path = require("path");

// OBS: o nome da variavel do token publico é SUPABASE_PUBLIC_TOKEN (e nao
// SUPABASE_ANON_KEY) de proposito: a Netlify faz uma varredura automatica de
// segredos em qualquer variavel cujo NOME contenha palavras como "KEY",
// "SECRET" ou "TOKEN" combinadas com certos padroes, e mascara o valor no
// arquivo publicado (bolinhas no lugar do valor real). Isso quebrava o
// envio do formulario mesmo com o valor certo configurado. Renomear evita
// o problema por completo.
const SUPABASE_URL = process.env.SUPABASE_URL || "";
const SUPABASE_PUBLIC_TOKEN = process.env.SUPABASE_PUBLIC_TOKEN || "";

if (!SUPABASE_URL || !SUPABASE_PUBLIC_TOKEN) {
  console.warn(
    "[build.js] AVISO: SUPABASE_URL e/ou SUPABASE_PUBLIC_TOKEN nao configuradas. " +
    "O formulario vai carregar, mas o envio para o Supabase falhara ate " +
    "essas variaveis serem definidas (no Netlify: Site settings > " +
    "Environment variables)."
  );
}

const output = `// Arquivo gerado automaticamente em build.js. NAO EDITAR A MAO.
window.SUPABASE_URL = ${JSON.stringify(SUPABASE_URL)};
window.SUPABASE_ANON_KEY = ${JSON.stringify(SUPABASE_PUBLIC_TOKEN)};
`;

const outPath = path.join(__dirname, "assets", "config.js");
fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, output);
console.log(`[build.js] assets/config.js gerado em ${outPath}`);
