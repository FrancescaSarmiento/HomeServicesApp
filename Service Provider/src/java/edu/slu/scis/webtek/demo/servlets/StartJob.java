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
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class StartJob extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int book = Integer.parseInt(session.getAttribute("bookID").toString());
        
        PrintWriter out = response.getWriter();
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {
            if(!isTransactionStarted(book)){
                try {
                    java.util.Date dt = new java.util.Date();
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String currentTime = sdf.format(dt);
                    
                    Class.forName("com.mysql.jdbc.Driver");

                    String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
                    Connection conn = DriverManager.getConnection(connUrl);

                    String sql = "UPDATE booking SET bookingStatus='ongoing', dateStarted=? WHERE bookingId=?";

                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(2, book);
                    ps.setString(1, currentTime);
                    ps.executeUpdate();
                    
                    sql = "INSERT INTO transaction (transactionID, bookingID) VALUES (null, ?)";

                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, book);
                    ps.executeUpdate();


                    ps.close();
                    conn.close();

                    RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
                    rd.include(request,response);
                    out.print("Job Started! Get going!");       
                } catch (Exception e) {
                     System.err.println("Got an Exception!");
                     System.err.println(e.getMessage());
                }
            }else{
                RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
                rd.include(request,response);
                out.print("Job's already started. Get back to work!"); 
            }
            
        }
    }

    private boolean isTransactionStarted(int book) {
        boolean status = false;  
        try{  
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM booking WHERE bookingId=? AND bookingStatus='ongoing'");
            ps.setInt(1, book);  

            ResultSet rs = ps.executeQuery();
             
            status = rs.next();
            
            rs.close();
            ps.close();
            conn.close();

        }catch(ClassNotFoundException | SQLException e){System.out.println(e);}  
            return status;
    }
}
