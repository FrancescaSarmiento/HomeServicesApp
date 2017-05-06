/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Hiromi Uematsu
 */
@WebServlet(name = "SPUpdate", urlPatterns = {"/SPUpdate"})
@MultipartConfig
public class SPUpdate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contactNumber");
        String password = request.getParameter("password");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        
        try {
           Class.forName("com.mysql.jdbc.Driver");
           
           String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
           Connection conn = DriverManager.getConnection(connUrl);
           
           String sql = "INSERT INTO service_provider(firstName, lastName, email, contactNumber, password, daysAvailable, timeAvailable) VALUES (?, ?, ?, ?, ?, ?, ?)";
           
           PreparedStatement ps = conn.prepareStatement(sql);
           ps.setString(2, firstName);
           ps.setString(3, lastName);
           ps.setString(4, email);
           ps.setString(5, contactNumber);
           ps.setString(8, password);
           ps.setString(9, date);
           ps.setString(10, time);
           
           boolean succes = true;
           try {
               ps.executeUpdate();
           } catch (Exception e){
               Logger.getLogger(SPUpdate.class.getName()).log(Level.SEVERE, null, e);
               succes = false;
           }
           
           ps.close();
           conn.close();
           
           String redirectPage = succes ? "succes.html" : "fail.html";
           response.sendRedirect(redirectPage);
           
        } catch (Exception e) {
            System.err.println("Got an Exception!");
            System.err.println(e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
