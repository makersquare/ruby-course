(function () {

  var slice = Array.prototype.slice

  if (!Array.prototype.find) {
    Array.prototype.find = function (f) {
      for (var i=0; i < this.length; i++) {
        if ( f(this[i]) ) return this[i]
      }
    }
  }

  if (!String.prototype.capitalize) {
    String.prototype.capitalize = function () {
      return this[0].toUpperCase() + this.substring(1).toLowerCase()
    }
  }

  Function.prototype.curry = function() {
    var args, fn;
    fn = this
    args = slice.call(arguments)
    return function() {
      return fn.apply(this, args.concat(slice.call(arguments)))
    }
  }

  // Curry and prevent default in one go
  Function.prototype.coldCurry = function() {
    var args, fn;
    fn = this;
    args = slice.call(arguments);
    return function(e) {
      e.preventDefault();
      return fn.apply(this, args.concat(slice.call(arguments, 1)));
    };
  };

})()
