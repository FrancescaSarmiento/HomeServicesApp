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
            
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE userName=? AND password=? AND userType='Service Provider'");
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
            
            PreparedStatement ps = conn.prepareStatement("SELECT idNum, userName, firstName, lastName, email, contactNumber, working_days, rating, availability "
                    + "FROM user INNER JOIN service_provider "
                    + "ON user.idNum = service_provider.spId WHERE userName=?");
            ps.setString(1,user);  

            ResultSet rs = ps.executeQuery();
            
            int id = Integer.parseInt(rs.getString("idNum"));
            String userName = rs.getString("userName");
            String first = rs.getString("firstName");
            String last = rs.getString("lastName");
            String email = rs.getString("email");
            String contact = rs.getString("contactNumber");
            String days = rs.getString("working_days");
            byte rating = Byte.parseByte(rs.getString("rating"));
            boolean avail = false;
            if(rs.getString("availability").equalsIgnoreCase("1"))
                avail = true;
            
            sp = new ServiceProvider(id,userName,first,last,email,contact,days,rating,avail);
            
            rs.close();
            ps.close();
            conn.close();

        }catch(ClassNotFoundException | SQLException e){
            System.out.println(e);
        }  
        
        return sp;
    }
}