package edu.slu.scis.webtek.demo.servlets;

import edu.slu.scis.webtek.demo.beans.ServiceProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SpLogin", urlPatterns = {"/SpLogin"})
public class SpLogin extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        
        String user = request.getParameter("name");
        String pass = request.getParameter("pass");

        if(!isValid(user, pass)){
            RequestDispatcher rd = request.getRequestDispatcher("SpLogin.jsp");  
            rd.include(request,response);
            out.print("Sorry, wrong username or password.");
        }else{
            ServiceProvider sp = buildSP(user);
            session.setAttribute("user", user);
            session.setAttribute("spInfo", sp);
            RequestDispatcher rd = request.getRequestDispatcher("SpLogin.jsp");  
            rd.include(request,response);
            String url = response.encodeRedirectURL("Profile.jsp");
            response.sendRedirect(url);
        }
    }

    private boolean isValid(String user, String pass) {
        boolean status = false;  
        try{  
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE userName=? AND password=? AND userType='Service Provider' AND status='1'");
            ps.setString(1,user);  
            ps.setString(2,pass);  

            ResultSet rs = ps.executeQuery();
             
            status = rs.next();
            
            rs.close();
            ps.close();
            conn.close();

        }catch(ClassNotFoundException | SQLException e){System.out.println(e);}  
            return status;
    }

    private ServiceProvider buildSP(String user) {
        ServiceProvider sp = null;
        try{  
            Class.forName("com.mysql.jdbc.Driver");

            String connUrl = "jdbc:mysql://localhost:3306/handyzebdb?user=root&password=";
            Connection conn = DriverManager.getConnection(connUrl);
            
            PreparedStatement ps = conn.prepareStatement("SELECT user.idNum, user.userName, service_provider.firstName, service_provider.lastName, service_provider.email, service_provider.contactNumber, service_provider.working_days, service_provider.rating, service_provider.availability FROM user INNER JOIN service_provider ON user.idNum = service_provider.spId WHERE userName=?");
            ps.setString(1,user);  

            ResultSet rs = ps.executeQuery();
            rs.first();
            
            int id = Integer.parseInt(rs.getString(1));
            String userName = rs.getString(2);
            String first = rs.getString(3);
            String last = rs.getString(4);
            String email = rs.getString(5);
            String contact = rs.getString(6);
            String days = rs.getString(7);
            byte rating = Byte.parseByte(rs.getString(8));
            boolean avail = false;
            if(rs.getString(9).equalsIgnoreCase("1"))
                avail = true;
           
            sp = new ServiceProvider(id, userName, first, last, email, contact, days, rating, avail);
            
            rs.close();
            ps.close();
            conn.close();

        }catch(ClassNotFoundException | SQLException e){
            System.out.println(e);
        }  
        return sp;
    }
}