function valid(element) {
    const submit_btn = document.getElementById("submit-btn");
    const errmsg = document.getElementById("error-message");
    const left_field = document.getElementById("LeftLimit");
    const right_field = document.getElementById("RightLimit");
    const accuracy_field = document.getElementById("Accuracy");

    var left = left_field.value.replace(/,/, '.');
    var right = right_field.value.replace(/,/, '.');
    var accuracy = accuracy_field.value.replace(/,/, '.');
    var isValid = isNumber(accuracy) && isNumber(right) && isNumber(left) && (accuracy > 0);

    if (!isValid) {
        submit_btn.disabled = true;
        errmsg.textContent = "Error";
    } else {
        submit_btn.disabled = false;
        errmsg.textContent = "";
    }
}

function isNumber(n) {
    return !isNaN(parseFloat(n)) && !isNaN(n - 0)
}

function get_Method() {
    let rad = document.getElementsByName('Method');
    let method;
    rad.forEach(function (radion) {
        if (radion.checked) {
            method = radion.value;
        }
    });
    return method;
}