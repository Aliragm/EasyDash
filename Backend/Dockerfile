FROM elixir:1.15-alpine

# Instala dependências
RUN apk add --no-cache build-base git postgresql-client

WORKDIR /app

# Instala hex e rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copia dependências
COPY mix.exs mix.lock ./
RUN mix deps.get

# Copia código
COPY . .

# Compila
ENV MIX_ENV=prod
RUN mix do compile

# Expõe porta
EXPOSE 4000

# Comando
CMD ["mix", "phx.server"]