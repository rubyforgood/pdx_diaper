namespace :db do
  desc "Rebuild DB"
  task :rebuild => :environment do
  	puts "Rebuilding #{ENV['RAILS_ENV']} db"
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:seed"].invoke
  end
end