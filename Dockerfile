FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/app/models

RUN mkdir -p /app/models

RUN echo '#!/bin/bash\n\
echo "=== Iniciando Ollama en Railway ==="\n\
\n\
# Verificar que ollama esté disponible\n\
if ! command -v ollama &> /dev/null; then\n\
    echo "ERROR: Ollama no está instalado o no está en PATH"\n\
    exit 1\n\
fi\n\
\n\
# Iniciar servidor en background\n\
echo "Iniciando servidor Ollama..."\n\
ollama serve &\n\
SERVER_PID=$!\n\
\n\
# Esperar a que el servidor esté listo\n\
echo "Esperando a que el servidor esté listo..."\n\
sleep 20\n\
\n\
# Verificar que el servidor esté corriendo\n\
if ! pgrep -f "ollama serve" > /dev/null; then\n\
    echo "ERROR: El servidor Ollama no se inició correctamente"\n\
    exit 1\n\
fi\n\
\n\
# Descargar modelo Mistral\n\
echo "Descargando modelo Mistral..."\n\
ollama pull mistral\n\
\n\
if [ $? -eq 0 ]; then\n\
    echo "=== Ollama listo ==="\n\
    echo "Servidor ejecutándose en puerto 11434"\n\
    echo "Modelo Mistral descargado correctamente"\n\
else\n\
    echo "ERROR: No se pudo descargar el modelo Mistral"\n\
    exit 1\n\
fi\n\
\n\
# Mantener el contenedor activo\n\
wait $SERVER_PID' > /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

EXPOSE 11434

ENTRYPOINT ["/app/entrypoint.sh"]