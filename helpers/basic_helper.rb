module BasicHelper
  def create_new_gemfile
    run 'rm -f Gemfile'
    copy_file 'examples/Gemfile', 'Gemfile'
  end

  def disable_generators
    file_content = <<CODE
    config.generators do |g|
      g.test_framework  :rspec, :fixture => false

      g.assets false
      g.helper false

      g.model_specs false
      g.controller_specs false
      g.view_specs false
      g.routing_specs false
      g.request_specs false
      g.factory_girl false
    end
CODE
    insert_into_file 'config/application.rb',
      file_content, after: "config.active_record.raise_in_transactional_callbacks = true\n"
  end

  def bundle_install_local
    run "bundle install --local"
  end

  def install_rspec
    generate "rspec:install"
  end

  def delete_unwanted_files
    run "rm -rf test"
    run "rm -f README.rdoc"
  end

  def migrate_database
    rake "db:migrate"
  end

  def git_initial_commit
    after_bundle do
      git :init
      git add: "."
      git commit: "-m 'Initial commit'"
    end
  end
end
