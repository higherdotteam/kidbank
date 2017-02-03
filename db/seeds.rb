# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Customer.delete_all
Customer.create(fname: 'Jackson', lname: 'Arrow', dob: 7.years.ago, email: 'jsarrow@kid.org', password: '123')
Customer.create(fname: 'Jason', lname: 'Arrow', dob: 4.years.ago, email: 'jgarrow@kid.org', password: '123')
Customer.create(fname: 'Athena', lname: 'Arrow', dob: 1.years.ago, email: 'aarrow@kid.org', password: '123')

Account.delete_all
Account.create(flavor: 'checkings', balance: 100.00, kid_id: Kid.first.id)
Account.create(flavor: 'savings', balance: 1000.00, kid_id: Kid.first.id)

Customer.create(fname: 'Andrew', lname: 'Arrow', dob: 40.years.ago, email: 'andrew@higher.team', password: '123')
