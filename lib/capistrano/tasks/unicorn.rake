namespace :load do
  task :defaults do
    set :unicorn_pid, -> { File.join(current_path, "tmp", "pids", "unicorn.pid") }
  end
end

namespace :unicorn do
  desc 'Upload unicorn service script file to app server'
  task :initd do
    on roles(:app) do
      config_file = File.expand_path('../../templates/unicorn.erb', __FILE__)
      config = ERB.new(File.read(config_file)).result(binding)
      upload! StringIO.new(config), '/tmp/unicorn'
      arguments = :sudo, :mv, '/tmp/unicorn', "/etc/init.d/unicorn_#{fetch(:application)}"
      execute *arguments
      execute :chmod, 755, "/etc/init.d/unicorn_#{fetch(:application)}"
    end
  end

  desc 'Start unicorn application server'
  task :start do
    on roles(:app) do
      within current_path do
        if test("[ -e #{fetch(:unicorn_pid)} ] && kill -0 #{pid}")
          info "unicorn is running..."
        else
          with rails_env: fetch(:rails_env) do
            execute :sudo, "/etc/init.d/unicorn_#{fetch(:application)}", "start"
          end
        end
      end
    end
  end

  desc "Stop Unicorn (QUIT)"
  task :stop do
    on roles(:app) do
      within current_path do
        if test("[ -e #{fetch(:unicorn_pid)} ]")
          info "stopping unicorn..."
          execute :sudo, "/etc/init.d/unicorn_#{fetch(:application)}", "stop"
        else
          info "unicorn is not running..."
        end
      end
    end
  end

  desc "Restart Unicorn (USR2); use this when preload_app: true"
  task :restart do
    invoke "unicorn:start"
    on roles(:app) do
      within current_path do
        info "unicorn restarting..."
        execute :sudo, "/etc/init.d/unicorn_#{fetch(:application)}", "restart"
      end
    end
  end

    def pid
      "`cat #{fetch(:unicorn_pid)}`"
    end
  end
