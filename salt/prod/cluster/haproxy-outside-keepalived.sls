include:
  - keepalived.install

keepalived-service:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/files/haproxy-outside-keepalived.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
     {% if grains['fqdn'] == 'master.test.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: MASTER
    - PRIORITYID: 150
     {% elif grains['fqdn'] == 'slaver.test.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: BACKUP
    - PRIORITYID: 100
     {% endif %}
  service.running:
    - name: keepalived
    - enable: True
    - watch:
      - file: keepalived-service

 
