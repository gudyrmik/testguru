categories = Category.create!([
{ title: 'Ruby' },
{ title: 'Metasploit' },
{ title: 'Virtualization' },
{ title: 'CoffeeMaking' },
{ title: 'Misc.' }
])
users = User.all
tests = Test.create!([
  { title: 'Ruby basic test', level: 0, category: categories[0], user: users[0] }, 
  { title: 'Ruby advanced test', level: 2, category: categories[0], user: users[0] },
  { title: 'Ruby for hackers test', level: 3, category: categories[0], user: users[0] },
  { title: 'Coffee knowledge test', level: 1, category: categories[3], user: users[0] },
  { title: 'Metasploit test', level: 1, category: categories[1], user: users[0] },
])
questions = Question.create!([
{ body: 'Does Don Pedro have business with coffee?', test: tests[3] },
{ body: 'What is amortized complexity of Array#sort method?', test: tests[1] },
{ body: 'What is Ruby?', test: tests[0] },
{ body: 'How can a reverse shell be inserted into a task for Thinktetica courses?', test: tests[2] },
{ body: 'What will return 1.object_id == 1.object_id?', test: tests[0] }
])
answers = Answer.create!([
{ body: 'Yes', correct: true, question: questions[0] },
{ body: 'No', correct: false, question: questions[0] },
{ body: 'O(n)', correct: false, question: questions[1] },
{ body: 'O(nlogn)', correct: true, question: questions[1] },
{ body: 'Interpreted programming language', correct: true, question: questions[2] },
{ body: 'Compiled programming language', correct: false, question: questions[2] },
{ body: 'Using social engineering', correct: true, question: questions[3] },
{ body: 'By direct asking reviewer "pleeeeease, insert and run my shellcode"', correct: false, question: questions[3] },
{ body: 'True"', correct: true, question: questions[4] },
{ body: 'False"', correct: false, question: questions[4] }
])
histories = History.create!([
{ user: users[0], test: tests[0] },
{ user: users[0], test: tests[3] },
{ user: users[0], test: tests[4] },
])