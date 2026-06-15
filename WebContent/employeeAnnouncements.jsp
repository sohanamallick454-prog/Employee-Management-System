<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.ems.model.Announcement" %>
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
    <title>Announcements</title>
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
        .announcement-card {
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
            padding: 30px;
            box-shadow: 8px 8px 0px #5a7c5a;
        }
        .announcement-card h2 {
            color: #4a6b4a;
            margin-bottom: 20px;
            text-align: center;
        }
        .announcement-item {
            background: #E8F0E0;
            padding: 20px;
            margin-bottom: 15px;
            border-left: 4px solid #6B8E6B;
            transition: all 0.3s;
        }
        .announcement-item:hover {
            transform: translateX(5px);
            background: #d5e6cd;
        }
        .announcement-title {
            font-size: 18px;
            font-weight: bold;
            color: #4a6b4a;
        }
        .announcement-date {
            font-size: 11px;
            color: #5a7c5a;
            margin: 5px 0;
        }
        .announcement-content {
            font-size: 14px;
            color: #4a6b4a;
            margin-top: 10px;
            line-height: 1.5;
        }
        .no-update {
            text-align: center;
            padding: 60px 20px;
            background: #E8F0E0;
            border: 2px dashed #8FBC8F;
        }
        .no-update-icon {
            font-size: 64px;
            margin-bottom: 20px;
            color: #5a7c5a;
        }
        .no-update-title {
            font-size: 24px;
            color: #4a6b4a;
            margin-bottom: 10px;
        }
        .no-update-message {
            color: #5a7c5a;
            font-size: 14px;
        }
        .btn-back {
            display: inline-block;
            background: #6B8E6B;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-top: 20px;
            text-align: center;
        }
        .btn-back:hover {
            background: #4a6b4a;
        }
        .announcement-count {
            text-align: center;
            margin-bottom: 15px;
            color: #5a7c5a;
            font-size: 12px;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>ANNOUNCEMENTS</h2>
    Welcome, <%= session.getAttribute("username") %>
    <a href="logout.jsp">LOGOUT</a>
    <a href="employeeDashboard.jsp">BACK</a>
</div>

<div class="container">
    <div class="announcement-card">
        <h2>COMPANY UPDATES</h2>
        
        <%
            List<Announcement> announcements = (List<Announcement>) request.getAttribute("announcements");
            if(announcements != null && !announcements.isEmpty()) {
        %>
        <div class="announcement-count">
            Total <%= announcements.size() %> new announcement(s)
        </div>
        
        <%
            for(Announcement ann : announcements) {
        %>
        <div class="announcement-item">
            <div class="announcement-title"><%= ann.getTitle() %></div>
            <div class="announcement-date">Posted: <%= ann.getPostedDate() %></div>
            <div class="announcement-content"><%= ann.getContent() %></div>
        </div>
        <%
            }
        } else {
        %>
        <div class="no-update">
            <div class="no-update-icon">*</div>
            <div class="no-update-title">No New Announcements</div>
            <div class="no-update-message">There are no new updates at this time. Please check back later.</div>
        </div>
        <% } %>
        
        <div style="text-align: center; margin-top: 20px;">
            <a href="employeeDashboard.jsp" class="btn-back">BACK TO DASHBOARD</a>
        </div>
    </div>
</div>
</body>
</html>