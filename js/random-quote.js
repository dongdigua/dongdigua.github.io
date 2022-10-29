var data = [
    "富强民主闻名和谐, 自由平等公正法治, 爱国敬业诚信友善",
    "解放思想, 实事求是, 与时俱进",

    "You are not alone",
    "The internet is FULL, go away!",
    "May the --force be with you",
    "Software that sucks less",
];

var index = Math.floor((Math.random() * data.length));
window.document.getElementById("quote").innerHTML = data[index];
