<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Check if user is logged in
    if(session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Check if user is admin
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")) {
        response.sendRedirect("employeeDashboard.jsp");
        return;
    }
    
    // Get employee ID to delete
    String idParam = request.getParameter("id");
    if(idParam == null || idParam.isEmpty()) {
        session.setAttribute("error", "No employee ID specified");
        response.sendRedirect("manageEmployees.jsp");
        return;
    }
    
    int id = Integer.parseInt(idParam);
    String message = "";
    String employeeName = "";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
        
        // Get employee name before deleting (for message)
        PreparedStatement getNamePs = con.prepareStatement("SELECT name FROM employees WHERE id = ?");
        getNamePs.setInt(1, id);
        ResultSet rs = getNamePs.executeQuery();
        if(rs.next()) {
            employeeName = rs.getString("name");
        }
        rs.close();
        getNamePs.close();
        
        // Delete the employee
        PreparedStatement ps = con.prepareStatement("DELETE FROM employees WHERE id = ?");
        ps.setInt(1, id);
        int rowsDeleted = ps.executeUpdate();
        
        if(rowsDeleted > 0) {
            session.setAttribute("message", "Employee '" + employeeName + "' deleted successfully!");
        } else {
            session.setAttribute("error", "Employee not found!");
        }
        
        ps.close();
        con.close();
        
    } catch(Exception e) {
        e.printStackTrace();
        session.setAttribute("error", "Delete failed: " + e.getMessage());
    }
    
    // Redirect back to manage employees page
    response.sendRedirect("manageEmployees.jsp");
%>