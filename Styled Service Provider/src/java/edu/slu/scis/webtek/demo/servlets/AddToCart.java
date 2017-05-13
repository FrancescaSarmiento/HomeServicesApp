package edu.slu.scis.webtek.demo.servlets;

import edu.slu.scis.webtek.demo.beans.Cart;
import edu.slu.scis.webtek.demo.beans.Product;
import java.io.IOException;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {
            String prodId = request.getParameter("prodid");
            
            HashMap<String, Product> productList = (HashMap<String, Product>) this.getServletContext().getAttribute("productList");
            
            Cart cart = (Cart) session.getAttribute("cart");
            cart.addProduct(productList.get(prodId));
            
            String url = response.encodeRedirectURL("Shop.jsp");
            response.sendRedirect(url);
        }
    }
}
