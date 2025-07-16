FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/app/models

RUN mkdir -p /app/models

RUN cat > /app/entrypoint.sh << 'EOF'
#!/bin/bash
echo "=== Iniciando Ollama en Railway ==="

if ! command -v ollama &> /dev/null; then
    echo "ERROR: Ollama no está instalado o no está en PATH"
    exit 1
fi

echo "Iniciando servidor Ollama..."
ollama serve &
SERVER_PID=$!

echo "Esperando a que el servidor esté listo..."
sleep 20

if ! pgrep -f "ollama serve" > /dev/null; then
    echo "ERROR: El servidor Ollama no se inició correctamente"
    exit 1
fi

echo "Descargando modelo Mistral..."
ollama pull mistral

if [ $? -eq 0 ]; then
    echo "=== Ollama listo ==="
    echo "Servidor ejecutándose en puerto 11434"
    echo "Modelo Mistral descargado correctamente"
else
    echo "ERROR: No se pudo descargar el modelo Mistral"
    exit 1
fi

# Mantener el contenedor activo
wait $SERVER_PID
EOF

RUN chmod +x /app/entrypoint.sh

EXPOSE 11434

ENTRYPOINT ["/app/entrypoint.sh"]