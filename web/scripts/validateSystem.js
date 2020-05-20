function validSystem(element) {
    const submit_btn = document.getElementById("submit-btn");
    const approximation1 = document.getElementById("approximation1");
    const approximation2 = document.getElementById("approximation2");
    const accuracy_field = document.getElementById("Accuracy");

    var approx1 = approximation1.value.replace(/,/, '.');
    var approx2 = approximation2.value.replace(/,/, '.');
    var accuracy = accuracy_field.value.replace(/,/, '.');
    var isValid = isNumber(accuracy) && isNumber(approx1) && isNumber(approx2) && (accuracy > 0) && (accuracy < 1);

    if (!isValid) {
        submit_btn.disabled = true;
    } else {
        submit_btn.disabled = false;
    }
}

function isNumber(n) {
    return !isNaN(parseFloat(n)) && !isNaN(n - 0)
}

function hideOption(selectId, functionName) {
    console.log("disable option");
    $(`#${selectId}>option`).show()
    $(`#${selectId}>option[value=${functionName}]`).hide()
}