module GeneratorsHelper
  def install_bootstrap_generator_templates
    # add bootstrap layout file
    run 'rm -f app/views/layouts/application.html.erb'
    copy_file 'examples/layouts/starter.html.erb', 'app/views/layouts/application.html.erb'

    # add custom css file
    copy_file 'examples/stylesheets/custom.css', 'app/assets/stylesheets/custom.css'

    # add generator templates
    directory 'lib'
  end
end
