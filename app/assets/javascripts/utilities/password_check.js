document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.password-input')
  if(control) { control.addEventListener('input', verifyInput) }
})

document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.password-confirmation')
  if(control) { control.addEventListener('input', verifyConfirmation) }
})

function verifyInput() {
  var password_input = document.getElementById("user_password").value

  if(password_input) {
    this.querySelector('.octicon-north-star').classList.remove('hide')
  }
}

function verifyConfirmation() {
  var password_input = document.getElementById("user_password").value
  var password_confirmation = document.getElementById("user_password_confirmation").value

  if(password_confirmation) {
    this.querySelector('.octicon-north-star').classList.remove('hide')

    if(password_input != password_confirmation) {
      this.querySelector('.octicon-north-star').classList.remove('password-match')
      this.querySelector('.octicon-north-star').classList.add('password-mismatch')
    }

    if(password_input == password_confirmation) {
      this.querySelector('.octicon-north-star').classList.add('password-match')
      this.querySelector('.octicon-north-star').classList.remove('password-mismatch')
    }
  }
}