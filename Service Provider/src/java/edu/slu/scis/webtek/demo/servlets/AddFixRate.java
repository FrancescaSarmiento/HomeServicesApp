/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.slu.scis.webtek.demo.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
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
public class AddFixRate extends HttpServlet {
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
            
            if(!(request.getParameter(st1) == null)){
                BigDecimal amount = new BigDecimal(request.getParameter(st1));
                updateService(spId, 1, amount);
            }
            if(!(request.getParameter(st2) == null)){
                BigDecimal amount = new BigDecimal(request.getParameter(st2));
                updateService(spId, 2, amount);
            }
            if(!(request.getParameter(st3) == null)){
                BigDecimal amount = new BigDecimal(request.getParameter(st3));
                updateService(spId, 3, amount);
            }
            if(!(request.getParameter(st4) == null)){
                BigDecimal amount = new BigDecimal(request.getParameter(st4));
                updateService(spId, 4, amount);
            }
            if(!(request.getParameter(st5) == null)){
                BigDecimal amount = new BigDecimal(request.getParameter(st5));
                updateService(spId, 5, amount);
            }
            if(!(request.getParameter(st6) == null)){
                BigDecimal amount = new BigDecimal(request.getParameter(st6));
                updateService(spId, 6, amount);
            }
            if(!(request.getParameter(st7) == null)){
                BigDecimal amount = new BigDecimal(request.getParameter(st7));
                updateService(spId, 7, amount);
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("Services.jsp");
            rd.include(request,response);
            out.print("Services added to your arsenal successfully.");
        }
    }
    
    private void updateService(int spId, int serviceId , BigDecimal amount) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            String sql = "UPDATE sp_service SET fixedRate=? WHERE spid=? AND serviceId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setBigDecimal(1, amount);
            ps.setInt(2, spId);
            ps.setInt(3, serviceId);
            
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
