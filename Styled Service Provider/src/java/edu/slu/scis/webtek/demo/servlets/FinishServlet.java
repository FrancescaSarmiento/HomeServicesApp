/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.slu.scis.webtek.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author Hiromi Uematsu
 */
@WebServlet(name = "FinishServlet", urlPatterns = {"/FinishServlet"})
public class FinishServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());

        
        try {
           Class.forName("com.mysql.jdbc.Driver");
           
           String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
           Connection conn = DriverManager.getConnection(connUrl);
           
           String sql = "update booking set bookingStatus = ?, dateFinished = ? WHERE bookingId = ?";
           
           PreparedStatement ps = conn.prepareStatement(sql);
           ps.setString(1, "done");
           ps.setTimestamp(2, timestamp);
           ps.setInt(3, bookingId);
           
           boolean success = true;
           try {
               ps.executeUpdate();
           } catch (Exception e){
               Logger.getLogger(FinishServlet.class.getName()).log(Level.SEVERE, null, e);
               success = false;
           }
           
           ps.close();
           
           String sql2 = "INSERT into transaction (bookingId, timestamp, spStatus, custStatus) VALUES (?, ?, ?, ?)";
           
           PreparedStatement ps2 = conn.prepareStatement(sql2);
           ps2.setInt(1, bookingId);
           ps2.setTimestamp(2, timestamp);
           ps2.setString(3, "pending");
           ps2.setString(4, "pending");
           
           
           try {
               ps2.executeUpdate();
           } catch (Exception e){
               Logger.getLogger(FinishServlet.class.getName()).log(Level.SEVERE, null, e);
               success = false;
           }
           
           ps2.close();
           
           conn.close();
           
           String redirectPage = success ? "ongoingBooking.jsp" : "fail.html";
           response.sendRedirect(redirectPage);           
        } catch (Exception e) {
            System.err.println("Got an Exception!");
            System.err.println(e.getMessage());
        }
    }


}