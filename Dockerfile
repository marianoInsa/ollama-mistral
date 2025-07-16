FROM ollama/ollama:latest

CMD bash -c "ollama pull mistral && ollama run mistral"
