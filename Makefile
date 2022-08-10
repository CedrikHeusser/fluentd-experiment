# Can be either "docker compose" or "docker-compose". Depends on how you've installed Docker Compose
docker_compose=docker compose
netcat=nc
netcat_flags=-vv
netcat_flags_udp=${netcat_flags} -u -c

host=localhost
tcp_port=5140
udp_port=5140
tcp_port_tls=5141

date=`date +"%b %d %H:%M:%S"`

run:
	${docker_compose} up -d

stop:
	${docker_compose} stop

down:
	${docker_compose} down

restart-fluentd:
	${docker_compose} restart fluentd

log-tcp:
	echo "<$(shell bash -c 'echo $${RANDOM:1:2}')>${date} my-wonderful-root-server su: 'su root' failed for vcap on /dev/pts/0" | ${netcat} ${netcat_flags} ${host} ${tcp_port}
