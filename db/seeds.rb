# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Customer.delete_all
k1=Customer.create(fname: 'Jackson', lname: 'Arrow', dob: 7.years.ago, email: 'jsarrow@kid.org', password: 'dog123')
k2=Customer.create(fname: 'Jason', lname: 'Arrow', dob: 4.years.ago, email: 'jgarrow@kid.org', password: 'cat123')
k3=Customer.create(fname: 'Athena', lname: 'Arrow', dob: 1.years.ago, email: 'aarrow@kid.org', password: 'fish123')

Token.delete_all
Token.create(customer_id: k1.id, token: 'AB467-1389', flavor: 'apple')
Token.create(customer_id: k1.id, token: 'AB467-1390', flavor: 'android')
Token.create(customer_id: k1.id, token: 'AB467-1391', flavor: 'html5')

Account.delete_all
Account.create(flavor: 'checkings', balance: 100.00, kid_id: k1.id)
Account.create(flavor: 'savings', balance: 1000.00, kid_id: k1.id)

p1=Customer.create(fname: 'Andrew', lname: 'Arrow', dob: 40.years.ago, email: 'andrew@higher.team', password: '123')

KidGrownup.create(kid_id: k1.id, grownup_id: p1.id)
KidGrownup.create(kid_id: k2.id, grownup_id: p1.id)
KidGrownup.create(kid_id: k3.id, grownup_id: p1.id)

Activity.delete_all
Activity.create(account_id: Account.first.id, amount: 300, action: 'deposit', happened_at: Time.now)
Activity.create(account_id: Account.first.id, amount: 150, action: 'transfer', happened_at: 2.days.ago)
Activity.create(account_id: Account.first.id, amount: 660, action: 'check', happened_at: 3.days.ago)
Activity.create(account_id: Account.first.id, amount: 1000, action: 'transfer', happened_at: 1.month.ago)
Activity.create(account_id: Account.second.id, amount: 354, action: 'check', happened_at: Time.now)
Activity.create(account_id: Account.second.id, amount: 111, action: 'deposit', happened_at: 15.days.ago)
Activity.create(account_id: Account.second.id, amount: 200, action: 'deposit', happened_at: 1.month.ago)


