# Unbound-adblock

Resources for blocking ads using a local Unbound DNS server, as well as setting up a pixelserver with lighttpd.

## Scripts
We include the following scripts
- `gen-adblock-spoof.sh`  
    This uses host file data from https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
    to create local-data that redirects ad-domains to `127.0.0.2`. 

    Note: it assumes the hostfile uses `0.0.0.0` as the ip .  
   *A custom redirection ip address can be specified in the first argument.*
    
-   `gen-adblock-refuse.sh`  
    This uses host file data from https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts to create local-data that responds to ad-domains with `NXDOMAIN`

- `hosts-to-unbound.sh`  
Reads from `/etc/hosts` and creates both local-data (forward) and local-data-ptr (reverse) records for each entry. 

Note: it assumes that records contain only two fields per line.  
*An alternative file can be specified by the first argument*

- `hosts-to-unbound-noptr.sh`  
Reads from `/etc/hosts` and creates only local-data (forward) records for each entry.

*An alternative file can be specified by the first argument.*

## Unbound configuration Example

 [Example unbound.conf](https://raw.githubusercontent.com/rohan-molloy/unbound-dns/master/unbound.conf) 
 
 To use these adblock examples, place them in `/etc/unbound/local.d/`
- `lan-data-example.conf`
Data created from host-file `hosts.example` using hosts-to-unbound.sh

- `adblock-spoof-example.conf`
Ad-domains from https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts redirecting to `127.0.0.2`

- `adblock-refuse-example.conf`
Ad-domains from https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts responding with `NXDOMAIN`

## Lighttpd Pixel server
`lighttpd/adblock.conf` is an example configuration file for running a self-contained pixel-server. 
This uses lighttpd and listens on `127.0.0.2`.
 For this to work, you cannot have any other web servers listening on `0.0.0.0`

The lighttpd server redirects all images to a 1x1 png file, all javascript files to a script that runs `console.log("Adblock);` and everything else to an empty html page.

To use it:
`sudo lighttpd -f lighttpd/adblock.conf`

you may wish to create a systemd unit etc. 

