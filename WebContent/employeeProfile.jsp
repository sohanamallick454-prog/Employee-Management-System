<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
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
            margin-bottom: 30px;
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
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .profile-card {
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            padding: 30px;
            box-shadow: 8px 8px 0px #5a7c5a;
        }
        
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 3px dotted #8FBC8F;
            padding-bottom: 20px;
        }
        
        .profile-header h2 {
            color: #4a6b4a;
            font-size: 28px;
        }
        
        .avatar {
            font-size: 60px;
            margin-bottom: 10px;
        }
        
        .profile-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .detail-item {
            background: #E8F0E0;
            padding: 15px;
            border-left: 4px solid #6B8E6B;
        }
        
        .detail-label {
            font-size: 11px;
            color: #5a7c5a;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }
        
        .detail-value {
            font-size: 16px;
            color: #4a6b4a;
            font-weight: bold;
        }
        
        .salary-box {
            background: #4a6b4a;
            color: white;
            padding: 20px;
            text-align: center;
            border: 2px solid #2d4a2d;
            grid-column: span 2;
        }
        
        .salary-box .salary-label {
            font-size: 12px;
            letter-spacing: 2px;
        }
        
        .salary-box .salary-value {
            font-size: 32px;
            font-weight: bold;
            margin-top: 10px;
        }
        
        .status-active {
            color: green;
            font-weight: bold;
        }
        
        .status-inactive {
            color: red;
            font-weight: bold;
        }
        
        .btn-back {
            display: inline-block;
            background: #6B8E6B;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-top: 20px;
            border: 2px solid #4a6b4a;
            text-align: center;
        }
        
        .btn-back:hover {
            background: #4a6b4a;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #c0392b;
        }
        
        @keyframes floatDaisy {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-8px); }
        }
        
        .floating {
            position: absolute;
            animation: floatDaisy 4s ease-in-out infinite;
            pointer-events: none;
            font-size: 20px;
            color: #FFD700;
        }
        
        @media (max-width: 600px) {
            .profile-details {
                grid-template-columns: 1fr;
            }
            .salary-box {
                grid-column: span 1;
            }
            .header a {
                float: none;
                display: inline-block;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>

<div class="floating" style="top: 10%; left: 5%;">*</div>
<div class="floating" style="top: 20%; left: 90%; animation-delay: 1s;">*</div>
<div class="floating" style="top: 50%; left: 2%; animation-delay: 2s;">*</div>
<div class="floating" style="top: 70%; left: 95%; animation-delay: 0.5s;">*</div>

<div class="header">
    <h2>EMPLOYEE PROFILE</h2>
    Welcome, <%= session.getAttribute("username") %>
    <a href="logout.jsp">LOGOUT</a>
    <a href="employeeDashboard.jsp">BACK TO DASHBOARD</a>
</div>

<div class="container">
    <div class="profile-card">
        <%
            Employee emp = (Employee) request.getAttribute("employee");
            if(emp != null && emp.getId() > 0) {
        %>
        <div class="profile-header">
            <div class="avatar">👤</div>
            <h2><%= emp.getName() %></h2>
            <p class="<%= "active".equals(emp.getStatus()) ? "status-active" : "status-inactive" %>">
                <%= emp.getStatus() != null ? emp.getStatus().toUpperCase() : "ACTIVE" %>
            </p>
        </div>
        
        <div class="profile-details">
            <div class="detail-item">
                <div class="detail-label">EMPLOYEE CODE</div>
                <div class="detail-value"><%= emp.getEmployeeCode() %></div>
            </div>
            <div class="detail-item">
                <div class="detail-label">EMAIL</div>
                <div class="detail-value"><%= emp.getEmail() %></div>
            </div>
            <div class="detail-item">
                <div class="detail-label">DEPARTMENT</div>
                <div class="detail-value"><%= emp.getDepartment() %></div>
            </div>
            <div class="detail-item">
                <div class="detail-label">POSITION</div>
                <div class="detail-value"><%= emp.getPosition() %></div>
            </div>
            <div class="detail-item">
                <div class="detail-label">PHONE</div>
                <div class="detail-value"><%= emp.getPhone() != null ? emp.getPhone() : "Not provided" %></div>
            </div>
            <div class="detail-item">
                <div class="detail-label">HIRE DATE</div>
                <div class="detail-value"><%= emp.getHireDate() %></div>
            </div>
            <div class="detail-item">
                <div class="detail-label">EMPLOYEE ID</div>
                <div class="detail-value"><%= emp.getId() %></div>
            </div>
            <div class="detail-item">
                <div class="detail-label">STATUS</div>
                <div class="detail-value"><%= emp.getStatus() %></div>
            </div>
            
            <!-- Salary Section - Highlighted -->
            <div class="salary-box">
                <div class="salary-label">💰 ANNUAL SALARY 💰</div>
                <div class="salary-value">$<%= String.format("%,.2f", emp.getSalary()) %></div>
                <div class="salary-label" style="margin-top: 10px; font-size: 10px;">Monthly: $<%= String.format("%,.2f", emp.getSalary() / 12) %></div>
            </div>
            
            <div class="detail-item" style="grid-column: span 2;">
                <div class="detail-label">ADDRESS</div>
                <div class="detail-value"><%= emp.getAddress() != null ? emp.getAddress() : "Not provided" %></div>
            </div>
        </div>
        
        <% } else { %>
        <div class="no-data">
            <p>⚠️ No profile data found.</p>
            <p>Please contact HR to complete your profile.</p>
            <p style="margin-top: 15px; font-size: 12px;">Make sure your user account is linked to an employee record.</p>
        </div>
        <% } %>
        
        <div style="text-align: center;">
            <a href="employeeDashboard.jsp" class="btn-back">← BACK TO DASHBOARD</a>
        </div>
    </div>
</div>

</body>
</html>