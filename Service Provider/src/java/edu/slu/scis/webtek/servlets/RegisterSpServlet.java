package edu.slu.scis.webtek.servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "RegisterSpServlet", urlPatterns = {"/RegisterSpServlet"})
@MultipartConfig
public class RegisterSpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String desc = request.getParameter("desc");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        Part image = request.getPart("image");
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            String sql = "INSERT INTO products(prodid, proddesc, price) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, desc);
            ps.setBigDecimal(3, price);
            
            boolean success = true;
            try {
                ps.executeUpdate();

                ServletContext context = this.getServletContext();
                String imagePath = context.getRealPath("/productimages/") + id + ".jpg";
                image.write(imagePath);
            } catch (Exception e) {
                Logger.getLogger(RegisterSpServlet.class.getName()).log(Level.SEVERE, null, e);
                success = false;
            }
            
            ps.close();
            conn.close();
            
            String redirectPage = success ? "success.html" : "fail.html";
            response.sendRedirect(redirectPage);
        } catch (Exception e) {
            Logger.getLogger(RegisterSpServlet.class.getName()).log(Level.SEVERE, null, e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
