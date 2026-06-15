<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports</title>
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
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }
        .card {
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 8px 8px 0px #5a7c5a;
        }
        h2, h3 { color: #4a6b4a; margin-bottom: 15px; }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-box {
            background: #E8F0E0;
            padding: 20px;
            text-align: center;
            border-left: 4px solid #6B8E6B;
        }
        .stat-number {
            font-size: 36px;
            font-weight: bold;
            color: #4a6b4a;
        }
        .stat-label {
            font-size: 12px;
            color: #5a7c5a;
            margin-top: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            margin-top: 15px;
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
        .btn-back {
            display: inline-block;
            background: #6B8E6B;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-top: 20px;
        }
        .btn-print {
            background: #2196F3;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-right: 10px;
        }
        .dept-list {
            list-style: none;
            padding: 0;
        }
        .dept-list li {
            padding: 8px;
            border-bottom: 1px solid #8FBC8F;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>📊 REPORTS & ANALYTICS</h2>
    Welcome, <%= session.getAttribute("username") %>
    <a href="logout.jsp">LOGOUT</a>
    <a href="adminDashboard.jsp">BACK</a>
</div>

<div class="container">
    <!-- Summary Statistics -->
    <div class="card">
        <h3>📈 EMPLOYEE SUMMARY</h3>
        <div class="stats-grid">
            <%
                int totalEmployees = 0;
                int activeEmployees = 0;
                int inactiveEmployees = 0;
                double totalSalary = 0;
                double avgSalary = 0;
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
                    Statement stmt = con.createStatement();
                    
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total FROM employees");
                    if(rs.next()) totalEmployees = rs.getInt("total");
                    rs.close();
                    
                    rs = stmt.executeQuery("SELECT COUNT(*) as total FROM employees WHERE status = 'active'");
                    if(rs.next()) activeEmployees = rs.getInt("total");
                    rs.close();
                    
                    rs = stmt.executeQuery("SELECT COUNT(*) as total FROM employees WHERE status = 'inactive'");
                    if(rs.next()) inactiveEmployees = rs.getInt("total");
                    rs.close();
                    
                    rs = stmt.executeQuery("SELECT SUM(salary) as total FROM employees");
                    if(rs.next()) totalSalary = rs.getDouble("total");
                    rs.close();
                    
                    if(totalEmployees > 0) {
                        avgSalary = totalSalary / totalEmployees;
                    }
                    
                    con.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
            %>
            <div class="stat-box">
                <div class="stat-number"><%= totalEmployees %></div>
                <div class="stat-label">Total Employees</div>
            </div>
            <div class="stat-box">
                <div class="stat-number"><%= activeEmployees %></div>
                <div class="stat-label">Active Employees</div>
            </div>
            <div class="stat-box">
                <div class="stat-number"><%= inactiveEmployees %></div>
                <div class="stat-label">Inactive Employees</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">$<%= String.format("%,.0f", totalSalary) %></div>
                <div class="stat-label">Total Salary Budget</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">$<%= String.format("%,.0f", avgSalary) %></div>
                <div class="stat-label">Average Salary</div>
            </div>
        </div>
    </div>

    <!-- Department-wise Report -->
    <div class="card">
        <h3>🏢 DEPARTMENT WISE BREAKDOWN</h3>
        <table>
            <thead>
                <tr><th>Department</th><th>Employee Count</th><th>Total Salary</th><th>Average Salary</th></tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(
                            "SELECT department, COUNT(*) as count, SUM(salary) as total, AVG(salary) as avg " +
                            "FROM employees GROUP BY department ORDER BY count DESC"
                        );
                        while(rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("department") %></td>
                    <td><%= rs.getInt("count") %></td>
                    <td>$<%= String.format("%,.2f", rs.getDouble("total")) %></td>
                    <td>$<%= String.format("%,.2f", rs.getDouble("avg")) %></td>
                </tr>
                <%
                        }
                        con.close();
                    } catch(Exception e) {
                        out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Salary Range Distribution -->
    <div class="card">
        <h3>💰 SALARY DISTRIBUTION</h3>
        <table>
            <thead>
                <tr><th>Salary Range</th><th>Number of Employees</th></tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
                        Statement stmt = con.createStatement();
                        
                        String[] ranges = {"0-30000", "30001-50000", "50001-70000", "70001-90000", "90001+"};
                        String[] queries = {
                            "SELECT COUNT(*) FROM employees WHERE salary BETWEEN 0 AND 30000",
                            "SELECT COUNT(*) FROM employees WHERE salary BETWEEN 30001 AND 50000",
                            "SELECT COUNT(*) FROM employees WHERE salary BETWEEN 50001 AND 70000",
                            "SELECT COUNT(*) FROM employees WHERE salary BETWEEN 70001 AND 90000",
                            "SELECT COUNT(*) FROM employees WHERE salary > 90000"
                        };
                        
                        for(int i = 0; i < ranges.length; i++) {
                            ResultSet rs = stmt.executeQuery(queries[i]);
                            if(rs.next()) {
                %>
                <tr>
                    <td><%= ranges[i] %></td>
                    <td><%= rs.getInt(1) %></td>
                </tr>
                <%
                            }
                            rs.close();
                        }
                        con.close();
                    } catch(Exception e) {
                        out.println("<tr><td colspan='2'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <div style="text-align: center;">
        <button onclick="window.print()" class="btn-print">🖨️ PRINT REPORT</button>
        <a href="adminDashboard.jsp" class="btn-back">← BACK TO DASHBOARD</a>
    </div>
</div>

</body>
</html>