# AutoMX Docker Setup

This is some scripting to set up automx (http://automx.org) as docker containers. 
There are 2 containers. One for automx and another for Mariadb, where the domain
configuration is stored.

# Principle of E-Mail-Autoconfiguration

## Thunderbird

* A DNS-Record (A or CNAME) autoconfig.yourdomain.tld pointing to your autodiscover service
* An http Server running the autodiscover application

## Microsoft Outlook

### Variant A

* A DNS-Record (A or CNAME) autodiscover.yourdomain.tld pointing to your autodiscover service
* An httpS Server running the autodiscover application
* A valid SSL-Certificate for autodiscover.yourdomain.tld (if you are trying to serve 
  multiple domains, you need a valid certificate for all domains, this solution does not work)

### Variant B (Hack, but easier)

* A DNS-Record(A-Record) autodiscover.yourdomain.tld pointing to 0.0.0.0
* A DNS-Record(SRV-Record) _autodiscover._tcp.yourdomain.tld containing

ttl:			86400
weight:			0
priority:		0
Port:			443
Server:			autodiscover.servicedomain.tld

Example: 

_autodiscover._tcp.yourdomain.com. 86400  IN  SRV  0  0  443  autodiscover.servicedomain.tld

#### Explanation

MS Outlook tries to connect to the host via ssl and expects a correct certificate. If a wrong
certificate (the one from the servicedomain) is received, the user gets a certificate warning.
So let this one fail by configuring 0.0.0.0 to the autodiscover hostname. (So it will still 
fail even if there is wildcard record set!)

If the autodiscover server is unreachable, Outlook moves on to the next method, which is 
to query a SRV record. This works fine and that's it.

To use this installation you need Variant B)

## Apple Mail 

[ Not yet tested ]

# Additional Requirements

For this docker system you need the following:

* Ruby(for the template renderer)
* A correct DNS-record autodiscover.servicedomain.tld
* The above mentioned 3 records for each domain you want to serve with autodiscover
* An entry in the automx database in the config_db container
* Place your valid SSL Certificate in automx/files/ssl
  ...or use pre-build-root.sh to copy it before building
  (see pre-build-root.sh for hints)
* Fill in the correct values into automx_docker.conf.rb and run ./build.sh

## Entry in the automx - db

A script for this may come later or maybe you write one.

* Figure out the ip addres of the config_db container
 
docker inspect config_db | grep -i ipaddress

* Install mariadb-client

* adapt and run the following query to insert the data for your domain

mysql -uroot -pYOURROOTPW -h IPADDRESS -e "INSERT INTO automx VALUES(1,'yourdomain.de','yes','yoursmtpserver.domain.tld','587','starttls','plaintext','%s','yes','6','yes','yourimapserver.domain.tld','143','starttls','plaintext','%s','6','yes','yourpop3server.domain.tld','110','starttls','plaintext','%s','6');
