<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Support</title>
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
            margin: 40px auto;
            padding: 20px;
        }
        .support-card {
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            padding: 30px;
            box-shadow: 8px 8px 0px #5a7c5a;
        }
        .support-card h2 {
            color: #4a6b4a;
            margin-bottom: 20px;
            text-align: center;
        }
        .contact-item {
            background: #E8F0E0;
            padding: 20px;
            margin-bottom: 15px;
            border-left: 4px solid #6B8E6B;
        }
        .contact-title {
            font-size: 18px;
            font-weight: bold;
            color: #4a6b4a;
        }
        .contact-detail {
            font-size: 14px;
            color: #4a6b4a;
            margin-top: 8px;
        }
        .contact-detail a {
            color: #6B8E6B;
            text-decoration: none;
        }
        .no-notification {
            text-align: center;
            padding: 40px 20px;
            background: #E8F0E0;
            border: 2px dashed #8FBC8F;
            margin-top: 20px;
        }
        .no-notification-icon {
            font-size: 48px;
            margin-bottom: 15px;
            color: #5a7c5a;
        }
        .no-notification-title {
            font-size: 18px;
            color: #4a6b4a;
            margin-bottom: 8px;
        }
        .no-notification-message {
            color: #5a7c5a;
            font-size: 13px;
        }
        .btn-back {
            display: inline-block;
            background: #6B8E6B;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-top: 20px;
        }
        .btn-back:hover {
            background: #4a6b4a;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>🆘 SUPPORT</h2>
    Welcome, <%= session.getAttribute("username") %>
    <a href="logout.jsp">LOGOUT</a>
    <a href="employeeDashboard.jsp">BACK</a>
</div>

<div class="container">
    <div class="support-card">
        <h2>HOW CAN WE HELP YOU?</h2>
        
        <div class="contact-item">
            <div class="contact-title">📞 HR HELPLINE</div>
            <div class="contact-detail">Call: +1 (800) 555-0123</div>
            <div class="contact-detail">Hours: Monday-Friday, 9 AM - 6 PM</div>
        </div>
        
        <div class="contact-item">
            <div class="contact-title">✉️ EMAIL SUPPORT</div>
            <div class="contact-detail">Email: <a href="mailto:hr@ems.com">hr@ems.com</a></div>
            <div class="contact-detail">Response Time: Within 24 hours</div>
        </div>
        
        <div class="contact-item">
            <div class="contact-title">💻 IT HELP DESK</div>
            <div class="contact-detail">Call: +1 (800) 555-0456</div>
            <div class="contact-detail">Email: <a href="mailto:ithelp@ems.com">ithelp@ems.com</a></div>
        </div>
        
        <div class="no-notification">
            <div class="no-notification-icon">🔔</div>
            <div class="no-notification-title">No New Notifications</div>
            <div class="no-notification-message">You have no new support notifications. All your tickets are up to date.</div>
        </div>
        
        <div style="text-align: center; margin-top: 20px;">
            <a href="employeeDashboard.jsp" class="btn-back">← BACK TO DASHBOARD</a>
        </div>
    </div>
</div>
</body>
</html>