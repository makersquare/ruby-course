$(function() {
  var select = $('select');
  var link = $('a');
  select.on('change', function(event) {
    var el = $(event.target);
    var id = el.val();
    var href = link.attr('href');
    href = href + '/' + id;
    link.attr('href', href);
  });
});