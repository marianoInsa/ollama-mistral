FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0:11434

COPY <<EOF /app/start.sh
#!/bin/bash
/usr/local/bin/ollama serve &
sleep 20
/usr/local/bin/ollama pull mistral
wait
EOF

RUN chmod +x /app/start.sh

EXPOSE 11434

ENTRYPOINT ["/bin/bash", "/app/start.sh"]