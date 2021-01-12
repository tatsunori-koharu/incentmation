if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function() {
    const ImageList = document.getElementById('preview');

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
      inputHTML.setAttribute('name', 'article[images][]');
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
    // function previewFile(file) {
    //   // プレビュー画像を追加する要素
    //   const preview = document.getElementById('preview');
  
    //   // FileReaderオブジェクトを作成
    //   const reader = new FileReader();
  
    //   // ファイルが読み込まれたときに実行する
    //   reader.onload = function (e) {
    //     const imageUrl = e.target.result; // 画像のURLはevent.target.resultで呼び出せる
    //     const img = document.createElement("img"); // img要素を作成
    //     img.src = imageUrl; // 画像のURLをimg要素にセット
    //     blob = window.URL.createObjectURL(file);
    //     preview.appendChild(img); // #previewの中に追加
        
    //     const inputHTML = document.createElement('input');
    //     inputHTML.setAttribute('name', 'article[images][]');
    //     inputHTML.setAttribute('type', 'file');
    //   }
  
    //   // いざファイルを読み込む
    //   reader.readAsDataURL(file);
    // }

    // const fileInput = document.getElementById('example');
    // function handleFileSelect() {
    //   const files = fileInput.files;
    //   for (let i = 0; i < files.length; i++) {
    //     previewFile(files[i]);
    //   }
    // }
    // fileInput.addEventListener('change', handleFileSelect);

  });
}