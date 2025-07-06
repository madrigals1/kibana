# Kibana Docker Setup

This project provides a Docker-based setup for running Kibana with Elasticsearch.

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. **Create environment configuration:**
   Copy the example environment file and customize it:
   ```bash
   cp .env.example .env
   ```
   Edit `.env` to customize ports and other settings if needed.

2. **Start the services:**
   ```bash
   docker-compose up -d
   ```

3. **Access Kibana:**
   Open your browser and go to `http://localhost:5601` (or the port configured in KIBANA_PORT)

4. **Access Elasticsearch:**
   Elasticsearch is available at `http://localhost:9200` (or the port configured in ELASTICSEARCH_PORT)

## Services

### Elasticsearch
- **Port:** 9200 (HTTP), 9300 (Transport)
- **Container:** elasticsearch
- **Data:** Persisted in Docker volume `elasticsearch_data`

### Kibana
- **Port:** 5601
- **Container:** kibana
- **Dependencies:** Waits for Elasticsearch to be healthy before starting

## Configuration

### Environment Variables (.env file)

The `.env` file contains configurable settings for the Docker setup. Use the provided `.env.example` as a template:

```bash
cp .env.example .env
```

Available settings:

- **KIBANA_PORT**: External port for Kibana (default: 5601)
- **ELASTICSEARCH_PORT**: External port for Elasticsearch HTTP (default: 9200)
- **ELASTICSEARCH_TRANSPORT_PORT**: External port for Elasticsearch transport (default: 9300)
- **ELASTICSEARCH_VERSION**: Elasticsearch Docker image version (default: 8.11.0)
- **KIBANA_VERSION**: Kibana Docker image version (default: 8.11.0)
- **XPACK_SECURITY_ENABLED**: Enable/disable security features (default: false)

To change the external ports, edit the `.env` file:
```bash
# Example: Run Kibana on port 8080
KIBANA_PORT=8080

# Example: Run Elasticsearch on port 9300
ELASTICSEARCH_PORT=9300
```

### Other Configuration Files

- **Kibana config:** `kibana.yml` - Basic configuration with security disabled for development
- **Elasticsearch:** Single-node cluster with security disabled

## Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Stop and remove volumes (will delete all data)
docker-compose down -v

# Rebuild Kibana image
docker-compose build kibana

# Check service status
docker-compose ps

# Restart services after changing .env file
docker-compose down && docker-compose up -d
```

## Health Checks

Both services include health checks:
- Elasticsearch: Checks if port 9200 is responding
- Kibana: Checks if port 5601 is responding

## Development

To modify Kibana configuration:
1. Edit `kibana.yml`
2. Rebuild the container: `docker-compose build kibana`
3. Restart: `docker-compose up -d`

## Troubleshooting

- **Kibana won't start:** Check if Elasticsearch is running and healthy
- **Out of memory:** Increase Docker memory limit or adjust ES_JAVA_OPTS in docker-compose.yml
- **Permission issues:** Ensure Docker daemon is running and user has permissions

## Security Note

This setup has security disabled for development purposes. Do not use in production without enabling and configuring security features.

## Files Overview

- **`.env.example`**: Template for environment variables - safe to commit to version control
- **`.env`**: Your actual environment configuration - excluded from version control via `.gitignore`
- **`.gitignore`**: Comprehensive file exclusions for Docker/Kibana projects (environment files, logs, IDE files, OS files, certificates, etc.)
- **`docker-compose.yml`**: Main orchestration file using environment variables
- **`Dockerfile`**: Custom Kibana image configuration
- **`kibana.yml`**: Kibana configuration file 