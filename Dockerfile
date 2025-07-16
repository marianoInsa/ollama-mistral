FROM ollama/ollama:latest

CMD ["ollama", "pull", "mistral"]
CMD ["ollama", "run", "mistral"]
