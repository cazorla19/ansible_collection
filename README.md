# Ansible roles collection by cazorla19

## What's here?

Here is my personal Ansible roles collection accumulated for 2 years experience.

## What's now in collection?

- [x] apache
- [x] aws-codedeploy-agent
- [x] aws-ecs-agent
- [x] aws-efs
- [x] consul
- [x] docker
- [x] dropbox
- [x] elasticsearch
  1. Java role is not used by default (switch this on setting `java_setup=True`)
  2. Java role works only for deb version and still not correctly yet
- [x] elk
  1. Java role is not used by default (switch this on setting `java_setup=True`)
  2. Java role works only for deb version and still not correctly yet
  3. Nginx role fetched from this collection (ELK virtual host included)
- [x] fail2ban
  1. Oriented to Nginx logs jail by default
  2. `mail_relay` role included
- [x] filebeat
  1. Oriented to Nginx shipping jail by default
  2. You can set the ELK server at `filebeat\defaults\main.yml`
- [x] grafana
  1. Nginx role fetched from this collection (monitoring virtual host included, also Prometheus locations on vhost)
- [x] graylog
  1. Embedded Elasticsearch and MongoDB installation (by default Elasticsearc version is 2.4.4, cause for now Graylog doesn't work with 5.x)
  2. Nginx role fetched from this collection (Graylog virtual host included)
- [x] java-oracle
  1. Oracle license troubles - will be fixed in the future
- [x] jenkins
  1. Java role for Deb installation doesn't work correctly yet (switched off by default)
  2. Nginx role fetched from this collection (Jenkins virtual host included)
- [x] kubernetes
  1. Includes only cluster node setup; master may be configured, but cluster initialization is not automated yet
  2. Shipped with Weave.net CLI
- [x] mail_relay
  1. You can set the mail server and test mail destination by variables at `mail_relay\defaults\main.yml`
- [x] maintenance
  1. Role includes system settings setup, hostname setup, users configuration (customized by variables), CLI tools provisioning and netfilter setup with IPtables rules
  2. Netfilter tasks set is only available on Ubuntu
- [ ] mediawiki
- [ ] memcached
- [ ] mysql
- [x] nginx
- [ ] nomad
- [ ] opendkim-postfix
- [ ] ossec
- [ ] percona
- [ ] php
- [ ] postgresql
- [ ] prometheus
- [ ] redis
- [ ] tarantool
- [ ] vsftpd
- [ ] wordpress
- [ ] yii
- [ ] zabbix-agent

## Can I apply these roles to my own infrastructure right now?

Not yet. Some roles are targeted only to local infrastructure, so it must be rewritten. Some roles have written terribly and must be refactored. I'll append the label **approved** when any will be ready.

## How to use?

Use them in playbook.

* Playbook example

```
---
 - hosts:
     - example_host
   sudo: yes
   gather_facts: yes
   vars_files:
     - host_vars/all.yml

   roles:
     - example_role
```

* Playbook run example

```
ansible-playbook -i [your_hosts_file] example.yml --tags=[include_tags] --skip-tags=[exclude_tags]
```

## Future plans

Get familiar with Ansible Galaxy and publish some of these roles.
