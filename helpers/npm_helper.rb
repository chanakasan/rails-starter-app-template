module NpmHelper
  def create_package_json
    copy_file 'examples/package.json', 'package.json'
  end

  def create_karma_conf
    copy_file 'examples/karma.conf.js', 'karma.conf.js'
  end

  def npm_install
    run 'npm install'
  end

  def npm_install_package(package_name, dev=false)
    if dev
      run "npm install #{package_name} --save-dev"
    else
      run "npm install #{package_name} --save"
    end
  end
end
