FROM ollama/ollama:latest

RUN echo '#!/bin/bash\n\
ollama serve &\n\
sleep 10\n\
ollama pull mistral\n\
echo "Modelo Mistral descargado. Servidor listo en puerto 11434"\n\
wait' > /start.sh && chmod +x /start.sh

EXPOSE 11434
CMD ["/start.sh"]