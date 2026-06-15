package com.ems.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteEmployeeServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
            
            PreparedStatement ps = con.prepareStatement("DELETE FROM employees WHERE id = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
            con.close();
            
            session.setAttribute("message", "Employee deleted successfully!");
            response.sendRedirect("employee-list");
            
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("employee-list");
        }
    }
}
