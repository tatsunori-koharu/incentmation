// function message() {
//   const submit = document.getElementById("submit");
//   submit.addEventListener("click", (e) => {
//     const formData = new FormData(document.getElementById("form"));
//     const XHR = new XMLHttpRequest();
//       XHR.open("POST", `/chats/:chat_id => (${chat.id}/chat_messages`, true);
//       XHR.responseType = "json";
//       XHR.send(formData);
//       XHR.onload = () => {
//         if (XHR.status != 200) {
//           alert(`Error ${XHR.status}: ${XHR.statusText}`);
//           return null;
//         }
//         const chat = XHR.response.post;
//         const messages = document.getElementById("messages");
//         const formText = document.getElementById("content");
//         const HTML = `
//           <div>
//             ${chat.message}
//           </div>`;
//         message.insertAdjacentHTML("afterend", HTML);
//         formText.value = "";
//       };
//       e.preventDefault();
//   });
// }
// window.addEventListener("load", message);