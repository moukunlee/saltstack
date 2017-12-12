base:
  '*':
    - init.env_init

prod:
  'master.test.com':
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
  'slaver.test.com':
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
   
