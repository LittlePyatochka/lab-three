package myServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    private String left;
    private String right;
    private String accuracy;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        left = req.getParameter("LeftLimit");
        accuracy = req.getParameter("Accuracy");
        right = req.getParameter("RightLimit");

        if((left!=null)&&(right!=null)&&(accuracy!=null)) {
            req.getRequestDispatcher("check").forward(req, resp);
        } else req.getRequestDispatcher("/index.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
