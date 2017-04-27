package edu.slu.scis.webtek.servlets;

import edu.slu.scis.webtek.beans.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DisplayTextServlet", urlPatterns = {"/DisplayTextServlet"})
public class DisplayTextServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("prodlist");

        out.println("Product List:\n");
        
        for (Product product : productList) {
            out.printf("Product ID: %s\n", product.getId());
            out.printf("Description: %s\n", product.getDesc());
            out.printf("Price: %.2f\n\n", product.getPrice());
        }
    }
}
