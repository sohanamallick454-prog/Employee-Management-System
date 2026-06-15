<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if(session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee List</title>
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
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
        }
        h2 { color: #4a6b4a; text-align: center; }
        .btn-add {
            display: inline-block;
            background: #6B8E6B;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #8FBC8F;
            text-align: left;
        }
        th {
            background: #4a6b4a;
            color: white;
        }
        .btn-edit {
            background: #2196F3;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
            margin-right: 5px;
        }
        .btn-delete {
            background: #f44336;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>EMPLOYEE MANAGEMENT</h2>
    Welcome, <%= session.getAttribute("username") %>
    <a href="logout.jsp">LOGOUT</a>
    <a href="adminDashboard.jsp">BACK</a>
</div>

<div class="container">
    <h2>EMPLOYEE LIST</h2>
    <a href="addEmployee.jsp" class="btn-add">+ ADD EMPLOYEE</a>
    
    <table>
        <thead>
            <tr><th>ID</th><th>Code</th><th>Name</th><th>Email</th><th>Dept</th><th>Position</th><th>Salary</th><th>Actions</th></tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM employees ORDER BY id");
                    
                    while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("employee_code") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("department") %></td>
                <td><%= rs.getString("position") %></td>
                <td>$<%= rs.getDouble("salary") %></td>
                <td>
                    <a href="updateEmployee.jsp?id=<%= rs.getInt("id") %>" class="btn-edit">Edit</a>
                    <a href="deleteEmployee.jsp?id=<%= rs.getInt("id") %>" class="btn-delete" onclick="return confirm('Delete this employee?')">Delete</a>
                </td>
            </tr>
            <%
                    }
                    con.close();
                } catch(Exception e) {
                    out.println("<tr><td colspan='8' style='color:red'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>