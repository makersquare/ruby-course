(function () {

  window.PetContainer = {}

  PetContainer.controller = function (appCtrl) {
    var ctrl = {
      user: appCtrl.user
    }

    return ctrl
  }

  PetContainer.view = function (ctrl) {
    var content
    if (ctrl.user()) {
      content = [
        petsView(ctrl, 'cats', ctrl.user().cats),
        petsView(ctrl, 'dogs', ctrl.user().dogs)
      ]
    }
    else {
      content = m('h3', "Please sign in first.")
    }

    return m('.pet-container', [
      m('h1', "Your Pet Container"),
      content
    ])
  }

  var petsView = function (ctrl, type, pets) {

    var petDivs = pets.map(function(pet) {
      return m('.pet', [
        m('.photo',
          m('img', { src: pet.imageUrl })
        ),
        m('.info', [
          m('h4', pet.name)
        ])
      ])
    })

    return m('.pets-view', { className: type }, [
      m('h2', "Your " + type.capitalize()),
      petDivs
    ])
  }

})()