// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

var ready;
ready = function() {
    var checkbox = $('#show-taken-courses');
    var label = $('#show-taken-courses-label');
    var takenCourses = $('#plan-taken-courses');

    // toggle taken courses when checkbox is checked/unchecked
    var setTakenCoursesVisibility = function() {
        if(this.checked) {
            takenCourses.collapse('show');
        } else {
            takenCourses.collapse('hide');
        }
        label.val(this.checked);
    };

    // set initial state
    setTakenCoursesVisibility();

    // listen for checkbox change
    checkbox.change(setTakenCoursesVisibility);
};

$(document).ready(ready);
$(document).on('page:load', ready);
