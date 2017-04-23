// This is where it all goes :)
//= require jquery.min
//= require bootstrap.min
//= require smooth-scroll.min
//= require main.js
//= require jquery.lazyload-any.min.js
$(document).ready(function() {

    function load(img) {
        img.fadeOut(0, function() {
            img.fadeIn(1000);
        });
    }
    $('.lazyload').lazyload({load: load});


    $('[data-toggle="tooltip"]').tooltip();

});
