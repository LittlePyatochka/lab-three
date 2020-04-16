package myServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    private String X;
    private String Y;
    private String R;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Y = req.getParameter("Y");
        R = req.getParameter("R");
        X = req.getParameter("X");
        if((X!=null)&&(Y!=null)&&(R!=null)) {
            req.getRequestDispatcher("check").forward(req, resp);
        } else req.getRequestDispatcher("/index.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
