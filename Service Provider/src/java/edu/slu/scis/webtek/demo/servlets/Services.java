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
public class Services extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        PrintWriter out = response.getWriter();
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {
            int spId = getUserId(session.getAttribute("user").toString());
            String st1 = "Assembly/Installation";
            String st2 = "Repair";
            String st3 = "Plumbing";
            String st4 = "Electrical";
            String st5 = "Painting";
            String st6 = "Carpentry";
            String st7 = "Remodeling";
            
            dropRelatedRecords(spId);
            
            if(!(request.getParameter(st1) == null) && request.getParameter(st1).equalsIgnoreCase("on")){
                insertService(spId, 1);
            }
            if(!(request.getParameter(st2) == null) && request.getParameter(st2).equalsIgnoreCase("on")){
                insertService(spId, 2);
            }
            if(!(request.getParameter(st3) == null) && request.getParameter(st3).equalsIgnoreCase("on")){
                insertService(spId, 3);
            }
            if(!(request.getParameter(st4) == null) && request.getParameter(st4).equalsIgnoreCase("on")){
                insertService(spId, 4);
            }
            if(!(request.getParameter(st5) == null) && request.getParameter(st5).equalsIgnoreCase("on")){
                insertService(spId, 5);
            }
            if(!(request.getParameter(st6) == null) && request.getParameter(st6).equalsIgnoreCase("on")){
                insertService(spId, 6);
            }
            if(!(request.getParameter(st7) == null) && request.getParameter(st7).equalsIgnoreCase("on")){
                insertService(spId, 7);
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("FixRates.jsp");
            rd.include(request,response);
        }
    }
    
    private void insertService(int spId, int serviceId) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            String sql = "INSERT INTO sp_service(serviceId, spId, fixedRate) VALUES (?, ?, 00.0)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, serviceId);
            ps.setInt(2, spId);
            
            ps.executeUpdate();
            
            ps.close();
            conn.close();
        } catch (Exception e) {
            System.out.print(e);
        }
    }

    private void dropRelatedRecords(int spId) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            String sql = "DELETE FROM sp_service WHERE spId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, spId);
            
            ps.executeUpdate();
            
            ps.close();
            conn.close();
        } catch (Exception e) {
            System.out.print(e);
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
}
