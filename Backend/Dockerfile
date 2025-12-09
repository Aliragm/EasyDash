FROM elixir:1.15-alpine

# Instala dependências incluindo PostgreSQL client
RUN apk add --no-cache \
    build-base \
    git \
    postgresql-client \
    openssl \
    ncurses-libs

WORKDIR /app

# Instala hex e rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copia e instala dependências
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod

# Copia todo o código
COPY . .

# Compila em produção
RUN MIX_ENV=prod mix do compile

# Expõe a porta
EXPOSE 4000

# Script de inicialização
CMD ["/bin/sh", "-c", "mix ecto.migrate && mix phx.server"]