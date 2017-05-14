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
public class AddService extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        PrintWriter out = response.getWriter();
        
        int book = Integer.parseInt(session.getAttribute("bookID").toString());
        int tranId = getTransactionId(book);
        String serv = request.getParameter("serv");
        BigDecimal hours = new BigDecimal(request.getParameter("hours"));

        int spId = getSpID(book);
        int servId = getServiceId(book);
        BigDecimal fixedRate = getFixedRate(spId, servId);
        
        BigDecimal amount = fixedRate.multiply(hours);
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {
            try{
                Class.forName("com.mysql.jdbc.Driver");

                String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
                Connection conn = DriverManager.getConnection(connUrl);

                String sql = "INSERT INTO paymentdetails (transactionId, serviceMade, amount)"
                        + " VALUES (?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, tranId);
                ps.setString(2, serv);
                ps.setBigDecimal(3, amount);
                ps.executeUpdate();


                ps.close();
                conn.close();

                RequestDispatcher rd = request.getRequestDispatcher("FinishTransaction.jsp");
                rd.include(request,response);
                out.print("Service Added Successfully.");
            } catch (SQLException | ClassNotFoundException ex) {
                Logger.getLogger(EditSchedule.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private int getTransactionId(int book) {
        int awesome = -1;
        try{
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);

            String sql = "SELECT transactionId FROM transaction WHERE bookingId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, book);
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

    private int getSpID(int book) {
        int awesome = -1;
        try{
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);

            String sql = "SELECT spId FROM booking WHERE bookingId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, book);
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

    private int getServiceId(int book) {
        int awesome = -1;
        try{
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);

            String sql = "SELECT serviceId FROM booking WHERE bookingId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, book);
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

    private BigDecimal getFixedRate(int spId, int servId) {
        BigDecimal awesome = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);

            String sql = "SELECT fixedRate FROM sp_service WHERE serviceId=? AND spId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, servId);
            ps.setInt(2, spId);
            ResultSet rs = ps.executeQuery();
             
            rs.first();
            
            awesome = rs.getBigDecimal(1);
            
            rs.close();
            ps.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(EditSchedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return awesome;
    }
}
