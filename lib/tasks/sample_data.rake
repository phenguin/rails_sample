namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_topics
    make_groups
    make_weeks
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
  Computers OtherNerdyShit}

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

def make_articles
  links = ['http://www.google.com',
    'http://facebook.com',
    'http://www.washingtonpost.com/national/gingrich-delivers-on-wild-and-wooly-vow/2012/01/29/gIQA0sUAbQ_story.html',
    'http://lindsaar.net/2010/5/9/Getting-Rails-3-Edge-with-jQuery-RSpec-and-Cucumber-using-RVM',
    'http://www.rubyfocus.biz/blog/2011/06/15/access_control_101_in_rails_and_the_citibank-hack.html   ',
    'http://www.linuxstall.com/linux-command-line-tips-that-every-linux-user-should-know/',
    'http://mirnazim.org/writings/vim-plugins-i-use/']

  titles = ['Whoa its google!',
    'Facebook.. how cool',
    'Gingrich delivers on wild and wooly vow - Washington Post',
    'Getting Rails 3 Edge with jQuery, RSpec, and Cucumber using RVM',
    'Access Control 101 in rails and the citibank hack',
    'Linux command line tips that every linux user should know',
    'Vim plugins I use']

  [1..links.length].each do |n|
    article = Article.create( :link => links[n], :title => titles[n] )
  end

end

def make_groups
  user = User.first
  group1 = Group.create( :name => "Sociology Study Group")
  group2 = Group.create( :name => "Cool Kids Learning Group")

  Topic.all[0..4].each do |topic|
    group1.topic_add!(topic)
  end

  Topic.all[3..8].each do |topic|
    group2.topic_add!(topic)
  end

  User.all[0..6].each do |u|
    u.group_join!(group1)
  end



  User.all[4..9].each do |u|
    u.group_join!(group2)
  end

  User.all[0].group_join!(group2).toggle(:admin)

end

def make_weeks
  [1,2,3,4].each do |n|
    Group.all.each do |group|
      Week.create!(:group_id => group.id, :week_number => n)
    end
  end
end
