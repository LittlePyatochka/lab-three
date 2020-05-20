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
        int iterationNewton = 0;
        double[] resultNewton = new double[2];
        boolean convergeNewton = false;
        if (session.getAttribute("convergeNewton")!= null){
            convergeNewton = (boolean)session.getAttribute("convergeNewton");
            if (convergeNewton){
                if (session.getAttribute("resultNewton") != null && session.getAttribute("iterationNewton") != null) {
                    resultNewton = (double[]) session.getAttribute("resultNewton");
                    iterationNewton = (int) session.getAttribute("iterationNewton");
                }
            }
        }

        int iterationSimple = 0;
        double[] resultSimple = new double[2];
        boolean convergeSimple = false;
        if (session.getAttribute("convergeSimple")!= null){
            convergeSimple = (boolean)session.getAttribute("convergeSimple");
            if (convergeSimple){
                if (session.getAttribute("resultSimple") != null && session.getAttribute("iterationSimple") != null) {
                    resultSimple = (double[]) session.getAttribute("resultSimple");
                    iterationSimple = (int) session.getAttribute("iterationSimple");
                }
            }
        }

        double[][] chart = new double[2][500];
        if (session.getAttribute("chart") != null) {
            chart = (double[][]) session.getAttribute("chart");
        }


        if (session.getAttribute("chart") != null) {
            chart = (double[][]) session.getAttribute("chart");
        }
    %>
</head>
<body>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <th colspan=2; class="header">
            <span style="float: left;">
                <a href="${pageContext.request.contextPath}/System.jsp"><button type="button" class="btn btn-dark" >Systems of equations</button></a></span>
            <span>Equation solution</span>
        </th>
    </tr>
    <tr>
        <td>
            <form action="controller" method="get">
                <table class="col1">
                    <tr>
                        <td><label for="Function">Function</label></td>
                        <td>
                        <select class="custom-select" name="Function" id="Function">
                            <option value="square" selected>x^2-3</option>
                            <option value="cube">x^3-4</option>
                            <option value="sin">sin(x)</option>
                            <option value="cos">cos(x)</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td><label for="LeftLimit">Left limit</label></td>
                        <td colspan=2>
                            <input class="form-control" maxlength="10" size="10" id="LeftLimit" name="LeftLimit"
                                   oninput="valid(this)" value="1">
                        </td>
                    </tr>
                    <tr>
                        <td><label for="RightLimit">Right limit</label></td>
                        <td colspan=2>
                            <input class="form-control" maxlength="10" size="10" id="RightLimit" name="RightLimit"
                                   oninput="valid(this)" value="3">
                        </td>
                    </tr>
                    <tr>
                        <td><label for="Accuracy">Accuracy</label></td>
                        <td colspan=2>
                            <input class="form-control" maxlength="10" size="10" id="Accuracy" placeholder="0.00001"
                                   name="Accuracy" value="0.01"
                                   oninput="valid(this)"></td>
                    </tr>
                    <td colspan="2">
                        <button type='submit' id="submit-btn" style="width: 200;" class="btn btn-outline-success">Solve
                        </button>
                    </td>
                </table>
            </form>
        </td>
        <td>
            <div id="chart"></div>
        </td>
    </tr>
    <tr>
        <td>
            <div><%if (convergeNewton){%>
                Tangent method:<%=  resultNewton[0] %>
                <% }else {%>
                Tangent method: not converge.
                <%  } %>
            </div>
        </td>
    <tr/>
    <tr>
        <td>
            <div><%if (convergeSimple){%>
                Simple iteration:<%=  resultSimple[0] %>
                <% }else {%>
                Simple iteration: not converge.
                <%  } %>
            </div>
        </td>
    </tr>
    <tr>
        <td><div>Number of iterations:</div></td>
    </tr>
    <tr>
        <td><div>Tangent method: <%= iterationSimple %></div></td>
    </tr>
    <tr>
        <td><div>Simple iteration: <%= iterationNewton %></div></td>
    </tr>
</table>
</body>

<script type="text/javascript" src="scripts/validate.js"></script>
<script type="text/javascript" src="scripts/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script type="text/javascript">
    var options = {
        series: [{
            name: "Y",
            type: "line",
            <%--data: [<%= graph[1] %>]--%>
            <% StringBuilder builderY = new StringBuilder();
//            Arrays.stream(chart[1]).forEach(el -> {builderY.append(el); builderY.append(",");});
            for (int i = 0; i < chart[0].length; i++){
                builderY.append("{x:").append(chart[0][i]).append(",y:").append(chart[1][i]).append("},");
            }
            %>
            data: [<%= builderY.toString() %>]
        }, <% if(convergeNewton){ %>
            {
            name: "Newton",
            type: "scatter",
            data: [{
                x: <%= resultNewton[0] %>,
                y:  <%= resultNewton[1] %>
            }]
        },<% } %>
            <% if(convergeSimple){ %> {
            name: "Simple Iteration",
            type: "scatter",
            data: [{
                x: <%= resultSimple [0]%>,
                y: <%= resultSimple [1]%>
            }]
        }<% } %>
        ],
        chart: {
            height: 500,
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
        fill: {
            type: 'solid',
        },
        markers: {
            size: [0, 6, 6]
        },
        tooltip: {
            enabled: true,
            x: {
                show: true,
                formatter: function (value) {
                    return Math.floor(value * 1000) / 1000;
                },
            },
            // shared: false,
            // intersect: true,
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
            <%--            <% StringBuilder builder = new StringBuilder();--%>
            <%--            Arrays.stream(chart[0]).forEach(el -> {builder.append(el); builder.append(",");});--%>
            <%--            %>--%>
            <%--            categories:[ <%= builder.toString() %>],--%>
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
