document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.test-time')

  if(control) {
    var timer = setInterval(function() {
      var timeRemaining = control.dataset.time
      console.log(control.dataset.result)
      if(timeRemaining > 0) {
        control.textContent = 'Time remaining: ' +  Math.round(timeRemaining) + 's';
      } else {
        window.location = control.dataset.result
      }
    }, 1000);
  }
})
