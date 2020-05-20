package myServlet;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import static java.lang.Double.*;

public class NumericalMethodForSystem {
    private double accuracy;
    private Method function1, function2, function1s, function2s;
    private double approximation1, approximation2;
    private int iteration;

    public NumericalMethodForSystem(double accuracy, String function1, String function2, double approximation1, double approximation2) {
        iteration = 0;
        this.accuracy = accuracy;
        this.approximation1 = approximation1;
        this.approximation2 = approximation2;
        try {
            this.function1 = SystemFunctions.class.getMethod(function1, Double.class);
            this.function1s = SystemFunctions.class.getMethod(function1, Double.class, Double.class);
            this.function2 = SystemFunctions.class.getMethod(function2, Double.class);
           // this.function2s = SystemFunctions.class.getMethod(function2, Double.class, Double.class, Boolean.class);
        } catch (Exception e) {
            //e.printStackTrace();
            System.out.println("чтоооооооооооооооооо");
        }
    }

    public double[] simpleIteration() throws InvocationTargetException, IllegalAccessException {
        final int MAX_ITERATION = 1000;
        double last1, last2;
        double max;
        double[] result = new double[2];
        do {
            iteration++;
            last1 = approximation1;
            last2 = approximation2;
            approximation1 = (Double) function1s.invoke(null, last1, last2);
            approximation2 = (Double) function2.invoke(null, last1);
            max = Math.max(Math.abs(approximation1 - last1), Math.abs(approximation2 - last2));
            if (iteration > MAX_ITERATION || !isFinite(last2) || !isFinite(last1)) {
                return null;
            }

        } while (max > accuracy);
        result[0] = approximation1;
        result[1] = approximation2;
        return result;
    }

    public double[][] getChartData() throws InvocationTargetException, IllegalAccessException {
        final int NUMBER_OF_DOTS = 500;
        final int RANGE = 2;
        double[][] arr = new double[3][NUMBER_OF_DOTS];
        double h = ((approximation1 + RANGE) - (approximation1 - RANGE)) / NUMBER_OF_DOTS;
        double x = approximation1 - RANGE;
        for (int i = 0; i < NUMBER_OF_DOTS; i++) {
            arr[0][i] = x;
            arr[1][i] = (Double) function1.invoke(null, x);
            arr[2][i] = (Double) function2.invoke(null, x);
            if(!isFinite(arr[1][i])){
                arr[1][i] = 0;
            }
            x += h;
//            try {
//                arr[1][i] = (Double) function1.invoke(null, x);
//                arr[1][i] = !isFinite(arr[1][i]) ? 0 : arr[1][i];
//            } catch (Exception e) {
//                arr[1][i] = 0;
//            }
//            try {
//                arr[2][i] = (Double) function2.invoke(null, x);
//                arr[2][i] = !isFinite(arr[2][i]) ? 0 : arr[2][i];
//            } catch (Exception e) {
//                arr[2][i] = 0;
//            }
        }
        return arr;
    }

    public int getIteration() {
        return iteration;
    }
}

class SystemFunctions {
//    public static Double square(Double x1, Double x2) {
//        return (Math.sqrt(x2 + 3));
//    } // x1^2 - x2 = 3
//    public static Double cube(Double x1, Double x2) { return (Math.cbrt(-x2-4)); } // x1^3 +x2 = -4
//    public static Double cos(Double x1, Double x2) { return ((Math.cos(x1))-5*x2-10); } // cos(x1) - 5*x2 = 10
//    public static Double sin(Double x1, Double x2) { return (Math.sin(x1)-x2/4); } // sin(x1) - x2/4 = 0

//    public static Double square(Double x1, Double x2, Boolean is_x1) {
////        return Math.sqrt((x1 * (x2 + 5) - 1) / 2);
//        if (is_x1) {
//            return (x2 - 0.5);
//        } else {
//            return (x1 + 0.5);
//        }
//    }
//
//    public static Double cube(Double x1, Double x2, Boolean is_x1) {
//        if (is_x1) {
//            return x2;// e^(y)
//        } else {
//            return (x1);//y = x^2
//
//        }
////        return x1 + 3*Math.log(x1);
//    }
//
//    public static Double cos(Double x1, Double x2, Boolean is_x1) {
//        if (is_x1) {
//            return Math.acos(0.5 - x2);
//        } else {
//            return (0.5 - Math.cos(x1));
//        }
//    }
//
//    public static Double sin(Double x1, Double x2, Boolean is_x1) {
//        if (is_x1) {
//            return Math.asin(x2);//x = asin(y)
//        } else {
//            return (Math.sin(x1));// y = sin(x)
//        }
//    }
//
//
//    public static Double square(Double x) {
//        return (x + 0.5);// y = x+0.5
//    }
//
//    public static Double cube(Double x) {
////        return x + 3*Math.log(x);
//
//        return (Math.log(x));// y = ln(x) + 2
//    }
//
//    public static Double cos(Double x) {
//        return (0.5 - Math.cos(x));// y = 0.5 - cos(x)
//    }
//
//    public static Double sin(Double x) {
////        return ((x + 2) / 6);
//        return (Math.sin(x));//y = sin(x)
//    }

//    public static Double square(Double x) {
//        return (Math.pow(x, 2) - 3);
//    }
//    public static Double cube(Double x) { return (-Math.pow(x, 3)-4); }
//    public static Double cos(Double x) {
//        return (-(Math.cos(x))/5+2);
//    }
//    public static Double sin(Double x) { return (Math.sin(x)*4); }


    public static double line(Double x1, Double x2){
        return x2 - 0.5;
    }
    public static double line(Double x){
        return x + 0.5;
    }
    public static double square(Double x){
        return (1-Math.pow(x,2))/3;
    }
    public static double cube(Double x1, Double x2){
        return 16 + Math.pow(x2,3);
    }
    public static double cube(Double x){
        return Math.cbrt(x-16);
    }
    public static  double cos(Double x){
        return 3 - Math.cos(x);
    }
//    public  static  double sin(Double x1, Double x2){
//        return (10 -Math.sin(x2)/5);
//    }
    public  static  double sin(Double x){
//        return Math.asin(10 - 5*x);
        return 5*Math.sin(x);
    }
}

