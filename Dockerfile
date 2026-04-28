# Stage 1: baixa a fonte em um ambiente que suporta instalar ferramentas
FROM alpine:3.20 AS fonts
RUN apk add --no-cache curl
RUN mkdir -p /out && \
  curl -L -o /out/Manrope-Regular.ttf \
  "https://raw.githubusercontent.com/google/fonts/main/ofl/manrope/Manrope%5Bwght%5D.ttf"

# Stage 2: imagem final do Gotenberg
FROM gotenberg/gotenberg:8
USER root

# Cria diretório e copia a fonte
RUN mkdir -p /usr/share/fonts/truetype/custom && \
    chown -R gotenberg:gotenberg /usr/share/fonts/truetype/custom

COPY --from=fonts /out/Manrope-Regular.ttf /usr/share/fonts/truetype/custom/Manrope-Regular.ttf

# Atualiza cache de fontes sem depender de apt
RUN fc-cache -f -v

USER gotenberg
CMD ["gotenberg"]
