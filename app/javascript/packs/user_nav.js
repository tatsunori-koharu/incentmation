document.addEventListener('DOMContentLoaded', function() {
  $('.user-menu').on('mouseover', function(e) {
    $('.user-nav-btn').slideDown(0);
  });
  $('.user-nav').on('mouseout', function(e) {
    $('.user-nav-btn').slideUp(0);
  });
})