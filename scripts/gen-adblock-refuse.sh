(curl --silent https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | grep '^0\.0\.0\.0' | sort) | awk '{print "local-zone: \""$2"\" refuse"}'
