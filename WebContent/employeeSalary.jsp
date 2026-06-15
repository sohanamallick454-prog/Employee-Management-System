<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Salary</title>
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
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
        }
        .salary-card {
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            padding: 40px;
            box-shadow: 8px 8px 0px #5a7c5a;
            text-align: center;
        }
        .salary-card h2 {
            color: #4a6b4a;
            margin-bottom: 30px;
        }
        .employee-name {
            font-size: 24px;
            color: #4a6b4a;
            margin-bottom: 20px;
        }
        .annual-salary {
            background: #4a6b4a;
            color: white;
            padding: 30px;
            margin: 20px 0;
        }
        .annual-salary .label {
            font-size: 14px;
            letter-spacing: 2px;
        }
        .annual-salary .amount {
            font-size: 48px;
            font-weight: bold;
            margin-top: 10px;
        }
        .salary-breakdown {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 20px;
        }
        .breakdown-item {
            background: #E8F0E0;
            padding: 15px;
        }
        .breakdown-label {
            font-size: 12px;
            color: #5a7c5a;
        }
        .breakdown-value {
            font-size: 18px;
            color: #4a6b4a;
            font-weight: bold;
            margin-top: 5px;
        }
        .btn-back {
            display: inline-block;
            background: #6B8E6B;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>MY SALARY</h2>
    Welcome, <%= session.getAttribute("username") %>
    <a href="logout.jsp">LOGOUT</a>
    <a href="employeeDashboard.jsp">BACK</a>
</div>

<div class="container">
    <div class="salary-card">
        <h2>💰 SALARY DETAILS 💰</h2>
        <%
            Employee emp = (Employee) request.getAttribute("employee");
            if(emp != null && emp.getId() > 0) {
        %>
        <div class="employee-name"><%= emp.getName() %></div>
        <div class="employee-name" style="font-size: 14px;"><%= emp.getPosition() %>, <%= emp.getDepartment() %></div>
        
        <div class="annual-salary">
            <div class="label">ANNUAL SALARY</div>
            <div class="amount">$<%= String.format("%,.2f", emp.getSalary()) %></div>
        </div>
        
        <div class="salary-breakdown">
            <div class="breakdown-item">
                <div class="breakdown-label">MONTHLY SALARY</div>
                <div class="breakdown-value">$<%= String.format("%,.2f", emp.getSalary() / 12) %></div>
            </div>
            <div class="breakdown-item">
                <div class="breakdown-label">WEEKLY SALARY</div>
                <div class="breakdown-value">$<%= String.format("%,.2f", emp.getSalary() / 52) %></div>
            </div>
            <div class="breakdown-item">
                <div class="breakdown-label">DAILY SALARY</div>
                <div class="breakdown-value">$<%= String.format("%,.2f", emp.getSalary() / 260) %></div>
            </div>
            <div class="breakdown-item">
                <div class="breakdown-label">EMPLOYEE CODE</div>
                <div class="breakdown-value"><%= emp.getEmployeeCode() %></div>
            </div>
        </div>
        <% } else { %>
            <p>No salary data found. Please contact HR.</p>
        <% } %>
        <a href="employeeDashboard.jsp" class="btn-back">← BACK TO DASHBOARD</a>
    </div>
</div>
</body>
</html>