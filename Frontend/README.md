# 🎨 EasyDash Frontend

Interface visual da plataforma EasyDash, construída com React e Vite, focada em performance e atualização em tempo real.

## ⚡ Funcionalidades

* **Autenticação JWT:** Login e Cadastro integrados com a API Phoenix.
* **Real-time:** Uso de `phoenix.js` para conexão WebSocket.
* **Visualização de Dados:** Gráficos interativos com `recharts`.
* **Responsividade:** Layout adaptável com TailwindCSS.

## 📂 Estrutura de Pastas

* `src/components`: Componentes reutilizáveis (Cards, Gráficos).
* `src/useDashboardData.js`: Hook customizado que gerencia a lógica de dados (Fetch inicial + WebSocket updates).
* `src/EasyDash.jsx`: Dashboard principal.
* `src/Login.jsx`: Tela de autenticação.

## 🚀 Desenvolvimento Local (Sem Docker)

Se preferir rodar o front fora do Docker para desenvolvimento rápido:

1.  Instale as dependências:
    ```bash
    npm install
    ```

2.  Crie um arquivo `.env` na raiz do Frontend:
    ```env
    VITE_API_URL=http://localhost:4000/api
    ```

3.  Rode o servidor de desenvolvimento:
    ```bash
    npm run dev
    ```

## 🔧 Configuração Importante

O arquivo `vite.config.js` está configurado para permitir acesso externo (necessário para o Docker):

```javascript
server: {
  host: true,
  port: 5173,
  watch: {
    usePolling: true // Essencial para Hot Reload no Windows/WSL
  }
}