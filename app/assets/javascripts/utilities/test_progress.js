document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.test-progress')

  if(control) {
    console.log('progress')
    var currentQuestion = control.dataset.currentQuestion
    var totalQuestions = control.dataset.totalQuestions

    control.textContent = 'Progress: ' + (currentQuestion / totalQuestions) * 100 + '%'
  }
})
