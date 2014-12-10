(function () {

  window.SigninPanel = {}

  SigninPanel.controller = function (appCtrl) {
    var ctrl = {
      user: appCtrl.user,
      formValues: {
        username: '',
        password: ''
      }
    }

    ctrl.signin = function (e) {
      e.preventDefault()
      m.request({ method: 'post', url: '/signin', data: ctrl.formValues })
        .then(ctrl.user, signinError)
    }

    ctrl.updateFormVal = function (e) {
      ctrl.formValues[e.target.name] = e.target.value
    }

    return ctrl
  }

  SigninPanel.view = function (ctrl) {
    if (ctrl.user())
      return userInfo(ctrl)
    else
      return signinForm(ctrl)
  }

  var userInfo = function (ctrl) {
    return m('.user-info', [
      m('p', "Welcome, " + ctrl.user().username + "!")
    ])
  }

  var signinForm = function (ctrl) {
    return m('form', { onsubmit: ctrl.signin, onchange: ctrl.updateFormVal }, [
      m('label', 'Username:'),
      m('input[name=username]', { value: ctrl.formValues.username }),
      m('label', 'Password:'),
      m('input[type=password][name=password]', { value: ctrl.formValues.password }),
      m('button', 'Sign In')
    ])
  }

  // Helpers
  function signinError() {
    alert("Invalid username / password")
  }

})()
