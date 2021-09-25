# wordpress_docker_development_purpose

A Docker dockerfile to create an image of WordPress with Xdebug3 support, use it for development purpose only.

Somehow the default XDEBUG_CONFIG env variable does not work correctly:
https://xdebug.org/docs/all_settings
```
A select set of settings can be set through an XDEBUG_CONFIG environment variable. In this situation, the xdebug. part should be dropped from the setting name.
```

so a custom ENTRYPOINT script writes XDEBUG_CONFIG value inside a configuration file
**/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini**

at container startup, just before calling default Apache ENTRYPOINT script

**docker-entrypoint.sh apache2-foreground**

All Xdebug configuration options can be passed but **pay attention to not drop the *xdebug.* part of setting name**.
For example. instead of setting (WRONG):
```yaml
environment:
     XDEBUG_CONFIG: |
        mode=debug,develop
        client_host=host.docker.internal
        client_port=9003
        idekey="phpdebugkey"
```
use xdebug. prefix (CORRECT)
```yaml
environment:
      XDEBUG_CONFIG: |
        xdebug.mode=debug,develop
        xdebug.client_host=host.docker.internal
        xdebug.client_port=9003
        xdebug.idekey="phpdebugkey"
```

an example of usage can be found at this repo https://github.com/AndreaDiPietro-ADP/wordpress-docker-compose-xdebug3

