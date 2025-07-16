FROM ollama/ollama:latest

# Copiamos el script que correrá al inicio
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD bash -c "ollama pull mistral && ollama run mistral"
