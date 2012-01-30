namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_topics
  end
end

def make_users
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

def make_topics
  topics = %w{Literature Mathematics Animals Psychology Science Archaeology
  Painting Debating Racketeering Scheming Oodling Noodling Doodling Programming
  Racing Blahblahblah}

  topics.length.times do |n|
    name = topics[n]
    description = Faker::Lorem.sentence(8)
    Topic.create!(:name => name,
                  :description => description)
  end

  user = User.first
  Topic.all[1..10].each do |topic|
    user.subscribe!(topic)
  end

end
