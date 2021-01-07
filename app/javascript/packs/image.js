$('#item_images').on('change', function(e){
  var files = e.target.files;
  var d = (new $.Deferred()).resolve();
  $.each(files, function(i,file){
    d = d.then(function(data){
      return previewImage(file, data.image_id);
    });
  });
  $('#item_images').val('');
});

var previewImage = function(imageFile){
  var reader = new FileReader();
  var img = new Image();
  var def = $.Deferred();
  reader.onload = function(e){
    var image_box = $('<div>', {class: 'image-box'});
    image_box.append(img);
    image_box.append($('<input>').attr({
      name: "article[images][]",
      value: image_id,
      style: "display: none;",
      type: "hidden",
      class: "article-images-input"
    }));
    image_box.append('<a href="" class="btn-edit">編集</a>');
    image_box.append($('<input>').attr({
      name: "edit-image[]",
      style: "display: none",
      type: "file",
      class: "edit-image-file-input file-input"
    }));
    image_box.append('<a href="" class="btn-delete">削除</a>');
    $('.image_field').append(image_box);
    img.src = e.target.result;
    def.resolve();
  };
  reader.readAsDataURL(imageFile);
  return def.promise();
}

var Uploader = {
  upload: function(imageFile){
    var def = $.Deferred();
    var formData = new FormData();
    formData.append('image', imageFile);
    $.ajax({
      type: "POST",
      url: '/article/upload_image',
      dataType: 'json',
      processData: false,
      contentType: false,
      success: def.resolve
    })
    return def.promise();
  }
}