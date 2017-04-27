package edu.slu.scis.webtek.servlets;

import edu.slu.scis.webtek.beans.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DisplayHTMLServlet", urlPatterns = {"/DisplayHTMLServlet"})
public class DisplayHTMLServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("prodlist");

        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/fragments/header.html");
        rd.include(request, response);

        out.println("<h1>Product List</h1>");
        out.println("<table><thead><tr><th>Product ID</th><th>Product Description</th><th>Price</th><th>Image</th></tr></thead>");
        out.println("<tbody>");

        for (Product product : productList) {
            out.printf("<tr><td>%s</td><td>%s</td><td>%.2f</td><td><img src='productimages/%s.jpg' alt='%s'></td></tr>",
                    product.getId(),
                    product.getDesc(),
                    product.getPrice(),
                    product.getId(),
                    product.getDesc());
        }
        
        out.println("</tbody></table>");

        request.getRequestDispatcher("WEB-INF/fragments/footer.html").include(request, response);
    }
}
