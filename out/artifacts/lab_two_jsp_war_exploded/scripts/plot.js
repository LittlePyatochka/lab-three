const canvas = document.getElementById("plot");
const context = canvas.getContext("2d");

function init() {
    // Фигуры
    context.fillStyle = "#CFBFE7";
    context.fillRect(150, 50, 50, 100);
    context.beginPath();
    context.moveTo(150, 150);
    context.lineTo(150, 100);
    context.lineTo(100, 150);
    context.arc(150, 150, 50, 0, Math.PI / 2);
    context.fill();
    context.fillStyle = "black";
    //Оси
    context.beginPath();
    context.moveTo(0, 150);
    context.lineTo(300, 150);
    context.moveTo(150, 0);
    context.lineTo(150, 300);
    context.closePath();
    context.stroke();
    //Cтрелки
    context.beginPath();
    context.moveTo(300, 150);
    context.lineTo(290, 155);
    context.lineTo(290, 145);
    context.moveTo(150, 0);
    context.lineTo(145, 10);
    context.lineTo(155, 10);
    context.fill();
    //Cимволы
    context.font = "15px serif";
    context.fillText("x", 290, 140);
    context.font = "15px serif";
    context.fillText("y", 160, 10);
    context.font = "15px serif";
    context.fillText("R/2", 200, 140);
    context.font = "15px serif";
    context.fillText("R", 250, 140);
    context.font = "15px serif";
    context.fillText("R/2", 160, 100);
    context.font = "15px serif";
    context.fillText("R", 160, 50);
    context.font = "15px serif";
    context.fillText("-R/2", 100, 140);
    context.font = "15px serif";
    context.fillText("-R", 50, 140);
    context.font = "15px serif";
    context.fillText("-R/2", 160, 200);
    context.font = "15px serif";
    context.fillText("-R", 160, 250);
    //Черточки
    context.beginPath();
    context.moveTo(145, 200);
    context.lineTo(155, 200);
    context.moveTo(145, 250);
    context.lineTo(155, 250);
    context.moveTo(145, 100);
    context.lineTo(155, 100);
    context.moveTo(145, 50);
    context.lineTo(155, 50);
    context.moveTo(50, 145);
    context.lineTo(50, 155);
    context.moveTo(100, 145);
    context.lineTo(100, 155);
    context.moveTo(200, 145);
    context.lineTo(200, 155);
    context.moveTo(250, 145);
    context.lineTo(250, 155);
    context.closePath();
    context.stroke();
}

function newDot(e) {
    context.clearRect(0, 0, 300, 300);
    let coord = e.getBoundingClientRect();
    let x = event.clientX - coord.left;
    let y = event.clientY - coord.top; //получили координаты на оси
    let r = get_r(); // узнали занчение radio
    let x_dot = (x - 150) / 100 * r;
    let y_dot = (150 - y) / 100 * r; // получили значение x,y
    console.log(x_dot + " " + y_dot);
    init();
    context.fillStyle = "#000000";
    context.beginPath();
    context.arc(x, y, 2, 0, Math.PI * 2);
    context.stroke();
    context.fill();
    context.closePath();
    $.ajax({
        type: "GET",
        url: "controller",
        data: {X: x_dot, Y: y_dot, R:r},
        success: function (msg) {
            let table_head = "<tr class=\"text\" width=\"100%\">\n" +
                "                    <td width=\"25%\">X</td>\n" +
                "                    <td width=\"25%\">Y</td>\n" +
                "                    <td width=\"25%\">R</td>\n" +
                "                    <td width=\"25%\">RESULT</td>\n" +
                "                </tr>";
            document.getElementById("result").innerHTML = table_head +  msg;
        }
    });
}

window.onload = init;




