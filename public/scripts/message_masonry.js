const msg_container = document.getElementById("msg-container");
const message_masonry = new Masonry(msg_container, {
    itemSelector: ".msg",
    gutter: 20,
    fitWidth: true,
    layoutInstant: true
});
