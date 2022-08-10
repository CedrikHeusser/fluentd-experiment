FROM fluent/fluentd:v1.12.0-debian-1.0
USER root
RUN ["gem", "install", "fluent-plugin-opensearch", "--no-document"]
RUN ["fluent-gem", "install", "fluent-plugin-grok-parser"]
USER fluent
