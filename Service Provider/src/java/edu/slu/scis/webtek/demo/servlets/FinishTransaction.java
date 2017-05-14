/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.slu.scis.webtek.demo.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jerome
 */
public class FinishTransaction extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int book = Integer.parseInt(session.getAttribute("bookID").toString());
        
        PrintWriter out = response.getWriter();
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {
            try {
                java.util.Date dt = new java.util.Date();
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String currentTime = sdf.format(dt);
                    
                Class.forName("com.mysql.jdbc.Driver");

                String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
                Connection conn = DriverManager.getConnection(connUrl);

                String sql = "UPDATE transaction SET spStatus='approved', timestamp=?  WHERE bookingId=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1,currentTime);
                ps.setInt(2, book);
                ps.executeUpdate();

                sql = "UPDATE booking SET bookingStatus='done', dateFinished=? WHERE bookingId=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1,currentTime);
                ps.setInt(2, book);
                ps.executeUpdate();


                ps.close();
                conn.close();

                RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
                rd.include(request,response);
                out.print("Job Done! Nice.");       
            } catch (Exception e) {
                 System.err.println("Got an Exception!");
                 System.err.println(e.getMessage());
            }
        }
    }
}
