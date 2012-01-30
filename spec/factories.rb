# Factory Girl simulates the user model due to 
# use of the symbol :user
#
Factory.define :user do |user|
  user.name "Justin Cullen"
  user.email "jcullen@example.com"
  user.password "secrets"
  user.password_confirmation "secrets"
end

Factory.define :group do |group|
  group.name "Machine Learning Study Group"
  group.creator_id 1
end

Factory.define :topic do |topic|
  topic.name "Machine Learning"
  topic.description %{Learn how to inadvertently make robots kill people!}
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :topic do |n|
  "Interesting Topic #{n}"
end

