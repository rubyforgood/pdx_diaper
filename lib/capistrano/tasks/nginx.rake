namespace :nginx do
  desc 'Upload nginx configuration file to web server'
  task :config do
    on roles(:web) do
      config_file = File.expand_path('../../templates/nginx.conf.erb', __FILE__)
      config = ERB.new(File.read(config_file)).result(binding)
      puts config.to_s
      upload! StringIO.new(config), '/tmp/nginx.conf'
      #arguments = :sudo, :mv, '/tmp/nginx.conf', '/etc/nginx/sites-available'
      #execute *arguments
    end
  end

end
