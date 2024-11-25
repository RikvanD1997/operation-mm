const msg_container = document.getElementById("msg-container");
const message_masonry = new Masonry(msg_container, {
    itemSelector: ".msg",
    gutter: 20,
    fitWidth: true,
    layoutInstant: true,
    initLayout: false
});
// HACK: Delay layout to next frame for Safari shenanigans (layout running before window has correct size values)
requestAnimationFrame(() => {
    message_masonry.layout();
});
