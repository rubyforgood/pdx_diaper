namespace :unicorn do
  desc 'Upload unicorn service script file to app server'
  task :initd do
    on roles(:app) do
      config_file = File.expand_path('../../templates/unicorn.erb', __FILE__)
      config = ERB.new(File.read(config_file)).result(binding)
      puts config.to_s
      upload! StringIO.new(config), '/tmp/unicorn'
      #arguments = :sudo, :mv, '/tmp/unicorn', "/etc/init.d/unicorn_#{fetch(:application)}"
      #execute *arguments
      #execute :chmod, 755, "/etc/init.d/unicorn_#{fetch(:application)}"
    end
  end
end
