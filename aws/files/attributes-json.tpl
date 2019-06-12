{
  "fqdn": "${host}.${domain}",
   "chef_client": {
     "init_style": "init"
   },
  "chef-server": {
    "accept_license": ${license},
    "addons": ["manage", "push-jobs-server"],
    "api_fqdn": "${host}.${domain}",
    "configuration": "bookshelf['vip'] = '127.0.0.1'\nnginx['ssl_certificate'] = '/var/chef/ssl/${host}.${domain}.pem'\nnginx['ssl_certificate_key'] = '/var/chef/ssl/${host}.${domain}.key'",
    "topology": "standalone",
    "version": "${version}"
  },
  "firewall": {
    "allow_established": true,
    "allow_ssh": true
  },
  "system": {
    "delay_network_restart": false,
    "domain_name": "${domain}",
    "manage_hostsfile": true,
    "short_hostname": "${host}"
  },
  "tags": []
}
