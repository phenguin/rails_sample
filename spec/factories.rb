# Factory Girl simulates the user model due to 
# use of the symbol :user
Factory.define :user do |user|
  user.name "Justin Cullen"
  user.email "jcullen@example.com"
  user.password "secrets"
  user.password_confirmation "secrets"
end
