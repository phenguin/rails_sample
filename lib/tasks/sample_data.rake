namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin1 = User.create!(:name => "Justin",
                         :email => "jcullen@mit.edu",
                         :password => "justin",
                         :password_confirmation => "justin")
    admin2 = User.create!(:name => "Rigsby",
                         :email => "rigsby@mit.edu",
                         :password => "stephen",
                         :password_confirmation => "stephen")
    admin1.toggle!(:admin)
    admin2.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "person-#{n}@example.com"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
