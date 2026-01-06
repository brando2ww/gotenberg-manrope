# Stage 1: baixa a fonte em um ambiente que suporta instalar ferramentas
FROM alpine:3.20 AS fonts

RUN apk add --no-cache curl

# Baixa a Manrope (Regular) do repo oficial do Google Fonts
RUN mkdir -p /out && \
  curl -L -o /out/Manrope-Regular.ttf \
  "https://raw.githubusercontent.com/google/fonts/main/ofl/manrope/Manrope%5Bwght%5D.ttf"

# Stage 2: imagem final do Gotenberg (sem apt, sem instalar nada)
FROM gotenberg/gotenberg:8

USER root

# Cria diretório de fontes
RUN mkdir -p /usr/share/fonts/truetype/custom

# Copia a fonte baixada no stage anterior
COPY --from=fonts /out/Manrope-Regular.ttf /usr/share/fonts/truetype/custom/Manrope-Regular.ttf

# Atualiza cache de fontes (se existir)
RUN fc-cache -f -v || true

USER gotenberg

CMD ["gotenberg"]
