module BowerAssets
  PATHS = {
    'bootstrap' => [
      ['bootstrap/dist/js/bootstrap.min'],
      ['bootstrap/dist/css/bootstrap.min']
    ],
    'angular' => [
      ['angular/angular.min']
    ]
  }

  def self.get_paths(package_name)
    PATHS[package_name]
  end
end

module BowerHelper
  APPLICATION_JS = 'app/assets/javascripts/application.js'
  APPLICATION_CSS = 'app/assets/stylesheets/application.css'
  ASSETS_INITIALIZER = 'config/initializers/assets.rb'

  @@bower_install_offline_mode = false

  def set_bower_install_offline_mode(true_or_false)
    @@bower_install_offline_mode = true_or_false
  end


  def bower_init
    create_bower_json
    create_bower_rc
    add_bower_components_path_in_assets_initializer
    run "echo 'app/assets/bower_components' >> .gitignore"

    add_bower_vendor_lines_in_application_js
    add_bower_vendor_lines_in_application_css
  end


  def create_bower_json
    copy_file 'examples/bower.json', 'bower.json'
  end

  def create_bower_rc
    copy_file 'examples/_bowerrc', '.bowerrc'
  end

  def add_bower_components_path_in_assets_initializer
    file_content = <<CODE
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'bower_components').to_s
CODE

    insert_into_file ASSETS_INITIALIZER,
      file_content,
      after: "# Add additional assets to the asset load path\n"
  end


  def bower_install_and_require_package(package_name, *args)
    package_name = package_name.to_s

    asset_paths = BowerAssets.get_paths(package_name)
    fail "Unknown package '#{package_name}'" if asset_paths.nil?

    bower_install(package_name, *args)

    js_paths = asset_paths[0]
    css_paths = asset_paths[1]

    unless js_paths.nil?
      js_paths.each do |js_path|
        add_require_line_for_js(js_path)
      end
    end

    unless css_paths.nil?
      css_paths.each do |css_path|
        add_require_line_for_css(css_path)
      end
    end
  end


  def add_require_line_for_css(path)
    file_content = <<CODE
 *= require #{path}
CODE

    insert_into_file APPLICATION_CSS,
      file_content,
      before: " * ## end bower\n"
  end

  def add_require_line_for_js(path)
    file_content = <<CODE
//= require #{path}
CODE

    insert_into_file APPLICATION_JS,
      file_content,
      before: "// ## end bower\n"
  end

  def add_bower_vendor_lines_in_application_js
    file_content = <<CODE
//
// ## bower
// ## end bower
//
CODE

    insert_into_file APPLICATION_JS,
      file_content,
      before: "//= require_tree .\n"
  end


  def add_bower_vendor_lines_in_application_css
    file_content = <<CODE
 *
 * ## bower
 * ## end bower
 *
CODE

    insert_into_file APPLICATION_CSS,
      file_content,
      before: " *= require_tree .\n"
  end


  def bower_install(package_name=nil, *args)
    options = args.join(' ')
    options << ' --offline' if @@bower_install_offline_mode

    run "bower install #{package_name.to_s} #{options}"
  end
end
