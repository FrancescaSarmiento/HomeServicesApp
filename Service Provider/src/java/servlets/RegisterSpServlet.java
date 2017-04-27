package servlets;

import java.io.IOException;
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

@WebServlet(name = "RegisterSpServlet", urlPatterns = {"/RegisterSpServlet"})
@MultipartConfig
public class RegisterSpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String firstName = request.getParameter("first");
        String lastName = request.getParameter("last");
        String userName = request.getParameter("user");
        String password = request.getParameter("pass");
        String email = request.getParameter("mail");
        String contact = request.getParameter("contact");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            String sql = "INSERT INTO `service_provider` (`spNumber`, `firstName`, `lastName`, `userName`, `password`, `email`, `contactNumber`, `availability`, `status`) VALUES (NULL, ?, ?, ?, ?, ?, ?, '1', '0')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, userName);
            ps.setString(4, password);
            ps.setString(5, email);
            ps.setString(6, contact);
            
            boolean success = true;
            try {
                ps.executeUpdate();

                /*ServletContext context = this.getServletContext();
                String imagePath = context.getRealPath("/productimages/") + id + ".jpg";
                image.write(imagePath);
                */
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
