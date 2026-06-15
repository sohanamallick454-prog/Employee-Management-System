<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Courier New', monospace;
            background: #8FBC8F;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }
        .daisy-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
            background-image: 
                radial-gradient(circle at 10% 20%, #FFD700 4px, transparent 4px),
                radial-gradient(circle at 25% 35%, #FFFFFF 6px, transparent 6px),
                radial-gradient(circle at 40% 15%, #FFD700 3px, transparent 3px),
                radial-gradient(circle at 55% 45%, #FFFFFF 5px, transparent 5px),
                radial-gradient(circle at 70% 25%, #FFD700 4px, transparent 4px),
                radial-gradient(circle at 85% 55%, #FFFFFF 6px, transparent 6px),
                radial-gradient(circle at 95% 15%, #FFD700 3px, transparent 3px),
                radial-gradient(circle at 15% 65%, #FFFFFF 5px, transparent 5px),
                radial-gradient(circle at 35% 75%, #FFD700 4px, transparent 4px),
                radial-gradient(circle at 50% 85%, #FFFFFF 6px, transparent 6px),
                radial-gradient(circle at 65% 70%, #FFD700 3px, transparent 3px),
                radial-gradient(circle at 80% 90%, #FFFFFF 5px, transparent 5px),
                radial-gradient(circle at 90% 40%, #FFD700 4px, transparent 4px),
                radial-gradient(circle at 5% 85%, #FFFFFF 6px, transparent 6px),
                radial-gradient(circle at 45% 95%, #FFD700 5px, transparent 5px),
                radial-gradient(circle at 10% 20%, #228B22 2px, transparent 2px),
                radial-gradient(circle at 25% 35%, #228B22 3px, transparent 3px),
                radial-gradient(circle at 55% 45%, #228B22 2px, transparent 2px),
                radial-gradient(circle at 85% 55%, #228B22 3px, transparent 3px),
                radial-gradient(circle at 15% 65%, #228B22 2px, transparent 2px),
                radial-gradient(circle at 50% 85%, #228B22 3px, transparent 3px),
                radial-gradient(circle at 80% 90%, #228B22 2px, transparent 2px);
            background-repeat: no-repeat;
            background-position: 
                10% 20%, 25% 35%, 40% 15%, 55% 45%, 70% 25%, 85% 55%, 95% 15%,
                15% 65%, 35% 75%, 50% 85%, 65% 70%, 80% 90%, 90% 40%, 5% 85%, 45% 95%;
        }
        .header {
            background: #4a6b4a;
            color: white;
            padding: 20px 30px;
            position: relative;
            z-index: 2;
            border-bottom: 3px solid #2d4a2d;
        }
        .header h2 {
            font-family: 'Courier New', monospace;
            letter-spacing: 3px;
            font-size: 24px;
        }
        .logout {
            position: absolute;
            right: 30px;
            top: 50%;
            transform: translateY(-50%);
            color: white;
            text-decoration: none;
            background: #2d4a2d;
            padding: 8px 15px;
            border: 1px solid #8FBC8F;
            font-family: 'Courier New', monospace;
            transition: all 0.3s;
        }
        .logout:hover {
            background: #1a3a1a;
            transform: translateY(-50%) translateX(-2px);
        }
        .container {
            position: relative;
            z-index: 1;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
        }
        .welcome-card {
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            padding: 40px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 8px 8px 0px #5a7c5a;
            transition: all 0.3s;
        }
        .welcome-card:hover {
            transform: translate(-2px, -2px);
            box-shadow: 12px 12px 0px #5a7c5a;
        }
        .welcome-icon { font-size: 60px; margin-bottom: 20px; }
        .welcome-card h3 {
            color: #4a6b4a;
            font-size: 28px;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .username {
            color: #6B8E6B;
            font-size: 20px;
            margin-bottom: 20px;
            border-bottom: 2px dotted #8FBC8F;
            display: inline-block;
            padding-bottom: 5px;
        }
        .success-message {
            background: #d5f4e6;
            color: #27ae60;
            padding: 10px;
            margin-top: 20px;
            border-left: 4px solid #27ae60;
            font-weight: bold;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .info-card {
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            padding: 25px;
            text-align: center;
            transition: all 0.3s;
            box-shadow: 4px 4px 0px #5a7c5a;
        }
        .info-card:hover {
            transform: translate(-2px, -2px);
            box-shadow: 8px 8px 0px #5a7c5a;
        }
        .info-icon { font-size: 40px; margin-bottom: 15px; }
        .info-card h4 {
            color: #4a6b4a;
            font-size: 18px;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .info-card p {
            color: #5a7c5a;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .info-card a {
            display: inline-block;
            margin-top: 5px;
            color: #6B8E6B;
            text-decoration: none;
            border-bottom: 2px dotted #8FBC8F;
            font-weight: bold;
        }
        .info-card a:hover {
            color: #4a6b4a;
            border-bottom: 2px solid #4a6b4a;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            color: #2d4a2d;
            font-size: 12px;
            background: rgba(240, 247, 230, 0.8);
            border: 2px solid #4a6b4a;
        }
        @keyframes floatDaisy {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-8px) rotate(3deg); }
        }
        .floating {
            position: absolute;
            animation: floatDaisy 4s ease-in-out infinite;
            pointer-events: none;
            z-index: 0;
            font-size: 24px;
            font-weight: bold;
            color: #FFD700;
        }
        .corner-decoration {
            position: absolute;
            width: 30px;
            height: 30px;
            background: #4a6b4a;
            z-index: 2;
        }
        .corner-tl { top: 20px; left: 20px; clip-path: polygon(0 0, 100% 0, 0 100%); }
        .corner-tr { top: 20px; right: 20px; clip-path: polygon(100% 0, 100% 100%, 0 0); }
        .corner-bl { bottom: 20px; left: 20px; clip-path: polygon(0 100%, 100% 100%, 0 0); }
        .corner-br { bottom: 20px; right: 20px; clip-path: polygon(100% 100%, 0 100%, 100% 0); }
        .message {
            background: #d5f4e6;
            color: #27ae60;
            padding: 12px;
            margin-bottom: 20px;
            border-left: 4px solid #27ae60;
            font-weight: bold;
            text-align: center;
        }
        @media (max-width: 768px) {
            .container { margin: 20px auto; padding: 15px; }
            .welcome-card { padding: 25px; }
            .welcome-card h3 { font-size: 22px; }
            .info-grid { grid-template-columns: 1fr; }
            .header h2 { font-size: 18px; }
            .logout { position: static; display: inline-block; margin-top: 10px; transform: none; }
            .header { text-align: center; }
        }
    </style>
</head>
<body>

<div class="daisy-pattern"></div>
<div class="floating" style="top: 15%; left: 5%; font-size: 30px;">*</div>
<div class="floating" style="top: 25%; left: 88%; font-size: 40px; animation-delay: 1s;">*</div>
<div class="floating" style="top: 55%; left: 3%; font-size: 28px; animation-delay: 2s;">*</div>
<div class="floating" style="top: 70%; left: 90%; font-size: 35px; animation-delay: 0.5s;">*</div>
<div class="floating" style="top: 85%; left: 15%; font-size: 32px; animation-delay: 1.5s;">*</div>
<div class="floating" style="top: 10%; left: 45%; font-size: 22px; animation-delay: 3s;">*</div>
<div class="floating" style="top: 40%; left: 75%; font-size: 28px; animation-delay: 2.5s;">*</div>
<div class="floating" style="top: 80%; left: 55%; font-size: 26px; animation-delay: 1.8s;">*</div>
<div class="floating" style="top: 50%; left: 50%; font-size: 18px; animation-delay: 0.8s;">*</div>
<div class="floating" style="top: 20%; left: 70%; font-size: 30px; animation-delay: 3.5s;">*</div>
<div class="floating" style="top: 65%; left: 35%; font-size: 26px; animation-delay: 1.2s;">*</div>
<div class="floating" style="top: 92%; left: 80%; font-size: 34px; animation-delay: 2.2s;">*</div>

<div class="corner-decoration corner-tl"></div>
<div class="corner-decoration corner-tr"></div>
<div class="corner-decoration corner-bl"></div>
<div class="corner-decoration corner-br"></div>

<div class="header">
    <h2>ADMIN DASHBOARD</h2>
    <a href="logout.jsp" class="logout">LOGOUT</a>
</div>

<div class="container">
    <div class="welcome-card">
        <div class="welcome-icon">[ * ]</div>
        <h3>WELCOME</h3>
        <div class="username"><%= session.getAttribute("username") %></div>
        <div class="success-message">LOGIN SUCCESSFUL</div>
    </div>
    
    <% if(session.getAttribute("message") != null) { %>
        <div class="message">✅ <%= session.getAttribute("message") %></div>
        <% session.removeAttribute("message"); %>
    <% } %>
    
    <div class="info-grid">
        <div class="info-card">
            <div class="info-icon">[ + ]</div>
            <h4>ADD EMPLOYEE</h4>
            <p>Add new employee to the system</p>
            <a href="addEmployee.jsp">ADD NEW</a>
        </div>
        
        <div class="info-card">
            <div class="info-icon">[ 📋 ]</div>
            <h4>MANAGE EMPLOYEES</h4>
            <p>View, edit, update and delete employees</p>
            <a href="manageEmployees.jsp">VIEW ALL</a>
        </div>
        
        <div class="info-card">
            <div class="info-icon">[ 📊 ]</div>
            <h4>REPORTS</h4>
            <p>View employee reports and analytics</p>
            <a href="reports.jsp">VIEW REPORTS</a>
        </div>
        
        <div class="info-card">
            <div class="info-icon">[ ⚙️ ]</div>
            <h4>SETTINGS</h4>
            <p>System settings and preferences</p>
            <a href="settings.jsp">CONFIGURE</a>
        </div>
    </div>
    
    <div class="footer">
        EMPLOYEE MANAGEMENT SYSTEM | ADMIN PORTAL | SECURE ACCESS
    </div>
</div>

</body>
</html>