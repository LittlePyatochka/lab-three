package myServlet;

import java.util.ArrayList;

public class ArrayResult {
    private ArrayList<Result> table;

    public ArrayResult(){
        table = new ArrayList<>();
    }

    public void addString(Result res){
        table.add(res);
    }

    public String toHtmlString(){
        StringBuilder stringBuilder = new StringBuilder();
        table.forEach(result -> stringBuilder.append(result.getParameter() + "\n"));
        return stringBuilder.toString();

    }
}
