package myServlet;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class NumericalMethod {
    private double left;
    private double right;
    private double accuracy;
    private Method function;
    private Method derivative;


    public NumericalMethod(double left, double right, double accuracy, String function, String derivative){
        this.accuracy = accuracy;
        this.left = left;
        this.right = right;
        try {
            this.function = Functions.class.getMethod(function, Double.class);
            this.derivative = Functions.class.getMethod(derivative, Double.class);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
    }

    public double newton() throws InvocationTargetException, IllegalAccessException {

        double last = 0;
        double x = (Double)function.invoke(null, right)/ (Double)derivative.invoke(null, right);

        while (Math.abs(x-last) <= accuracy){
            last = x;
            x = last - (Double) function.invoke(null, last)/ (Double) derivative.invoke(null, last);
        }
        return  x;
    }
    public double simpleIteration(){
        return  left;
    }

    public double[] dotsForGraph() throws InvocationTargetException, IllegalAccessException {
        double [] x = new double[100];
        double h = (right-left)/100;
        for (int i=0; i<100; i++){
            x[i] = (Double) function.invoke(null, h);
        }
        return x;
    }
}

class Functions {
    public static Double square(Double x) { return (Math.pow(x,2)-3); }
    public static Double cube(Double x) {
        return (Math.pow(x, 3)-4);
    }
    public static Double cos(Double x) {
        return (Math.cos(x));
    }
    public static Double ln(Double x) {
        return (Math.log(x));
    }
    public static Double sin(Double x) {
        return (Math.sin(x));
    }

    public static Double derivative_square(Double x) { return (x*2); }
    public static Double derivative_cube(Double x) { return (Math.pow(x,2)*3); }
    public static Double derivative_cos(Double x) { return (Math.sin(x)*-1); }
    public static Double derivative_ln(Double x) { return (1/x); }
    public static Double derivative_sin(Double x) { return (Math.cos(x)); }
}
