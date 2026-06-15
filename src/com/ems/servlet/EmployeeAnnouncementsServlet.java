package com.ems.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ems.model.Announcement;

public class EmployeeAnnouncementsServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<Announcement> announcements = new ArrayList<Announcement>();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
            
            String sql = "SELECT * FROM announcements WHERE status = 'active' ORDER BY posted_date DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                Announcement ann = new Announcement();
                ann.setId(rs.getInt("id"));
                ann.setTitle(rs.getString("title"));
                ann.setContent(rs.getString("content"));
                ann.setPostedDate(rs.getString("posted_date"));
                ann.setStatus(rs.getString("status"));
                announcements.add(ann);
            }
            
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        request.setAttribute("announcements", announcements);
        request.getRequestDispatcher("employeeAnnouncements.jsp").forward(request, response);
    }
}