# ===========================
# Dockerfile para FastAPI + Poetry no Render
# ===========================
FROM python:3.10-slim

# Define diretório de trabalho
WORKDIR /app

# Instala dependências básicas
RUN apt-get update && apt-get install -y curl build-essential && rm -rf /var/lib/apt/lists/*

# Instala o Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Adiciona o Poetry ao PATH
ENV PATH="/root/.local/bin:$PATH"

# Copia os arquivos de dependências
COPY pyproject.toml poetry.lock* ./

# Instala dependências do projeto
RUN poetry install --no-root --no-interaction --no-ansi

# Copia o restante do código
COPY . .

# Expõe a porta padrão do Render
EXPOSE 10000

# Comando para rodar o servidor FastAPI
CMD ["poetry", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "10000"]
