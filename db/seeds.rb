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
{ title: 'CoffeMaking' },
{ title: 'Misc.' }
])
tests = Test.create!([
  { title: 'Ruby basic test', level: 0, category_id: 1 }, 
  { title: 'Ruby advanced test', level: 2, category_id: 1 },
  { title: 'Ruby for hackers test', level: 3, category_id: 1 },
  { title: 'Coffee knowledge test', level: 1, category_id: 4 },
  { title: 'Metasploit test', level: 1, category_id: 2 },
])
users = User.create!([
{ name: 'Vasya', login: 'admin', password: "#{Digest::SHA256.hexdigest('f*ck_wordlists!pwd')}" },
{ name: 'Krista', login: 'krista', password: "#{Digest::SHA256.hexdigest('123456')}" },
{ name: 'Bob', login: 'the_boss', password: "#{Digest::SHA256.hexdigest('dg:dtyds34DSD0_aA')}" }
])
questions = Question.create!([
{ body: 'Does Don Pedro have business with coffee?', test_id: 4 },
{ body: 'What is amortized complexity of Array#sort method?', test_id: 2 },
{ body: 'What is Ruby?', test_id: 1 },
{ body: 'How can a reverse shell be inserted into a task for Thinktetica courses?', test_id: 3 },
{ body: 'What will return 1.object_id == 1.object_id?', test_id: 1 }
])

answers = Answer.create!([
{ body: 'Yes', correct: true, question_id: 1 },
{ body: 'No', correct: false, question_id: 1 },
{ body: 'O(n)', correct: false, question_id: 2 },
{ body: 'O(nlogn)', correct: true, question_id: 2 },
{ body: 'Interpreted programming language', correct: true, question_id: 3 },
{ body: 'Compiled programming language', correct: false, question_id: 3 },
{ body: 'Using social engineering', correct: true, question_id: 4 },
{ body: 'By direct asking reviewer "pleeeeease, insert and run my shellcode"', correct: false, question_id: 4 },
{ body: 'True"', correct: true, question_id: 5 },
{ body: 'False"', correct: false, question_id: 5 }
])
histories = History.create!([
{ user_id: 1, test_id: 1 },
{ user_id: 1, test_id: 2 },
{ user_id: 1, test_id: 4 },
])