FROM docker.elastic.co/kibana/kibana:8.11.0

# Copy kibana configuration if it exists
COPY --chown=kibana:kibana kibana.yml /usr/share/kibana/config/kibana.yml

# Expose Kibana port
EXPOSE 5601

# Set environment variables
ENV ELASTICSEARCH_HOSTS=http://elasticsearch:9200
ENV KIBANA_SYSTEM_PASSWORD=kibana_system_password 
