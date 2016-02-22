#
# Cookbook Name:: employee_availability_system
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install and configure Mysql
# Create DB tables

mysql   = node['mysql']
project = node['project']

mysql_service project['dir_name'] do
  version mysql['version']
  bind_address mysql['bind_address']
  port mysql['port']
  data_dir "#{mysql['data_file']}/#{project['dir_name']}"
  initial_root_password mysql['password']
  action [:create, :start]
end

## Install mysql2 gem
mysql2_chef_gem 'install mysql2 gem' do
  gem_version mysql['mysql2_gem_version']
  client_version mysql['version']
end

## Set up nginx-passenger vhost
nginx                               = node['nginx']
node.set['nginx']['app_error_log']  = sprintf "#{nginx['log_dir']}/%s.error.log", project['dir_name']
node.set['nginx']['app_access_log'] = sprintf "#{nginx['log_dir']}/%s.access.log", project['dir_name']

template "#{nginx['sites_available']}/#{project['dir_name']}.conf" do
  source 'vhost.conf.erb'
  user 'vagrant'
  group 'vagrant'
  mode '0766'
  variables :conf => {
      env:            'development',
      user:           'vagrant',
      server_name:    project['domain'],
      site_root:      "#{project['site_root']}/#{project['dir_name']}",
      passenger_ruby: nginx['passenger_ruby']
  }
end

## enable vhost
link "#{nginx['sites_enabled']}/#{project['dir_name']}.conf" do
  to "#{nginx['sites_available']}/#{project['dir_name']}.conf"
end

## restart nginx
service 'nginx' do
  action :restart
end

## Prepare rails App

site_root = "#{project['site_root']}/#{project['dir_name']}"

# Bundle gems
rvm_shell 'bundle gems' do
  user 'vagrant'
  group 'vagrant'
  cwd site_root
  code 'bundle install'
end

# create DBs
%w(development test production).each do |env|
  rvm_shell 'migrate_rails_database' do
    user 'vagrant'
    group 'vagrant'
    cwd site_root
    code "rake RAILS_ENV=#{env} db:create db:migrate"
  end
end

