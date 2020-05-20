package myServlet;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class NumericalMethod {
    private final int MAX_ITERATION = 1000;
    private double a;
    private double b;
    private double accuracy;
    private Method function;
    private Method derivative;
    private int iterationNewton;
    private int iterationSimple;



    public NumericalMethod(double left, double right, double accuracy, String function, String derivative) {
        iterationNewton = 0;
        iterationSimple = 0;
        this.accuracy = accuracy;
        this.a = left;
        this.b = right;
        try {
            this.function = Functions.class.getMethod(function, Double.class);
            this.derivative = Functions.class.getMethod(derivative, Double.class);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("чтоооооооооооооооооо");
        }
    }

    public double[] newton() throws InvocationTargetException, IllegalAccessException {
        double [] result = new double[2];
        double x = 0;
        double last;
        try {
            x = b - (Double) function.invoke(null, b) / (Double) derivative.invoke(null, b);
            do {
                iterationNewton++;
                last = x;
                x = last - (Double) function.invoke(null, last) / (Double) derivative.invoke(null, last);
            } while (Math.abs(x - last) > accuracy || iterationNewton > MAX_ITERATION);
        } catch (Exception e) {
            System.out.println("3");
        }
        result[0] = x;
        result[1] = (Double) function.invoke(null, x);
        return result;
    }


    public double[] simpleIteration() throws InvocationTargetException, IllegalAccessException {
        double [] result = new double[2];
        double x;
        double last;
        double lambda = getLambda();
        x = lambda * (Double) function.invoke(null, a) + a;
        do {
            iterationSimple++;
            last = x;
            x = lambda * (Double) function.invoke(null, last) + last;
        } while (Math.abs(x - last) > accuracy || iterationSimple > MAX_ITERATION);

        result[0] = x;
        result[1] = (Double) function.invoke(null, x);
        return result;
    }

    public double[][] getChartData() throws InvocationTargetException, IllegalAccessException {
        double[][] arr = new double[2][500];
        double h = (b - a) / 500;
        double x = a;
        for (int i = 0; i < 500; i++) {
            arr[0][i] = x;
            arr[1][i] = (Double) function.invoke(null, x);
            x += h;

        }
        return arr;
    }

    private double getLambda() throws InvocationTargetException, IllegalAccessException {
        double temp;
        double currentX = a;
        double max = Double.MIN_VALUE;
        double h = (b - a) / 1000;

        while (currentX <= b) {
            temp = (Double) derivative.invoke(null, currentX);
            if (temp > max) {
                max = temp;
            }
            currentX += h;
        }
        return -1 / max;
    }

    public boolean isСonvergeForNewton() throws InvocationTargetException, IllegalAccessException {
        final double SMALL_NUMBER = 1e40;

        if ((Double) function.invoke(null, a) * (Double) function.invoke(null, b) >= 0) {
            return false;
        }
        double temp, last1, last2;
        last1 = (Double) derivative.invoke(null, a);
        last2 = ((Double) derivative.invoke(null, a) - (Double) derivative.invoke(null, a - SMALL_NUMBER)) / SMALL_NUMBER;
        double currentX = a;
        double h = (b - a) / 1000;
        while (currentX <= b) {
            temp = (Double) derivative.invoke(null, currentX);
            if (temp == 0 && temp * last1 < 0) {
                return false;
            }
            last1 = temp;
            temp = ((Double) derivative.invoke(null, currentX) - (Double) derivative.invoke(null, currentX - SMALL_NUMBER)) / SMALL_NUMBER;
            if (temp * last2 < 0) {
                return false;
            }
            last2 = temp;
            currentX += h;
        }
        return true;
    }

    public boolean isConvergeForSimpleIteration() throws InvocationTargetException, IllegalAccessException {
        double lambda = getLambda();
        double currentX = a;
        double h = (b - a) / 1000;
        double temp;
        while (currentX <= b) {
            temp = lambda*((Double) derivative.invoke(null,currentX));
            if (temp >= 1) {
                return false;
            }
            currentX += h;
        }
        return true;
    }

    public int getIterationNewton(){ return  iterationNewton;}
    public int getIterationSimple(){ return  iterationSimple; }

}

class Functions {
    public static Double square(Double x) {
        return (Math.pow(x, 2) - 3);
    }
    public static Double cube(Double x) {
        return (Math.pow(x, 3)-4);
    }
    public static Double cos(Double x) {
        return (Math.cos(x));
    }
    public static Double sin(Double x) {
        return (Math.sin(x));
    }

    public static Double derivative_square(Double x) {
        return (x * 2);
    }
    public static Double derivative_cube(Double x) {
        return (Math.pow(x, 2) * 3);
    }
    public static Double derivative_cos(Double x) {
        return (Math.sin(x) * -1);
    }
    public static Double derivative_sin(Double x) {
        return (Math.cos(x));
    }
}
