FROM wordpress:5.7.2-php7.4-apache

RUN pecl install xdebug \
 && docker-php-ext-enable xdebug
 
# Use the default development configuration
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
        
COPY /print_env_xdebug_config_into_ini_file /etc/init.d/print_env_xdebug_config_into_ini_file
RUN chown root:root /etc/init.d/print_env_xdebug_config_into_ini_file \
		&& chmod u=rwx,go=rx /etc/init.d/print_env_xdebug_config_into_ini_file
ENTRYPOINT ["/etc/init.d/print_env_xdebug_config_into_ini_file"]
