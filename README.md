# Ansible roles collection by cazorla19

## What's here?

Here is my personal Ansible roles collection accumulated for 2 years experience.

## What's now in collection?

* apache [**approved** - deb/rpm]
* aws-codedeploy-agent[**approved**]
* aws-ecs-agent[**approved**]
* aws-efs[**approved**]
* consul[**approved**]
* docker[**approved** - deb only]
* dropbox[**approved** - works, but not everywhere]
* elasticsearch
* elk
* fail2ban
* filebeat
* golang
* grafana
* graylog
* iptables
* java
* jenkins
* kibana
* kubernetes
* logstash
* mail_relay
* maintenance
* mediawiki
* memcached
* mysql
* nginx
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
