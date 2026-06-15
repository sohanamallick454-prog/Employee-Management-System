<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if(session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")) {
        response.sendRedirect("employeeDashboard.jsp");
        return;
    }
    
    // Handle password change
    String message = "";
    String error = "";
    
    if(request.getMethod().equals("POST") && request.getParameter("action") != null) {
        String action = request.getParameter("action");
        
        if(action.equals("change_password")) {
            String oldPassword = request.getParameter("old_password");
            String newPassword = request.getParameter("new_password");
            String confirmPassword = request.getParameter("confirm_password");
            String username = (String) session.getAttribute("username");
            
            if(!newPassword.equals(confirmPassword)) {
                error = "New passwords do not match!";
            } else if(newPassword.length() < 4) {
                error = "Password must be at least 4 characters!";
            } else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
                    ps.setString(1, username);
                    ps.setString(2, oldPassword);
                    ResultSet rs = ps.executeQuery();
                    
                    if(rs.next()) {
                        ps = con.prepareStatement("UPDATE users SET password = ? WHERE username = ?");
                        ps.setString(1, newPassword);
                        ps.setString(2, username);
                        ps.executeUpdate();
                        message = "Password changed successfully!";
                    } else {
                        error = "Old password is incorrect!";
                    }
                    con.close();
                } catch(Exception e) {
                    error = "Database error: " + e.getMessage();
                }
            }
        }
        
        if(action.equals("backup")) {
            message = "Database backup feature coming soon!";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Settings</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Courier New', monospace;
            background: #8FBC8F;
            min-height: 100vh;
        }
        .header {
            background: #4a6b4a;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .header a {
            float: right;
            color: white;
            text-decoration: none;
            background: #2d4a2d;
            padding: 8px 15px;
            margin-left: 10px;
        }
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
        }
        .card {
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 8px 8px 0px #5a7c5a;
        }
        h2, h3 { color: #4a6b4a; margin-bottom: 20px; }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #4a6b4a;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 2px solid #8FBC8F;
            font-family: 'Courier New', monospace;
            background: white;
        }
        .btn-save {
            background: #6B8E6B;
            color: white;
            padding: 12px 20px;
            border: none;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        .btn-save:hover {
            background: #4a6b4a;
        }
        .btn-back {
            display: inline-block;
            background: #95a5a6;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-top: 15px;
        }
        .message {
            background: #d5f4e6;
            color: #27ae60;
            padding: 10px;
            margin-bottom: 15px;
            border-left: 4px solid #27ae60;
        }
        .error {
            background: #f0e0dd;
            color: #c0392b;
            padding: 10px;
            margin-bottom: 15px;
            border-left: 4px solid #c0392b;
        }
        .info-text {
            font-size: 12px;
            color: #5a7c5a;
            margin-top: 5px;
        }
        hr {
            margin: 20px 0;
            border: 1px dotted #8FBC8F;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>⚙️ SYSTEM SETTINGS</h2>
    Welcome, <%= session.getAttribute("username") %>
    <a href="logout.jsp">LOGOUT</a>
    <a href="adminDashboard.jsp">BACK</a>
</div>

<div class="container">
    <% if(message != null && !message.isEmpty()) { %>
        <div class="message">✅ <%= message %></div>
    <% } %>
    <% if(error != null && !error.isEmpty()) { %>
        <div class="error">❌ <%= error %></div>
    <% } %>
    
    <!-- Change Password -->
    <div class="card">
        <h3>🔐 CHANGE PASSWORD</h3>
        <form method="post" action="settings.jsp">
            <input type="hidden" name="action" value="change_password">
            <div class="form-group">
                <label>Current Password</label>
                <input type="password" name="old_password" required>
            </div>
            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="new_password" required>
                <div class="info-text">Password must be at least 4 characters</div>
            </div>
            <div class="form-group">
                <label>Confirm New Password</label>
                <input type="password" name="confirm_password" required>
            </div>
            <button type="submit" class="btn-save">UPDATE PASSWORD</button>
        </form>
    </div>
    
    <!-- Database Backup -->
    <div class="card">
        <h3>💾 DATABASE BACKUP</h3>
        <form method="post" action="settings.jsp">
            <input type="hidden" name="action" value="backup">
            <p style="margin-bottom: 15px; color: #5a7c5a;">Download a backup of all employee records.</p>
            <button type="submit" class="btn-save">CREATE BACKUP</button>
        </form>
    </div>
    
    <!-- System Info -->
    <div class="card">
        <h3>ℹ️ SYSTEM INFORMATION</h3>
        <div class="info-text" style="margin-bottom: 10px;">
            <strong>Version:</strong> 2.0<br>
            <strong>Server:</strong> Apache Tomcat 9.0<br>
            <strong>Database:</strong> MySQL<br>
            <strong>Last Login:</strong> <%= new java.util.Date() %><br>
        </div>
    </div>
    
    <div style="text-align: center;">
        <a href="adminDashboard.jsp" class="btn-back">← BACK TO DASHBOARD</a>
    </div>
</div>

</body>
</html>