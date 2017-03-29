# Ansible roles collection by cazorla19

## What's here?

Here is my personal Ansible roles collection accumulated for 2 years experience.

## What's now in collection?

* apache [**approved** - deb/rpm]
* aws-codedeploy-agent [**approved**]
* aws-ecs-agent [**approved**]
* aws-efs [**approved**]
* consul [**approved**]
* docker [**approved** - deb only]
* dropbox [**approved** - works, but not everywhere]
* elasticsearch [**approved** - deb/rpm]
  1. Java role is not used by default (switch this on setting `java_setup=True`)
  2. Java role works only for deb version and still not correctly yet
* elk [**approved** - deb/rpm]
  1. Java role is not used by default (switch this on setting `java_setup=True`)
  2. Java role works only for deb version and still not correctly yet
  3. Nginx role fetched from this collection (ELK virtual host included)
* fail2ban [**approved**]
  1. Oriented to Nginx logs jail by default
  2. `mail_relay` role included
* filebeat [**approved** - deb/rpm]
  1. Oriented to Nginx shipping jail by default
  2. You can set the ELK server at `filebeat\defaults\main.yml`
* grafana [**approved** - deb/rpm]
  1. Nginx role fetched from this collection (monitoring virtual host included, also Prometheus locations on vhost)
* graylog [**approved** - deb only]
  1. Embedded Elasticsearch and MongoDB installation (by default Elasticsearc version is 2.4.4, cause for now Graylog doesn't work with 5.x)
  2. Nginx role fetched from this collection (Graylog virtual host included)
* java [**not approved** - deb only]
  1. Oracle license troubles - will be fixed in the future
* jenkins
* kubernetes
* mail_relay [**approved**]
  1. You can set the mail server and test mail destination by variables at `mail_relay\defaults\main.yml`
* maintenance
* mediawiki
* memcached
* mysql
* nginx [**approved**]
* nomad
* opendkim-postfix
* ossec
* percona
* php
* postgresql
* prometheus
* redis
* ssl
* tarantool
* vsftpd
* wordpress
* yii
* zabbix-agent

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
