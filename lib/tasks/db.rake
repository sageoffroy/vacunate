# lib/tasks/db.rake

# dump the development db
#rake db:dump

# dump the production db
#RAILS_ENV=production rake db:dump

# dump the production db & restore it to the development db
#RAILS_ENV=production rake db:dump
#rake db:restore

# note: config/database.yml is used for database configuration,
#       but you will be prompted for the database user's password


namespace :db do

  desc "Dumps the database to db/APP_NAME.dump"
  task :dump => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      cmd = "pg_dump -F c -v -h #{host} #{db} -f /tmp/#{db}.psql -U #{user}"
    end
    puts cmd
    exec cmd
  end

  desc "Restores the database dump at db/APP_NAME.dump."
  task :restore => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      cmd = "pg_restore -c -C -F c -h #{host} -U #{user} -d #{db} -v '/tmp/#{db}.psql'"


    end
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end

  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
      ActiveRecord::Base.connection_config[:host],
      ActiveRecord::Base.connection_config[:database],
      ActiveRecord::Base.connection_config[:username],
  end

end