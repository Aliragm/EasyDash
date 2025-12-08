# Usa uma imagem oficial leve do Elixir baseada em Alpine Linux
FROM elixir:1.15-alpine

# Instala ferramentas básicas de sistema que o Phoenix precisa
RUN apk add --no-cache build-base git inotify-tools

# Define a pasta de trabalho dentro do container
WORKDIR /app

# Instala o gerenciador de pacotes Hex e o Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copia os arquivos de definição de dependências
COPY mix.exs mix.lock ./

# Baixa as dependências e compila
RUN mix deps.get
RUN mix do deps.compile, compile
# Copia o resto do código para dentro do container
COPY . .

# Expõe a porta 4000
EXPOSE 4000

# Comando padrão para iniciar o servidor
CMD ["mix", "phx.server"]