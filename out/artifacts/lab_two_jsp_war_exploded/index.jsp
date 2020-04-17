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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
        Группа: P3212  Вариант: 212317</span>
        </th>
    </tr>
    <tr>
        <td width="300px" onclick="newDot(this)">
            <canvas id="plot" width="300px" height="300px">
            </canvas>
        </td>
        <td>
            <form action="controller" method="get">
                <table class="col1" >
                    <tr>
                        <td><label for="selector">X</label></td>
                        <td><select class="custom-select" name="X" id="selector">
                            <option selected="selected" value="-5">-5</option>
                            <option value="-4">-4</option>
                            <option value="-3">-3</option>
                            <option value="-2">-2</option>
                            <option value="-1">-1</option>
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td><label for="Y">Y</label></td>
                        <td colspan=2>
                            <input class="form-control" maxlength="10" size="10" id="Y" placeholder="-3 ... 3" name="Y"
                                   oninput="valid(this)"></td>
                    </tr>
                    <tr>
                        <td>R</td>
                        <td><input class="form-check-input" type="radio" id="1" name="R" value="1" checked="true"><label class="form-check-label" for="1">1</label></td>
                        <td><input class="form-check-input" type="radio" id="2" name="R" value="2"><label class="form-check-label" for="2">2</label></td>
                        <td><input class="form-check-input" type="radio" id="3" name="R" value="3"><label class="form-check-label" for="3">3</label></td>
                        <td><input class="form-check-input" type="radio" id="4" name="R" value="4"><label class="form-check-label"  for="4">4</label></td>
                        <td><input class="form-check-input" type="radio" id="5" name="R" value="5"><label class="form-check-label" for="5">5</label></td>
                    </tr>
                    <tr>
                        <td>
                            <button type='submit' id="submit-btn" class="btn btn-outline-success" name="submit" disabled="true">Отправить</button>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/index.jsp?clear=">
                                <button type='button' id="clear" class="btn btn-outline-info">Очистить</button>
                            </a>
                        </td>
                        <td>
                <span id="error-message">
                  <!-- Error -->
                </span>
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <table id="result" class="table" width="100%" style="padding: 10px;">
                <tr class="text" width="100%">
                    <td width="25%">X</td>
                    <td width="25%">Y</td>
                    <td width="25%">R</td>
                    <td width="25%">RESULT</td>
                </tr>
                <%= holder.toHtmlString()%>
            </table>
        </td>
    </tr>
</table>
<script type="text/javascript" src="scripts/plot.js"></script>
<script type="text/javascript" src="scripts/validate.js"></script>
<script type="text/javascript" src="scripts/jquery-3.4.1.js"></script>
</body>
</html>
