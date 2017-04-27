package edu.slu.scis.webtek.servlets;

import edu.slu.scis.webtek.beans.Product;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductListServlet", urlPatterns = {"/ProductListServlet"})
public class ProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Product> productList = new ArrayList<>();

        try {
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/webtek?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);

            String sql = "SELECT prodid, proddesc, price FROM products ORDER BY proddesc";
            Statement st = conn.createStatement();
            
            ResultSet rs = st.executeQuery(sql);

            if (rs.first()) {
                do {
                    Product product = new Product(
                            rs.getString("prodid"),
                            rs.getString("proddesc"),
                            rs.getBigDecimal("price"));

                    productList.add(product);
                } while (rs.next());
            }

            rs.close();
            st.close();
            conn.close();

            request.setAttribute("prodlist", productList);

            String outFormat = request.getParameter("format");
            
            String displayServlet = outFormat.equalsIgnoreCase("html")
                    ? "DisplayHTMLServlet"
                    : "DisplayTextServlet";
            
            RequestDispatcher rd = request.getRequestDispatcher(displayServlet);
            rd.forward(request, response);
            
        } catch (Exception e) {
            Logger.getLogger(ProductListServlet.class.getName()).log(Level.SEVERE, null, e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
