//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require tether/dist/js/tether
//= require bootstrap/dist/js/bootstrap
//= require datatables.net/js/jquery.dataTables
//= require datatables.net-responsive/js/dataTables.responsive
//= require_tree .

$(document).on("ready turbolinks:load",function(){
  $("[data-toggle='tooltip']").tooltip();
});
