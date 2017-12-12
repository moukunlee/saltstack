include:
  - pkg.pkg-init

keepalived-install:
  file.managed:
    - name: /usr/local/src/keepalived-1.2.19.tar.gz
    - source: salt://keepalived/files/keepalived-1.2.19.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf keepalived-1.2.19.tar.gz && cd keepalived-1.2.19 && ./configure --prefix=/usr/local/keepalived -disable-fwmank && make && make install
    - unless: test -d /usr/local/keepalived
    - require:
      - file: keepalived-install
      - pkg: pkg-init

keepalived-init:
  file.managed:
    - name: /etc/init.d/keepalived
    - source: salt://keepalived/files/keepalived.init
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add keepalived
    - unless: chkconfig --list | grep keepalived
    - require:
      - file: keepalived-init

/etc/sysconfig/keepalived:
  file.managed:
    - source: salt://keepalived/files/keepalived.sysconfig
    - user: root
    - group: root
    - mode: 755

/etc/keepalived:
  file.directory:
    - user: root
    - group: root
    - mode: 755
