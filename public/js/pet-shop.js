(function () {

  window.PetShop = {}

  PetShop.controller = function (appCtrl) {
    var ctrl = {
      activePetShop: appCtrl.activePetShop,
      petShops: appCtrl.petShops
    }

    ctrl.adopt = function (type, petId) {
      if (!appCtrl.user()) {
        return alert("You must log in first!")
      }
      var shop = ctrl.activePetShop()
      var pets = shop[type]
      var adoptUrl = "/shops/" + shop.id + "/" + type + "/" + petId + "/adopt"


      m.request({ method: 'put', url: adoptUrl }).then(function() {
        var pet = pets().find(function(p){ return p.id == petId })
        pet.adopted = true
        appCtrl.user()[type].push(pet)
      }, genericError)
    }

    return ctrl
  }

  PetShop.view = function (ctrl) {
    var shop = ctrl.activePetShop()
    if (!shop) return null

    return m('.pet-shop', [
      m('h1', shop.name),
      petsView(ctrl, 'cats', shop.cats()),
      petsView(ctrl, 'dogs', shop.dogs())
    ])
  }


  var petsView = function (ctrl, type, pets) {
    if (!pets) return null

    var petDivs = pets.map(function(pet) {
      var adoptLink = m('a', {
        onclick: ctrl.adopt.coldCurry(type, pet.id),
        href: '#'
      }, 'Adopt this pet')
      var unAdoptLink = m('a', {
          onclick: ctrl.adopt.coldCurry(type, pet.id),
          href: '#'
      }, 'Ditch this loser pet.')

      return m('.pet', [
        m('.photo',
          m('img', { src: pet.imageUrl })
        ),
        m('.info', [
          m('h4', pet.name),
          m('b', "Adopted: "),
          m('span', pet.adopted ? "Yes!" : "No..."),
          m('br'),
          pet.adopted ? unAdoptLink : adoptLink
        ])
      ])
    })

    return m('.pets-view', { className: type }, [
      m('h2', type.capitalize()),
      petDivs
    ])
  }

  function genericError(e) {
    console.log("An error happened:", e)
    alert("Bad stuff happened (check the console)")
  }
})()
