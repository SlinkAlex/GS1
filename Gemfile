source 'https://rubygems.org'

gem 'rails', '4.0.0'


# adaptador SQLServer
gem 'tiny_tds'

# Ojo este adpatador solo funciona con arel 4.0.0
gem 'activerecord-sqlserver-adapter', github: 'rnhurt/activerecord-sqlserver-adapter', branch: '4.0.0' 
gem 'arel', '4.0.0'

gem 'sqlite3'

# Generar vistas HAML
gem "haml-rails"

gem "will_paginate"


# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails'
gem 'coffee-rails'


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

# para utilizar datatables

gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'

gem 'jquery-ui-rails'

gem 'uglifier'


gem 'ajax-datatables-rails'
gem 'jquery-rails'

# gema para manejar el Excel
gem 'axlsx_rails'


gem 'prawn'
gem 'prawn-table'


gem "roo" # Gema para importar archivos Excel

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', :require => "bcrypt"

gem 'daemons'
gem 'delayed_job_active_record' ## GEma para menejar procesos en BACKGROUND
gem "delayed_job_web" # Herramienta Web que permite monitorear la cola de procesoso en BACKGROUND

# Estas Gemas son necesarias mientras se hace la migracion del codigo proctected_attributes, model.finders ya no se utiliza

gem 'protected_attributes'
gem 'rails-observers', '0.1.2'
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'activerecord-deprecated_finders'


# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
 gem 'unicorn' 
 gem 'nokogiri', '~> 1.6.1'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'json', '>= 1.8'
gem 'bundler', '1.17.3' 
gem 'axlsx', '~> 2.0.1'

gem 'mini_portile', '= 0.6.2'
gem 'rb-inotify', '= 0.9.7'

group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
    gem 'hirb'
end
