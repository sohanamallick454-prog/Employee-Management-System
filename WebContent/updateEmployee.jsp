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
    
    String url = "jdbc:mysql://localhost:3306/ems_db";
    String user = "root";
    String password = "root123";
    
    int id = Integer.parseInt(request.getParameter("id"));
    String employeeCode = "", name = "", email = "", department = "", position = "", phone = "", address = "", hireDate = "", status = "";
    double salary = 0;
    
    // Handle Update
    if(request.getParameter("action") != null && request.getParameter("action").equals("update")) {
        employeeCode = request.getParameter("employeeCode");
        name = request.getParameter("name");
        email = request.getParameter("email");
        department = request.getParameter("department");
        position = request.getParameter("position");
        salary = Double.parseDouble(request.getParameter("salary"));
        phone = request.getParameter("phone");
        address = request.getParameter("address");
        hireDate = request.getParameter("hireDate");
        status = request.getParameter("status");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, password);
            String sql = "UPDATE employees SET employee_code=?, name=?, email=?, department=?, position=?, salary=?, phone=?, address=?, hire_date=?, status=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, employeeCode);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, department);
            ps.setString(5, position);
            ps.setDouble(6, salary);
            ps.setString(7, phone);
            ps.setString(8, address);
            ps.setString(9, hireDate);
            ps.setString(10, status);
            ps.setInt(11, id);
            ps.executeUpdate();
            con.close();
            session.setAttribute("message", "Employee updated successfully!");
            response.sendRedirect("manageEmployees.jsp");
            return;
        } catch(Exception e) {
            session.setAttribute("error", "Update failed: " + e.getMessage());
        }
    }
    
    // Fetch employee data
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, user, password);
        PreparedStatement ps = con.prepareStatement("SELECT * FROM employees WHERE id = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            employeeCode = rs.getString("employee_code");
            name = rs.getString("name");
            email = rs.getString("email");
            department = rs.getString("department");
            position = rs.getString("position");
            salary = rs.getDouble("salary");
            phone = rs.getString("phone");
            address = rs.getString("address");
            hireDate = rs.getString("hire_date");
            status = rs.getString("status");
        }
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Employee</title>
    <style>
        body {
            font-family: 'Courier New', monospace;
            background: #8FBC8F;
            margin: 0;
            padding: 0;
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
            max-width: 600px;
            margin: 30px auto;
            padding: 30px;
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            box-shadow: 8px 8px 0px #5a7c5a;
        }
        h2 { color: #4a6b4a; text-align: center; }
        .form-group { margin-bottom: 15px; }
        label {
            display: block;
            margin-bottom: 5px;
            color: #4a6b4a;
            font-weight: bold;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #8FBC8F;
            font-family: 'Courier New', monospace;
            box-sizing: border-box;
        }
        .btn-submit {
            background: #2196F3;
            color: white;
            padding: 12px;
            border: none;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        .btn-submit:hover {
            background: #0b7dda;
        }
        .btn-back {
            display: inline-block;
            background: #95a5a6;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-top: 15px;
        }
        .row { display: flex; gap: 15px; }
        .row .form-group { flex: 1; }
    </style>
</head>
<body>

<div class="header">
    <h2>✏️ UPDATE EMPLOYEE</h2>
    Welcome, <%= session.getAttribute("username") %>
    <a href="logout.jsp">LOGOUT</a>
    <a href="manageEmployees.jsp">BACK TO LIST</a>
</div>

<div class="container">
    <h2>EDIT EMPLOYEE DETAILS</h2>
    <form method="post" action="updateEmployee.jsp">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= id %>">
        
        <div class="row">
            <div class="form-group">
                <label>Employee Code</label>
                <input type="text" name="employeeCode" value="<%= employeeCode %>" required>
            </div>
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" value="<%= name %>" required>
            </div>
        </div>
        
        <div class="row">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="<%= email %>" required>
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="text" name="phone" value="<%= phone %>">
            </div>
        </div>
        
        <div class="row">
            <div class="form-group">
                <label>Department</label>
                <select name="department" required>
                    <option value="IT" <%= "IT".equals(department) ? "selected" : "" %>>IT</option>
                    <option value="HR" <%= "HR".equals(department) ? "selected" : "" %>>HR</option>
                    <option value="Finance" <%= "Finance".equals(department) ? "selected" : "" %>>Finance</option>
                    <option value="Marketing" <%= "Marketing".equals(department) ? "selected" : "" %>>Marketing</option>
                    <option value="Sales" <%= "Sales".equals(department) ? "selected" : "" %>>Sales</option>
                </select>
            </div>
            <div class="form-group">
                <label>Position</label>
                <input type="text" name="position" value="<%= position %>" required>
            </div>
        </div>
        
        <div class="row">
            <div class="form-group">
                <label>Salary</label>
                <input type="number" name="salary" step="0.01" value="<%= salary %>" required>
            </div>
            <div class="form-group">
                <label>Hire Date</label>
                <input type="date" name="hireDate" value="<%= hireDate %>" required>
            </div>
        </div>
        
        <div class="form-group">
            <label>Address</label>
            <textarea name="address" rows="3"><%= address %></textarea>
        </div>
        
        <div class="form-group">
            <label>Status</label>
            <select name="status">
                <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Active</option>
                <option value="inactive" <%= "inactive".equals(status) ? "selected" : "" %>>Inactive</option>
            </select>
        </div>
        
        <button type="submit" class="btn-submit">💾 UPDATE EMPLOYEE</button>
    </form>
    <div style="text-align: center; margin-top: 15px;">
        <a href="manageEmployees.jsp" class="btn-back">← BACK TO EMPLOYEE LIST</a>
    </div>
</div>
</body>
</html>