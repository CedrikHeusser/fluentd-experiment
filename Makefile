# Can be either "docker compose" or "docker-compose". Depends on how you've installed Docker Compose
docker_compose=docker compose
netcat=nc
netcat_flags=-vv
netcat_flags_udp=${netcat_flags} -u -w0

host=localhost
tcp_port=5140
udp_port=5140
tcp_port_tls=5141

date_rfc3164=`date +"%b %d %H:%M:%S"`
date_rfc5424=`date +"%FT%TZ"`

run:
	${docker_compose} up -d

stop:
	${docker_compose} stop

down:
	${docker_compose} down

restart-fluentd:
	${docker_compose} restart fluentd

# TCP unencrypted
log-tcp-rfc3164:
	echo "$(shell bash -c "echo '<$${RANDOM:1:2}>${date_rfc3164}'") my-wonderful-root-server.example.com su: 'su root' failed for vcap on /dev/pts/0 -- TCP unencrypted -- RFC3164" | ${netcat} ${netcat_flags} ${host} ${tcp_port}

log-tcp-rfc5424:
	echo "$(shell bash -c "echo '<$${RANDOM:1:3}>1 ${date_rfc5424}'") my-wonderful-root-server.example.com random-app-name 1337 ID47 [exampleSDID@32473 iut="3" eventSource="Application" eventID="1011"] Service Broker Log - TCP unencrypted - RFC5424" | ${netcat} ${netcat_flags_udp} ${host} ${tcp_port}

# UDP
log-udp-rfc3164:
	echo "$(shell bash -c "echo '<$${RANDOM:1:2}>${date_rfc3164}'") my-wonderful-root-server su: 'su root' failed for vcap on /dev/pts/0 -- UDP -- RFC3164" | ${netcat} ${netcat_flags_udp} ${host} ${tcp_port}

log-udp-rfc5424:
	echo "$(shell bash -c "echo '<$${RANDOM:1:3}>1 ${date_rfc5424}'") my-wonderful-root-server.example.com random-app-name 1337 ID47 [exampleSDID@32473 iut="3" eventSource="Application" eventID="1011"] Service Broker Log - UDP - RFC5424" | ${netcat} ${netcat_flags_udp} ${host} ${tcp_port}

log-tcp: log-tcp-rfc3164 log-tcp-rfc5424
log-udp: log-udp-rfc3164 log-udp-rfc5424

log-all: log-tcp log-udp
