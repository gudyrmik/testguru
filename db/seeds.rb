# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create!([
{ title: 'Ruby' },
{ title: 'Metasploit' },
{ title: 'Virtualization' },
{ title: 'CoffeeMaking' },
{ title: 'Misc.' }
])
users = User.create!([
{ name: 'Vasya', login: 'admin', password: "#{Digest::SHA256.hexdigest('f*ck_wordlists!pwd')}" },
{ name: 'Krista', login: 'krista', password: "#{Digest::SHA256.hexdigest('123456')}" },
{ name: 'Bob', login: 'the_boss', password: "#{Digest::SHA256.hexdigest('dg:dtyds34DSD0_aA')}" }
])
tests = Test.create!([
  { title: 'Ruby basic test', level: 0, category_id: categories[0].id, user_id: users[0].id }, 
  { title: 'Ruby advanced test', level: 2, category_id: categories[0].id, user_id: users[0].id },
  { title: 'Ruby for hackers test', level: 3, category_id: categories[0].id, user_id: users[0].id },
  { title: 'Coffee knowledge test', level: 1, category_id: categories[3].id, user_id: users[0].id },
  { title: 'Metasploit test', level: 1, category_id: categories[1].id, user_id: users[0].id },
])
questions = Question.create!([
{ body: 'Does Don Pedro have business with coffee?', test_id: tests[3].id },
{ body: 'What is amortized complexity of Array#sort method?', test_id: tests[1].id },
{ body: 'What is Ruby?', test_id: tests[0].id },
{ body: 'How can a reverse shell be inserted into a task for Thinktetica courses?', test_id: tests[2].id },
{ body: 'What will return 1.object_id == 1.object_id?', test_id: tests[0].id }
])
answers = Answer.create!([
{ body: 'Yes', correct: true, question_id: questions[0].id },
{ body: 'No', correct: false, question_id: questions[0].id },
{ body: 'O(n)', correct: false, question_id: questions[1].id },
{ body: 'O(nlogn)', correct: true, question_id: questions[1].id },
{ body: 'Interpreted programming language', correct: true, question_id: questions[2].id },
{ body: 'Compiled programming language', correct: false, question_id: questions[2].id },
{ body: 'Using social engineering', correct: true, question_id: questions[3].id },
{ body: 'By direct asking reviewer "pleeeeease, insert and run my shellcode"', correct: false, question_id: questions[3].id },
{ body: 'True"', correct: true, question_id: questions[4].id },
{ body: 'False"', correct: false, question_id: questions[4].id }
])