#!/bin/bash

echo "==> Descargando modelo mistral..."
ollama pull mistral

echo "==> Ejecutando modelo mistral..."
ollama run mistral
