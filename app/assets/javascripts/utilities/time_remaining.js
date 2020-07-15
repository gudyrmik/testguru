document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.test-time')

  if(control) {
    var timeRemaining = Math.floor(control.dataset.time)
    var countDownDate = new Date()
    countDownDate.setSeconds(countDownDate.getSeconds() + timeRemaining)

    var timer = setInterval(function() {
      var now = new Date().getTime()
      var distance = countDownDate - now;
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))
      var seconds = Math.floor((distance % (1000 * 60)) / 1000)
      if(distance > 0) {
        control.textContent = 'Time remaining: ' +  Math.round(seconds) + 's'
      } else {
        clearInterval(timer)
        document.querySelector('.answers-form').submit()
      }
    }, 1000)
  }
})
