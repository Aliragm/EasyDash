# Frontend/Dockerfile

# Usa uma imagem leve do Node
FROM node:20-alpine

# Define a pasta de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de dependências primeiro (pra aproveitar o cache)
COPY package.json ./

# Instala as dependências
RUN npm install

# Copia o resto do código
COPY . .

# Expõe a porta padrão do Vite (geralmente 5173)
EXPOSE 5173

# Comando para rodar em modo desenvolvimento
# O "-- --host" é CRUCIAL para o Docker conseguir expor a porta pra fora
CMD ["npm", "run", "dev", "--", "--host"]