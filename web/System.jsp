<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Enumeration" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>lab 3</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="styles/styles.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <%
        double result[] = new double[2];
        int iteration = 0;
        boolean existence_solution = false;
        boolean converge = true;
        if (session.getAttribute("result") != null && session.getAttribute("iteration") != null) {
            result = (double[]) session.getAttribute("result");
            iteration = (int) session.getAttribute("iteration");
            existence_solution = true;
        }else if  (session.getAttribute("iteration") != null){
            iteration = (int) session.getAttribute("iteration");
            existence_solution = false;
            converge = false;
        }

        double[][] chartSystem = new double[3][300];
        if (session.getAttribute("chartSystem") != null) {
            chartSystem = (double[][]) session.getAttribute("chartSystem");
        }
    %>
</head>
<body>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <th class="headerSystem" colspan="2">
            <span style="float: left;">
                <a href="${pageContext.request.contextPath}/index.jsp">
                <button type='button' id="system" class="btn btn-dark">One equations</button></a>
            </span>
            <span>Solution of systems of equations</span>
        </th>
    </tr>
    <tr>
        <td width="370px">
            <form action="controller" method="post">
                <table class="col2">
                    <tr>
                        <td><label for="Function1">Function first</label></td>
                        <td width="200px">
                            <select class="custom-select" name="Function1" id="Function1">
                                <option value="line" selected onclick="hideOption('Function2', 'line')">x1 - x2 = -0.5</option>
                                <option value="cube" onclick="hideOption('Function2', 'cube')">x1 - x2^3 = 16</option>

                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="Function2">Function second</label></td>
                        <td>
                            <select class="custom-select" name="Function2" id="Function2">
                                <option value="square" onclick="hideOption('Function1', 'square')">x1^2 + 3 * x2 = 1</option>
                                <option value="cos" onclick="hideOption('Function1', 'cos')">cos(x1) + x2 = 3</option>
<%--                                <option value="sin" onclick="hideOption('Function1', 'sin')">sin(x1) + x2 = 10</option>--%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="approximation1">Start X1</label></td>
                        <td>
                            <input class="form-control" maxlength="10" size="10" id="approximation1"
                                   name="approximation1"
                                   oninput="validSystem(this)" value="1">
                        </td>
                    </tr>
                    <tr>
                        <td><label for="approximation2">Start X2</label></td>
                        <td>
                            <input class="form-control" maxlength="10" size="10" id="approximation2"
                                   name="approximation2"
                                   oninput="validSystem(this)" value="3">
                        </td>
                    </tr>
                    <tr>
                        <td><label for="Accuracy">Accuracy</label></td>
                        <td colspan=2>
                            <input class="form-control" maxlength="10" size="10" id="Accuracy" name="Accuracy"
                                   oninput="validSystem(this)" value="0.001">
                        </td>
                    </tr>
                    <td colspan="2">
                        <button type='submit' id="submit-btn" style="width: 170;" class="btn btn-outline-success"
                                name="submit">Solve
                        </button>
                    </td>
                </table>
            </form>
        </td>
        <td>
            <div id="chart"></div>
        </td>
    </tr>
    <%if (converge) {%>
    <tr>
        <td>
            <div> X1 = <%= result[0] %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div> X2 = <%= result[1] %>
            </div>
        </td>
    </tr>
    <% } else{ %>
    <tr>
        <td>
            <div>Iterative process diverges</div>
        </td>
    </tr
    ><% } %>
    <tr>
        <td>
        <div>Number of iterations: <%= iteration %></div>
        </td>
    </tr>
</table>
</body>
<script type="text/javascript" src="scripts/validateSystem.js"></script>
<script type="text/javascript" src="scripts/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script type="text/javascript">
    var options = {
        series:
            <%
                double[][] arr = new double[3][100];
                StringBuilder builder1 = new StringBuilder();
                StringBuilder builder2 = new StringBuilder();
            for (int i = 0; i < chartSystem[0].length; i++){
                builder1.append("{x:").append(chartSystem[0][i]).append(",y:").append(chartSystem[1][i]).append("},");
                builder2.append("{x:").append(chartSystem[0][i]).append(",y:").append(chartSystem[2][i]).append("},");
            }
            %>
            [{
                name: "y1",
                type: "line",

                data: [<%= builder1.toString() %>]
            }, {
                name: "y2",
                type: "line",


                data: [<%= builder2.toString() %>]
            },
                <% if(existence_solution){%>
                {
                name: "result",
                type: "scatter",
                data: [{
                    x: <%= result[0]%>,
                    y: <%= result[1]%>
                }]
            }
                <%}%>]
        ,
        markers: {
            size: [0, 0, 6]
        },
        chart: {
            height: 400,
            type: 'line',
            zoom: {
                enabled: true
            }
        },
        dataLabels: {
            enabled: false
        },
        stroke: {
            curve: 'straight'
        },
        tooltip: {
            enabled: true,
            shared: true,
            x: {
                show: true,
                formatter: function (value) {
                    return Math.floor(value * 1000) / 1000;
                },
            },
        },
        grid: {
            row: {
                colors: ['#e5e5e5', 'transparent'],
                opacity: 0.5
            },
            xaxis: {
                lines: {
                    show: true
                }
            }
        },
        yaxis: {
            labels: {
                formatter: function (value) {
                    return Math.floor(value * 1000) / 1000;
                }
            },
        },
        xaxis: {
            <% StringBuilder builder = new StringBuilder();
            Arrays.stream(chartSystem[0]).forEach(el -> {builder.append(el); builder.append(",");});%>
            categories: [<%= builder.toString() %>],
            type: 'numeric',
            lines: {
                show: true,
            }
        }
    };

    var chart = new ApexCharts(document.querySelector("#chart"), options);
    chart.render();
</script>
</html>