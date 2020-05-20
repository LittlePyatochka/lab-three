package myServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double accuracy, leftLimit, rightLimit;
        boolean convergeNewton, convergeSimple;
        String function, derivative;
        NumericalMethod calculation;
        double[] resultNewton = new  double[2];
        double[] resultSimple = new double[2];

        accuracy = Double.parseDouble(request.getParameter("Accuracy"));
        leftLimit = Double.parseDouble(request.getParameter("LeftLimit"));
        rightLimit = Double.parseDouble(request.getParameter("RightLimit"));
        function = request.getParameter("Function");
        derivative = "derivative_".concat(function);
        HttpSession session = request.getSession();

        calculation = new NumericalMethod(leftLimit, rightLimit, accuracy, function, derivative);
        try {
            convergeNewton = calculation.isСonvergeForNewton();
            convergeSimple = calculation.isConvergeForSimpleIteration();
            session.setAttribute("convergeNewton",convergeNewton);
            session.setAttribute("convergeSimple",convergeSimple);
            if (convergeNewton){
                session.setAttribute("resultNewton", calculation.newton());
                session.setAttribute("iterationNewton", calculation.getIterationNewton());
            }
            if (convergeSimple){
                session.setAttribute("resultSimple", calculation.simpleIteration());
                session.setAttribute("iterationSimple", calculation.getIterationSimple());
            }
            session.setAttribute("chart", calculation.getChartData());

        } catch (InvocationTargetException | IllegalAccessException e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double accuracy;
        double approximation1 = 0,approximation2 = 0;
        double[] result;
        double [][] chart;
        String function1, function2;
        NumericalMethodForSystem calculation;

        accuracy = Double.parseDouble(request.getParameter("Accuracy"));
        function1 = request.getParameter("Function1");
        function2 = request.getParameter("Function2");
        approximation1 = Double.parseDouble(request.getParameter("approximation1"));
        approximation2 = Double.parseDouble(request.getParameter("approximation2"));
        HttpSession session = request.getSession();

        calculation = new NumericalMethodForSystem(accuracy, function1, function2, approximation1, approximation2);
        try {
            chart = calculation.getChartData();
            result = calculation.simpleIteration();
            if(result != null){
               chart = calculation.getChartData();
            }
            session.setAttribute("chartSystem", chart);
            session.setAttribute("result", result);
            session.setAttribute("iteration", calculation.getIteration());

        }catch (Exception e){ e.printStackTrace(); }

        request.getRequestDispatcher("/System.jsp").forward(request, response);
    }
}
