// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

// Remove the modal content when it is hidden
var ready;
ready = function() {
    // alert("ready called");
    $('main').on('hidden.bs.modal', '.modal', function (e) {
        $('.modal').remove();
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);
