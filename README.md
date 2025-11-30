# ⚡ EasyDash - IoT Backend API

Backend robusto e escalável para aplicações de Internet das Coisas (IoT). Desenvolvido em **Elixir** com **Phoenix Framework**, este sistema gerencia a ingestão de dados via MQTT, armazenamento seguro e distribuição em tempo real via WebSockets.

## 🚀 Tecnologias

* **Linguagem:** [Elixir](https://elixir-lang.org/)
* **Framework:** [Phoenix](https://www.phoenixframework.org/) (Modo API/Headless).
* **Banco de Dados:** PostgreSQL (via Ecto).
* **Protocolos:**
    * **MQTT:** Consumo de dados de sensores.
    * **WebSockets:** Streaming de dados em tempo real.
    * **REST:** API para gestão de dispositivos e histórico.
* **Infraestrutura:** Docker & Docker Compose.

---

## 🏛️ Arquitetura do Sistema

O fluxo de dados segue uma arquitetura orientada a eventos:

1.  **Sensores (Hardware):** Publicam JSON no broker MQTT.
2.  **Listener (Elixir):** Processo em background ouve o tópico, valida os dados e salva no PostgreSQL.
3.  **PubSub:** O sistema notifica internamente que um novo dado chegou.
4.  **Canais Seguros:** O dado é enviado via WebSocket apenas para o usuário dono daquele sensor.

---

## 🛠️ Como Rodar (Instalação)

Este projeto é 100% containerizado. Você só precisa ter Docker e Docker Compose instalados.

### 1. Clone o repositório

```bash
git clone https://github.com/Aliragm/EasyDash.git
cd easy_dash
```

### 2. Configure as Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto:

```bash
# Gere uma chave nova no terminal com: mix phx.gen.secret
SECRET_KEY_BASE=cole_sua_chave_gigante_aqui

# Configurações do Banco (Padrão do Docker)
DB_USER=postgres
DB_PASS=postgres
DB_HOST=db
DB_NAME=easy_db
```

### 3. Suba os Containers

```bash
docker compose up --build
```

Aguarde até ver a mensagem `MQTT ON` no terminal.

### 4. Setup do Banco (Apenas na primeira vez)

Em outro terminal, execute:

```bash
docker compose exec app mix ecto.setup
```

---

## 🔑 Autenticação & Segurança
Todo request para rotas protegidas devem enviar o header, este token pode ser obtido na rota /login:

```
Authorization: Bearer SEU_TOKEN_AQUI
```

---

## 📡 Documentação da API REST

### 1. Autenticação

| Método | Rota | Descrição | Body |
|--------|------|-----------|------|
| POST | `/api/login` | Gera o Token de Acesso | `{ "email": "...", "password": "..." }` |

### 2. Gestão de Sensores (Requer autenticação)

| Método | Rota | Descrição | Body |
|--------|------|-----------|------|
| POST | `/api/sensores` | Vincula um novo sensor ao usuário | `{ "sensor": { "nome": "Sala", "hardware_id": "s_01" } }` |
| GET | `/api/sensores` | Lista apenas os sensores do usuário | - |
| DELETE | `/api/sensores/:id` | Remove um sensor | - |

### 3. Histórico de Dados (Requer autenticação)

| Método | Rota | Descrição | Params |
|--------|------|-----------|--------|
| GET | `/api/leituras` | Busca histórico de leituras | `?sensor_id=hardware_id` |

---

## 🔌 Documentação WebSocket (Tempo Real)

Para receber dados ao vivo, o Frontend deve conectar no Phoenix Channel.

**Endpoint:** `ws://localhost:4000/socket/websocket`

**Parâmetro de Conexão:** `token` (Obrigatório)

### Fluxo de Conexão:

1. Conecte no Socket passando o Token.
2. Entre no canal específico do sensor desejado (`phx_join`).
3. Tópico: `sensor:HARDWARE_ID` (Ex: `sensor:sensor_fake_01`).
4. Escute o evento: `leitura_chegou`.

### Exemplo de Payload recebido:

```json
{
    "topic": "sensor:sensor_fake_01",
    "event": "leitura_chegou",
    "payload": {
        "temp": 25.5,
        "umid": 60.0,
        "hora": "2025-11-30T10:00:00Z"
    }
}
```

## 🧪 Comandos Úteis (Dev)

### Acessar Console Interativo (IEx):

```bash
docker compose exec app iex -S mix
```

### Simular Sensor IoT (Via Terminal):

```elixir
# Dentro do IEx
Tortoise.publish("simulador", "sensores/leitura", Jason.encode!(%{temperatura: 20, id: "sensor_id"}), qos: 0)
```

### Resetar Banco de Dados:

```bash
docker compose exec app mix ecto.reset
```

---