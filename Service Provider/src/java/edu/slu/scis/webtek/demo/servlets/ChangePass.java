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
public class ChangePass extends HttpServlet {
        @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int id = getUserId(session.getAttribute("user").toString());
        
        String old = request.getParameter("old_pass");
        String newPass = request.getParameter("new_pass");
        String newPassR = request.getParameter("new_passr");
        
        PrintWriter out = response.getWriter();
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {
            if(!isValidPass(old, id)){
                RequestDispatcher rd = request.getRequestDispatcher("Password.jsp");  
                rd.include(request,response);
                out.print("Please type in your current, correct password.");
            }else if(!(newPass.equalsIgnoreCase(newPassR))){
                RequestDispatcher rd = request.getRequestDispatcher("Password.jsp");  
                rd.include(request,response);
                out.print("There's a mismatch between the new passwords. Please try again.");
            }else{
                try{
                    Class.forName("com.mysql.jdbc.Driver");

                    String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
                    Connection conn = DriverManager.getConnection(connUrl);

                    String sql = "UPDATE user SET password=? WHERE idNum=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, newPass);
                    ps.setInt(2, id);
                    ps.executeUpdate();


                    ps.close();
                    conn.close();

                    RequestDispatcher rd = request.getRequestDispatcher("Password.jsp");
                    rd.include(request,response);
                    out.print("Password changed successfully.");
                } catch (SQLException | ClassNotFoundException ex) {
                    Logger.getLogger(EditSchedule.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
    
    private int getUserId(String userName) {
        int awesome = -1;
        try{
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);

            String sql = "SELECT idNum FROM user WHERE userName=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userName);
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

    private boolean isValidPass(String pass, int user) {
        boolean status = false;  
        try{  
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE idNum=? AND password=? AND userType='Service Provider' AND status='1'");
            ps.setInt(1,user);  
            ps.setString(2,pass);  

            ResultSet rs = ps.executeQuery();
             
            status = rs.next();
            
            rs.close();
            ps.close();
            conn.close();

        }catch(ClassNotFoundException | SQLException e){System.out.println(e);}  
            return status;
    }
}
