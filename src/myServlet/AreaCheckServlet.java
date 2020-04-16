package myServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AreaCheckServlet extends HttpServlet {
    private String submit;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        double accuracy;
        double leftLimit;
        double rightLimit;

        accuracy = Double.parseDouble(req.getParameter("Accuracy"));
        leftLimit = Double.parseDouble(req.getParameter("LeftLimit"));
        rightLimit = Double.parseDouble(req.getParameter("RightLimit"));







        double x;
        double y;
        int r;
        HttpSession session = req.getSession();
        ArrayResult table = (ArrayResult) session.getAttribute("result");
        if (table == null || req.getParameter("clear") != null) {
            table = new ArrayResult();
        }
        Result result;

        submit = req.getParameter("submit");

        try {
            y = Double.parseDouble(req.getParameter("Y"));
            r = Integer.parseInt(req.getParameter("R"));
            x = Double.parseDouble(req.getParameter("X"));
            System.out.println("check = " + check(x, y, r));
            result = new Result(x, y, r, check(x, y, (double) r));

            if (submit != null && !checkData((int) x, y, r)) {
                result.setIsCorrect(false);
            }
        } catch (NumberFormatException e) {
            result = new Result();
        }

        table.addString(result);
        session.setAttribute("result", table);

        if (submit != null) {
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } else {
            resp.getWriter().write(table.toHtmlString());
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    private boolean checkData(int x, double y, int r) {
        return ((x == -5 || x == -4 || x == -3 || x == -2 || x == -1 || x == 0 || x == 1 || x == 2 || x == 3) &&
                (y >= -3 && y <= 3) && (r == 1 || r == 2 || r == 3 || r == 4 || r == 5));
    }

    private boolean check(double x, double y, double r) {
        System.out.println(x + " " + y + " " + r);
        return (((x <= 0) && (x >= -r / 2) && (y >= 0) && (y <= (x + r / 2))) ||
                ((x >= 0) && (x <= r / 2) && (y >= 0) && (y <= r)) ||
                ((x >= 0) && (x <= r / 2) && (y <= 0) && ((x * x + y * y) <= r * r / 4)));
    }
}

