# =============================================================================
# LAB11 - Projeto Cloud AWS - One-Page MetalForja S/A
# Imagem Docker baseada em Nginx Alpine (leve, ~25MB)
# Aluna: Quezia de Oliveira Freire
# =============================================================================

# 1) Imagem base oficial: Nginx sobre Alpine Linux (pequena e segura)
FROM nginx:1.27-alpine

# 2) Metadados (boa pratica - OCI labels)
LABEL maintainer="quezia.freire@qualiserve.com.br" \
      project="LAB11-Projeto-Cloud-AWS" \
      case="01-MetalForja" \
      description="One-Page MetalForja servido por Nginx em container Docker"

# 3) Substitui a configuracao padrao do Nginx pela nossa (gzip + /health)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 4) Copia o conteudo estatico para o diretorio servido pelo Nginx
COPY index.html /usr/share/nginx/html/index.html

# 5) Expoe a porta 80 (HTTP)
EXPOSE 80

# 6) Healthcheck nativo do Docker - checa se o Nginx responde
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/health || exit 1

# 7) Comando de inicializacao (Nginx em foreground, padrao da imagem base)
CMD ["nginx", "-g", "daemon off;"]
