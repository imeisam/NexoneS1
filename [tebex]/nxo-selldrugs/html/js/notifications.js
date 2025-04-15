function Notify(text, type, duration) {
    $.post('https://nxo-selldrugs/notification', JSON.stringify({ text: text, type: type, duration: duration }));
}