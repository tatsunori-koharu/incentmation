if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function() {
    const ImageList = document.getElementById('p_preview');

    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div')
      imageElement.setAttribute('class', "image-element")
      let imageElementNum = document.querySelectorAll('.image-element').length


      const blobImage = document.createElement('img');
      blobImage.width = 300;
      blobImage.height = 180;
      blobImage.setAttribute('src', blob);

      const inputHTML = document.createElement('input');
      inputHTML.setAttribute('id', `example_${imageElementNum}`);
      inputHTML.setAttribute('name', 'promotion[images][]');
      inputHTML.setAttribute('type', 'file');

      const removeImage = document.createElement('button');
      removeImage.addEventListener('click', (blob) => {
        imageElementNum.remove(blob);
      })

      imageElement.appendChild(blobImage);
      blobImage.appendChild(removeImage);
      ImageList.appendChild(imageElement);
      imageElement.appendChild(inputHTML);

      inputHTML.addEventListener('change', (e) => {
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);

        createImageHTML(blob);
      })
    };

    document.getElementById('example').addEventListener('change', (e) => {
      let file = e.target.files[0];
      let blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
}