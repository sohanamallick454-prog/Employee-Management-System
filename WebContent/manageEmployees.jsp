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
    
    String username = (String) session.getAttribute("username");
    
    // Handle Delete Action - Process delete BEFORE displaying the table
    String deleteId = request.getParameter("deleteId");
    if(deleteId != null && !deleteId.isEmpty()) {
        try {
            int idToDelete = Integer.parseInt(deleteId);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
            
            // Get employee name first
            PreparedStatement getNamePs = con.prepareStatement("SELECT name FROM employees WHERE id = ?");
            getNamePs.setInt(1, idToDelete);
            ResultSet rs = getNamePs.executeQuery();
            String empName = "";
            if(rs.next()) {
                empName = rs.getString("name");
            }
            rs.close();
            getNamePs.close();
            
            // Delete the employee
            PreparedStatement ps = con.prepareStatement("DELETE FROM employees WHERE id = ?");
            ps.setInt(1, idToDelete);
            int deleted = ps.executeUpdate();
            ps.close();
            con.close();
            
            if(deleted > 0) {
                session.setAttribute("message", "Employee '" + empName + "' deleted successfully!");
            } else {
                session.setAttribute("error", "Employee not found!");
            }
        } catch(Exception e) {
            session.setAttribute("error", "Delete failed: " + e.getMessage());
        }
        response.sendRedirect("manageEmployees.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Employees</title>
    <style>
        body {
            font-family: 'Courier New', monospace;
            background: #8FBC8F;
            margin: 0;
            padding: 20px;
        }
        .header {
            background: #4a6b4a;
            color: white;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }
        .header a {
            float: right;
            color: white;
            margin-left: 15px;
        }
        .container {
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            padding: 20px;
            max-width: 1200px;
            margin: auto;
        }
        h2 { color: #4a6b4a; }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            border: 1px solid #8FBC8F;
            padding: 10px;
            text-align: left;
        }
        th {
            background: #4a6b4a;
            color: white;
        }
        .btn-add {
            background: #27ae60;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
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
        .message {
            background: #d5f4e6;
            color: #27ae60;
            padding: 10px;
            margin-bottom: 20px;
        }
        .error {
            background: #f0e0dd;
            color: #c0392b;
            padding: 10px;
            margin-bottom: 20px;
        }
    </style>
    <script>
        function confirmDelete(id, name) {
            if(confirm("Are you sure you want to delete employee: " + name + "?")) {
                window.location.href = "manageEmployees.jsp?deleteId=" + id;
            }
        }
    </script>
</head>
<body>

<div class="header">
    <h2>MANAGE EMPLOYEES</h2>
    Welcome, <%= username %>
    <a href="logout.jsp">LOGOUT</a>
    <a href="adminDashboard.jsp">BACK</a>
</div>

<div class="container">
    <h2>EMPLOYEE RECORDS</h2>
    
    <% if(session.getAttribute("message") != null) { %>
        <div class="message">✅ <%= session.getAttribute("message") %></div>
        <% session.removeAttribute("message"); %>
    <% } %>
    
    <% if(session.getAttribute("error") != null) { %>
        <div class="error">❌ <%= session.getAttribute("error") %></div>
        <% session.removeAttribute("error"); %>
    <% } %>
    
    <a href="addEmployee.jsp" class="btn-add">+ ADD EMPLOYEE</a>
    
    <table>
        <thead>
            <tr>
                <th>ID</th><th>Code</th><th>Name</th><th>Email</th><th>Dept</th><th>Position</th><th>Salary</th><th>Status</th><th>Actions</th>
            </tr>
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
                <td>$<%= String.format("%,.2f", rs.getDouble("salary")) %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <a href="updateEmployee.jsp?id=<%= rs.getInt("id") %>" class="btn-edit">Edit</a>
                    <a href="javascript:void(0);" onclick="confirmDelete(<%= rs.getInt("id") %>, '<%= rs.getString("name") %>')" class="btn-delete">Delete</a>
                </td>
            </tr>
            <%
                    }
                    con.close();
                } catch(Exception e) {
                    out.println("科学技术<td colspan='9' style='color:red'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>
</div>

</body>
</html>