## append source path
def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

## helpers
require_relative './helpers/basic_helper'
require_relative './helpers/bower_helper'

extend BasicHelper
extend BowerHelper

## START
create_new_gemfile
delete_unwanted_files
disable_generators
install_rspec
migrate_database
bundle_install_local

# setup bower assets
bower_init
bower_install_and_require_package(:bootstrap)
bower_install_and_require_package(:angular)

git_initial_commit
## THE END
