1) brew install openldap
2) copy slapd.conf to /usr/local/etc/openldap/slapd.conf
3) start openldap: sudo /usr/libexec/slapd -f /usr/local/etc/openldap/slapd.conf -d3
4) add accounts: ldapadd -D "cn=russ,dc=domain,dc=com" -W -x -f [each ldif file starting with root.ldif] #note the password here is "secret" for everything

Get Apache Directory Studio for easier openldap admin

