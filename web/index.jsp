<%@ page import="myServlet.ArrayResult" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Enumeration" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>lab 2</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="styles/styles.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <% ArrayResult holder = (ArrayResult) session.getAttribute("result");
        if (holder == null || request.getParameter("clear") != null) {
            holder = new ArrayResult();
            session.setAttribute("result", holder);
            response.sendRedirect("index.jsp");
        }
    %>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <th colspan=2; class="header">
            <span style="float: left;"> Камышанская Ксения </span><span style="float: right;">
        Группа: P3212</span>
        </th>
    </tr>

    <tr>
        <td>
            <div id="chart"></div>
        </td>
    </tr>
    <tr>
        <td>
            <form action="controller" method="get">
                <table class="col1">
                    <tr>
                        <td><label for="Function">Funcrion</label></td>
                        <td colspan=2>
                            <input class="form-control" maxlength="10" size="10" id="Function" placeholder="x1^2+x2"
                                   name="Function"
                                   oninput="valid(this)"></td>
                    </tr>
                    <tr>
                        <td><label for="LeftLimit">Left limit</label></td>
                        <td colspan=2>
                            <input class="form-control" maxlength="10" size="10" id="LeftLimit" name="LeftLimit"
                                   oninput="valid(this)"></td>
                    </tr>
                    <tr>
                        <td><label for="RightLimit">Right limit</label></td>
                        <td colspan=2>
                            <input class="form-control" maxlength="10" size="10" id="RightLimit" name="RightLimit"
                                   oninput="valid(this)"></td>
                    </tr>
                    <tr>
                        <td><label for="Accuracy">Accuracy</label></td>
                        <td colspan=2>
                            <input class="form-control" maxlength="10" size="10" id="Accuracy" placeholder="0.00001"
                                   name="Accuracy"
                                   oninput="valid(this)"></td>
                    </tr>
                    <tr>
                        <td>Method</td>
                        <td><input class="form-check-input" type="radio" id="Newton" name="Method" value="Newton"
                                   checked="true"><label class="form-check-label" for="Newton">Newton</label></td>
                        <td><input class="form-check-input" type="radio" id="Simple_iteration" name="Method"
                                   value="Simple iteration"><label class="form-check-label" for="Simple_iteration">Simple_iteration</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button type='submit' id="submit-btn" class="btn btn-outline-success" name="submit" disabled="true">Submit</button>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/index.jsp?clear=">
                                <button type='button' id="clear" class="btn btn-outline-info">Очистить</button>
                            </a>
                        </td>
                        <td>
                <span id="error-message" >
                  <!-- Error -->
                </span>
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
</body>
<script type="text/javascript" src="scripts/validate.js"></script>
<script type="text/javascript" src="scripts/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script type="text/javascript">
    var options = {
        series: [{
            name: "Desktops",
            data: [10, 41, 35, 51, 49, 62, 69, 91, 148]
        }],
        chart: {
            height: 350,
            type: 'line',
            zoom: {
                enabled: false
            }
        },
        dataLabels: {
            enabled: false
        },
        stroke: {
            curve: 'smooth'
        },
        // title: {
        //     text: 'Product Trends by Month',
        //     align: 'left'
        // },
        grid: {
            row: {
                colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
                opacity: 0.5
            },
        },
        xaxis: {
            categories: [],
        }
    };

    var chart = new ApexCharts(document.querySelector("#chart"), options);
    chart.render();

</script>
</html>
