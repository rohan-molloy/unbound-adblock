EndpointIP=${1:-'127.0.0.2'}
awk '{print "local-zone: \""$2"\" redirect\nlocal-data: \""$2" A '$EndpointIP'\""}' <(wget -qO- https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts |  grep '^0\.0\.0\.0' | sort)
