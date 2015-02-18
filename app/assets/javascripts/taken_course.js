// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

// Remove the modal content when it is hidden
var ready;
ready = function() {
    $('main').on('hidden.bs.modal', '.modal', function () {
        $('.modal').remove();
    });
    $('main').on('shown.bs.modal', '.modal', function () {
        $('#taken_course_quarter').focus();
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);
