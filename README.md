# LAB11 - Projeto Cloud AWS - MetalForja S/A

Projeto academico de Cloud Computing e DevOps: publicacao de uma one-page corporativa na AWS com pipeline CI/CD completo.

**Aluna:** Quezia de Oliveira Freire
**Case:** 1 - MetalForja S/A (Metalurgica / Automotivo)
**Curso:** Computacao em Nuvem

---

## Arquitetura

```
Notebook (Windows + PowerShell + Git + Docker)
    |
    | git push origin main
    v
GitHub Repository (lab11-metalforja)
    |
    | trigger: on push
    v
GitHub Actions Runner
    |---- checkout
    |---- docker build
    |---- docker push -> Docker Hub
    |---- SSH deploy -> EC2
    v
AWS EC2 (Ubuntu 22.04 - us-east-2)
    |---- docker pull
    |---- docker run -p 80:80
    v
Container Nginx (nginx:1.27-alpine)
    |
    v
One-Page MetalForja S/A -> http://3.18.225.96
```

## Stack tecnologica

| Camada | Tecnologia |
|---|---|
| Aplicacao | HTML5 + CSS3 + JavaScript (one-page estatica) |
| Servidor web | Nginx 1.27 Alpine |
| Empacotamento | Docker |
| Registry | Docker Hub |
| CI/CD | GitHub Actions |
| Versionamento | Git + GitHub |
| Infraestrutura | AWS EC2 t3.micro Ubuntu 22.04 (us-east-2) |

## Estrutura do projeto

```
lab11-metalforja/
|-- .github/
|   `-- workflows/
|       `-- deploy.yml      # Pipeline CI/CD
|-- index.html              # One-page MetalForja S/A
|-- Dockerfile              # Imagem Nginx + HTML
|-- nginx.conf              # Configuracao Nginx (gzip + /health)
|-- .dockerignore
|-- .gitignore
`-- README.md
```

## Executar localmente

```powershell
docker build -t metalforja:dev .
docker run -d -p 8080:80 --name metalforja metalforja:dev
# Acesse: http://localhost:8080
```

## Pipeline CI/CD

A pipeline GitHub Actions executa automaticamente a cada `git push` na branch `main`:

1. **Checkout** do codigo
2. **Build** da imagem Docker
3. **Push** da imagem para Docker Hub
4. **Deploy** via SSH na EC2 (pull + restart container)

## Infraestrutura AWS

| Atributo | Valor |
|---|---|
| Regiao | us-east-2 (Ohio) |
| Tipo | t3.micro (Free Tier) |
| AMI | Ubuntu 22.04 LTS |
| Security Group | SSH 22 (restrito) + HTTP 80 (publico) |
| Instance ID | i-0dfb55de31dfbcd66 |
| IP publico | 3.18.225.96 |

## Evidencias da atividade

- Fase 1 - Pagina no ar: print do navegador acessando IP publico
- Fase 2 - Repositorio GitHub: este repositorio
- Fase 3 - Pipeline CI/CD: aba Actions do GitHub
- Fase 4 - Dockerfile: arquivo `Dockerfile` na raiz

## Licenca

Projeto academico - uso educacional.
