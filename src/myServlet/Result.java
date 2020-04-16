package myServlet;

public class Result {
    private double x;
    private double y;
    private int r;
    private boolean result;
    private boolean isCorrect;

    public Result(double x, double y, int r, boolean result) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.result = result;
        isCorrect = true;
    }

    public Result() {
        isCorrect = false;
    }

    public void setIsCorrect(boolean isCor) {
        isCorrect = isCor;
    }

    public String getParameter() {
        if (isCorrect)
            return "<tr><td>" + x + "</td><td>" + y + "</td><td>" + r + "</td><td>" + result + "</td></tr>";
        else
            return "<tr><td colspan='6'>Неверные данные</td></tr>";
    }

    public boolean getIsCorrect() {
        return isCorrect;
    }
}
