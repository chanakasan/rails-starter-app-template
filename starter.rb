## append source path
def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

## helpers
require_relative './helpers/basic_helper'
require_relative './helpers/bower_helper'
require_relative './helpers/generators_helper'
require_relative './helpers/npm_helper'

extend BasicHelper
extend BowerHelper
extend GeneratorsHelper
extend NpmHelper

## START
create_new_gemfile
delete_unwanted_files
disable_generators
install_rspec
migrate_database
bundle_install_local

# setup bower assets
set_bower_install_offline_mode(true)
bower_init
bower_install_and_require_package(:bootstrap)
bower_install_and_require_package(:angular)
install_bootstrap_generator_templates

# setup nodejs packages
npm_init_dev

git_initial_commit
## THE END
