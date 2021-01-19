document.addEventListener('DOMContentLoaded', function() {
  $('.item_<%= article.id %>').on('mouseover', function(e) {
    $('.item-img').slideToggle(0);
    $('.item-text_<%= article.id %>').slideToggle(0);
  });
})