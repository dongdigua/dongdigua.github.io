var data = [
    "富强民主文明和谐, 自由平等公正法治, 爱国敬业诚信友善",
    "解放思想, 实事求是, 与时俱进",
    "绿水青山就是金山银山",
    "为中华之崛起而读书!",
    "减轻义务教育阶段学生作业负担、减轻校外培训负担",

    "<a id=quote href=https://www.bilibili.com/video/BV1vW411g7tN>谁甘人生黯淡无光 谁愿做叶不争艳芳</a>",
    "Fly high my friend, until we meet again",
    "HsCnPtPYZnSr",
    "There will be an answer: Let It Be",

    "The internet is FULL, go away!",
    "May the --force be with you",
    "<a id=quote href=https://suckless.org>Software that sucks less</a>",
    "whoami: No system is safe",
    "DROP it at <a id=quote href=https://lttstore.com>lttstore.com</a>",
    "Can’t keep up! Is the server overloaded?\nRunning 5000ms or 100 ticks behind",
    "大炮做好了不放珍珠是什么意思?",
    "write terrible nonsensical code to\nensure the Copilot doesn't take over as captain",
    "Automagically",
    "<a id=quote href=https://www.curseforge.com/minecraft/mc-mods/carpet>NOT VANILLA!</a>",
    "Big Brother is Watching You",
    "消除恐惧的最好办法就是面对恐惧,\n坚持, 才是胜利, 加油, 奥利给!",
    "Presenting to the emergency room, unconcious",
    "Never Gonna Give You Up",
    "treat C compiler like your girlfriend",
];

var index = Math.floor((Math.random() * data.length));
window.document.getElementById("quote").innerHTML = data[index];
