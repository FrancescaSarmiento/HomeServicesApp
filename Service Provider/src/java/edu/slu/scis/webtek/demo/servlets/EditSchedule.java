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
public class EditSchedule extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        PrintWriter out = response.getWriter();
        String workingDays = "";
        
        int id = getUserId(session.getAttribute("user").toString());
        
        if (session == null || session.getAttribute("user") == null) {
            String url = response.encodeRedirectURL("NoSession.jsp");
            response.sendRedirect(url);
        } else {            
            if(!(request.getParameter("monday") == null) && request.getParameter("monday").equalsIgnoreCase("on"))
                workingDays += "Mon";
            if(!(request.getParameter("tuesday") == null) && request.getParameter("tuesday").equalsIgnoreCase("on"))
                workingDays += "Tue";
            if(!(request.getParameter("wednesday") == null) && request.getParameter("wednesday").equalsIgnoreCase("on"))
                workingDays += "Wed";
            if(!(request.getParameter("thursday") == null) && request.getParameter("thursday").equalsIgnoreCase("on"))
                workingDays += "Thu";
            if(!(request.getParameter("friday") == null) && request.getParameter("friday").equalsIgnoreCase("on"))
                workingDays += "Fri";
            if(!(request.getParameter("saturday") == null) && request.getParameter("saturday").equalsIgnoreCase("on"))
                workingDays += "Sat";
            if(!(request.getParameter("sunday") == null) && request.getParameter("sunday").equalsIgnoreCase("on"))
                workingDays += "Sun";
            
            try{
                Class.forName("com.mysql.jdbc.Driver");

                String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
                Connection conn = DriverManager.getConnection(connUrl);

                String sql = "UPDATE service_provider SET working_days=? WHERE spId=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, workingDays);
                ps.setInt(2, id);
                ps.executeUpdate();
                

                ps.close();
                conn.close();
                
                RequestDispatcher rd = request.getRequestDispatcher("Schedule.jsp");
                rd.include(request,response);
                out.print("Schedule Updated Successfully.");
            } catch (SQLException | ClassNotFoundException ex) {
                Logger.getLogger(EditSchedule.class.getName()).log(Level.SEVERE, null, ex);
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
}
