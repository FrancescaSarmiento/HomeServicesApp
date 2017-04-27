package edu.slu.scis.webtek.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ImageServlet", urlPatterns = {"/images/*"})
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String imageid = request.getPathInfo().substring(1);
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            String connUrl = "jdbc:mysql://localhost:3306/webtek?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            String sql = "SELECT data FROM images WHERE imageid = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, imageid);
            
            ResultSet rs = ps.executeQuery();
            if (rs.first()) {
                byte[] imageData = rs.getBytes("data");
                
                response.setStatus(HttpServletResponse.SC_OK);
                response.setContentType("image/jpg");
                response.setContentLength(imageData.length);
                
                ServletOutputStream os = response.getOutputStream();
                os.write(imageData);
                os.flush();
                os.close();
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
            
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            Logger.getLogger(ImageServlet.class.getName()).log(Level.SEVERE, null, e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
