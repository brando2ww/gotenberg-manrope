# Stage 1: baixa a fonte
FROM alpine:3.20 AS fonts

RUN apk add --no-cache curl

RUN mkdir -p /out && \
  curl -L -o /out/Manrope-Regular.ttf \
  "https://raw.githubusercontent.com/google/fonts/main/ofl/manrope/Manrope%5Bwght%5D.ttf"


# Stage 2: imagem final do Gotenberg
FROM gotenberg/gotenberg:8

USER root

RUN mkdir -p /usr/share/fonts/truetype/custom

COPY --from=fonts /out/Manrope-Regular.ttf /usr/share/fonts/truetype/custom/Manrope-Regular.ttf

RUN chmod 644 /usr/share/fonts/truetype/custom/Manrope-Regular.ttf && \
    fc-cache -f -v

USER gotenberg

EXPOSE 3000
