//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require adminlte
//= require_tree ./admin

// AdminLTE
$(document).on('turbolinks:load', function() {
  // Fix the layout height problem with turbolinks.
  $.AdminLTE.layout.activate();
});
