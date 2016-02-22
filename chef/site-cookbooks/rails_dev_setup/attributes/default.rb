# Default project attributes

default['project']['dir_name']         = 'project_dir'
default['project']['site_root']        = '/var/www/public'
default['project']['domain']           = 'project-domain.dev'


# Default attributes for mysql installation

default['mysql']['port']               = 3306
default['mysql']['version']            = '5.5'
default['mysql']['error_log']          = 'var/log/mysql/error.log'
default['mysql']['socket']             = '/var/run/mysqld/mysqld.sock'
default['mysql']['db_name']            = 'db_name'
default['mysql']['data_file']          = '/var/lib/mysql'
default['mysql']['password']           = 'root'
default['mysql']['bind_address']       = '0.0.0.0'
default['mysql']['mysql2_gem_version'] = '0.4.2'

## Nginx-Passenger
default['nginx']['sites_enabled']      = '/etc/nginx/sites-enabled'
default['nginx']['sites_available']    = '/etc/nginx/sites-available'
default['nginx']['log_dir']            = '/var/log/nginx'
default['nginx']['passenger_ruby']     = '/usr/bin/ruby'