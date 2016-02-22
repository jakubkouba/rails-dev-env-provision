name             'rails_dev_setup'
maintainer       'Jakub Adler'
maintainer_email 'adler.jakub@gmail.com'
license          'All rights reserved'
description      'Installs/Configures software needed for running rails app'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'mysql', '~> 6.0'
depends 'mysql2_chef_gem', '~> 1.0.2'
depends 'database', '~> 4.0.9'