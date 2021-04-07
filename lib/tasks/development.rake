namespace :checkout do
  namespace :development do
    desc "kill puma"
    task kill: :environment do
      system("kill -9 $(lsof -i tcp:3000 -t)")
    end

    desc "Updates various elements of the system so that they work correctly in the local environment"
    task :setup, [:download_prod_db] => [:environment] do |t, args|
      return unless Rails.env.development?

      database = Rails.configuration.database_configuration["development"]["database"]
      user = ENV["USER"]

      if args[:download_prod_db]
        puts "- Downloading dump"
        system("rm -rf latest.dump")
        system("heroku pg:backups:download -a learne-checkout")
      end

      puts "- Reseting DB"
      system("DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:drop db:create && pg_restore --verbose --clean --no-acl --no-owner -h localhost -U #{user} -d #{database} latest.dump")

      puts "- Running migrations"
      Rake::Task["db:migrate"].invoke
    end
  end
end