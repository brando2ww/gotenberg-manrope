FROM gotenberg/gotenberg:8

# Mudar para usuário root para instalar dependências
USER root

# Criar diretório para fontes customizadas
RUN mkdir -p /usr/share/fonts/truetype/custom

# Instalar wget
RUN apt-get update && apt-get install -y wget

# Baixar fonte Manrope do Google Fonts
RUN wget -O /usr/share/fonts/truetype/custom/Manrope-Regular.ttf \
    "https://github.com/google/fonts/raw/main/ofl/manrope/Manrope%5Bwght%5D.ttf"

# Atualizar cache de fontes
RUN fc-cache -f -v

# Limpar cache do apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Verificar se fonte foi instalada (aparecerá nos logs)
RUN fc-list | grep -i manrope || echo "⚠️ Manrope não encontrada"

# Voltar para usuário gotenberg
USER gotenberg

# Comando padrão do Gotenberg
CMD ["gotenberg"]
