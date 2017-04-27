package edu.slu.scis.webtek.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HelloServlet", urlPatterns = {"/HelloServlet"})
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setStatus(HttpServletResponse.SC_OK);
        response.setHeader("Content-Type", "text/html");

        Date date = new Date();
        String browser = request.getHeader("User-Agent");

        PrintWriter out = response.getWriter();

        out.printf(
                "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "   <title>Servlet Demo: Hello, Servlet!</title>\n"
                + "</head>\n"
                + "<body>\n"
                + "   <h1>Hello, Servlet!</h1>\n"
                + "   <p>Today is %s.</p>\n"
                + "   <p>Your browser is %s.</p>\n"
                + "</body>\n"
                + "</html>",
                date.toString(), browser);

        out.flush();
        out.close();
    }
}
