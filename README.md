# 📦 EasyDash IoT Platform (MVP)

Plataforma de monitoramento IoT em tempo real, desenvolvida para gerenciar sensores, visualizar dados históricos e receber alertas instantâneos via WebSocket.

## 🚀 Tecnologias Utilizadas

O projeto utiliza uma arquitetura moderna baseada em microsserviços containerizados:

* **Backend:** Elixir + Phoenix Framework (API REST & WebSockets)
* **Frontend:** React + Vite + TailwindCSS + Recharts
* **Banco de Dados:** PostgreSQL
* **Mensageria IoT:** MQTT (Mosquitto)
* **Infraestrutura:** Docker & Docker Compose

## 🏗️ Arquitetura

1.  **Sensores (ESP32/Simulador):** Enviam dados JSON para o broker MQTT.
2.  **Backend (Elixir):** Ouve o MQTT, processa os dados, salva no Postgres e faz broadcast via Phoenix Channels.
3.  **Frontend (React):** Conecta via WebSocket para exibir gráficos atualizados em tempo real.

---

## 🛠️ Como Rodar o Projeto

### Pré-requisitos
* [Docker](https://www.docker.com/) e Docker Compose instalados.

### Passo a Passo

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/Aliragm/EasyDash.git](https://github.com/Aliragm/EasyDash.git)
    cd EasyDash
    ```

2.  **Suba os containers:**
    ```bash
    docker compose up --build
    ```
    *Aguarde até ver os logs do backend ("Access EasyDashWeb.Endpoint at...") e do frontend.*

3.  **Acesse a aplicação:**
    * **Dashboard:** [http://localhost:5173](http://localhost:5173)
    * **API Backend:** [http://localhost:4000/api](http://localhost:4000/api)

4.  **Primeiro Acesso:**
    * Crie uma conta na tela inicial.
    * Faça login.
    * (Importante) Cadastre seu primeiro sensor via Postman ou API para vincular ao seu usuário (`sensor_sala_01`)(Comportamento de teste apenas).

---

## 📡 Simulador de IoT (Mock)

Caso não tenha o hardware físico disponível, você pode simular um sensor enviando dados.

1.  Abra um terminal na pasta `Mock_IoT`:
    ```bash
    cd Mock_IoT
    npm install
    ```

2.  Execute o simulador:
    ```bash
    node simulador.js
    ```
    *O script enviará dados de temperatura e umidade a cada 30 segundos para o tópico MQTT, e você verá o gráfico no Dashboard se mover.*

---

## 🔌 Endpoints Principais (API)

* `POST /api/register` - Criar conta
* `POST /api/login` - Autenticar (Retorna JWT)
* `GET /api/sensores` - Listar sensores do usuário
* `POST /api/sensores` - Vincular novo sensor
* `GET /api/leituras?sensor_id=X` - Histórico de dados

---

## 📝 Autores

* **André Medeiros** - Backend & Arquitetura
* **Ulisses Folador** - Frontend & UI
* **João Guilherne Azevedo** - Hardware & IoT