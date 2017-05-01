package edu.slu.scis.webtek.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ParamsServlet", urlPatterns = {"/ParamsServlet"})
public class ParamsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("nagan");
        String color = request.getParameter("kulay");

        try (PrintWriter out = response.getWriter()) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.setContentType("text/html");

            out.printf(
                    "<!DOCTYPE html>\n<html>\n<head>\n"
                    + "    <title>Servlet Demo: Handling Request Parameters (GET)</title>\n"
                    + "    <style>\n        h1 { color: %s; }\n    </style>\n"
                    + "</head>\n<body>\n"
                    + "    <h1>Hello, %s!</h1>\n"
                    + "</body>\n</html>\n",
                    color, name);
        }
    }
}
