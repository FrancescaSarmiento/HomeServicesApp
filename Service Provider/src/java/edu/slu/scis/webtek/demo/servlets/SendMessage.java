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
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class SendMessage extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        PrintWriter out = response.getWriter();
        
        int id = getUserId(session.getAttribute("user").toString());
        int cuId = Integer.parseInt(request.getParameter("cuName"));
        String message = request.getParameter("message");
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {            
            if(isValidCustomer(cuId)){
                try{
                    java.util.Date dt = new java.util.Date();
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String currentTime = sdf.format(dt);
                    
                    Class.forName("com.mysql.jdbc.Driver");

                    String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
                    Connection conn = DriverManager.getConnection(connUrl);

                    String sql = "INSERT INTO message (messageId, senderId, receiverId, messageBody, timeSent, timeReceived, timeRead)"
                            + " VALUES (null, ?, ?, ?, ?, null, null)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, id);
                    ps.setInt(2, cuId);
                    ps.setString(3, message);
                    ps.setString(4, currentTime);
                    ps.executeUpdate();


                    ps.close();
                    conn.close();

                    RequestDispatcher rd = request.getRequestDispatcher("Outbox.jsp");
                    rd.include(request,response);
                    out.print("Message Sent Successfully.");
                } catch (SQLException | ClassNotFoundException ex) {
                    Logger.getLogger(EditSchedule.class.getName()).log(Level.SEVERE, null, ex);
                }
            }else{
                RequestDispatcher rd = request.getRequestDispatcher("CreateMessage.jsp");  
                rd.include(request,response);
                out.print("We couldn't find the userName you're trying to message. Please try again.");
            }
        }
    }

    private int getUserId(String user) {
        int awesome = -1;
        try{
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);

            String sql = "SELECT idNum FROM user WHERE userName=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();
             
            rs.first();
            
            awesome = rs.getInt(1);
            
            rs.close();
            ps.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(EditSchedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return awesome;
    }

    private boolean isValidCustomer(int id) {
        boolean status = false;  
        try{  
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE idNum=? AND userType='Customer' AND status='1'");
            ps.setInt(1, id);  

            ResultSet rs = ps.executeQuery();
             
            status = rs.next();
            
            rs.close();
            ps.close();
            conn.close();

        }catch(ClassNotFoundException | SQLException e){System.out.println(e);}  
            return status;
    }
}
