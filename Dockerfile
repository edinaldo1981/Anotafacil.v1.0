# ================================
# Anota Fácil — Dockerfile
# Imagem leve nginx:alpine
# ================================
FROM nginx:alpine

# Metadados
LABEL maintainer="Anota Fácil"
LABEL description="App de gestão para conveniências"
LABEL version="1.0.0"

# Remover config padrão do nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copiar config customizada
COPY nginx/nginx.conf /etc/nginx/conf.d/app.conf

# Copiar arquivos do app
COPY index.html /usr/share/nginx/html/index.html
COPY manifest.json /usr/share/nginx/html/manifest.json
COPY sw.js /usr/share/nginx/html/sw.js

# Permissões corretas
RUN chmod -R 755 /usr/share/nginx/html

# Porta exposta
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost/health || exit 1

# Iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
