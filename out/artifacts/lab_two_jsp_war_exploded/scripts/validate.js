function valid(element) {
    const Y_field = document.getElementById("Y");
    const submit_btn = document.getElementById("submit-btn");
    const errmsg = document.getElementById("error-message");
    var Y = Y_field.value.replace(/,/, '.');
    var isValid = isNumber(Y);
    var isValid = isValid && (Y <= 3) && (Y >= -3);
    if (!isValid) {
        submit_btn.disabled = true;
        errmsg.textContent = "Error";
        // console.log("jkj");

    } else {
        submit_btn.disabled = false;
        // console.log("false");
        errmsg.textContent = "";
    }

}

function isNumber(n) {
    return !isNaN(parseFloat(n)) && !isNaN(n - 0)
}

function get_r() {
    let rad = document.getElementsByName('R');
    // console.log(rad);
    let R;
    rad.forEach(function (radion) {
        if (radion.checked) {
            R = radion.value;
            console.log(R);
        }
    });
    return R;
}