package edu.slu.scis.webtek.demo.servlets;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Hiromi Uematsu
 */
@WebServlet(name = "AcceptServlet", urlPatterns = {"/AcceptServlet"})
public class AcceptServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        int book = Integer.parseInt(session.getAttribute("book").toString());
        
        PrintWriter out = response.getWriter();
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {
            try{
                java.util.Date dt = new java.util.Date();
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String currentTime = sdf.format(dt);
                    
                Class.forName("com.mysql.jdbc.Driver");

                String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
                Connection conn = DriverManager.getConnection(connUrl);

                String sql = "UPDATE booking SET bookingStatus='accepted', notifTimestamp=? WHERE bookingId=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, currentTime);
                ps.setInt(2, book);
                ps.executeUpdate();
                

                ps.close();
                conn.close();
                
                RequestDispatcher rd = request.getRequestDispatcher("Pending.jsp");
                rd.include(request,response);
                out.print("Request Accepted.");
            } catch (SQLException | ClassNotFoundException ex) {
                Logger.getLogger(EditSchedule.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
