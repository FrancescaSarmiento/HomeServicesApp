package edu.slu.scis.webtek.demo.servlets;

import edu.slu.scis.webtek.demo.beans.Cart;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "RemoveFromCart", urlPatterns = {"/RemoveFromCart"})
public class RemoveFromCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {
            int index = Integer.parseInt(request.getParameter("index"));
            
            Cart cart = (Cart) session.getAttribute("cart");
            cart.removeProduct(index);
            
            String url = response.encodeRedirectURL("Shop.jsp");
            response.sendRedirect(url);
        }
    }
}
