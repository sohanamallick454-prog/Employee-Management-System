<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee</title>
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
        }
        .container {
            max-width: 600px;
            margin: 30px auto;
            padding: 30px;
            background: #F0F7E6;
            border: 3px solid #4a6b4a;
        }
        h2 {
            color: #4a6b4a;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
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
            background: #6B8E6B;
            color: white;
            padding: 12px;
            border: none;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        .btn-submit:hover {
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
        .error {
            background: #f0e0dd;
            color: #c0392b;
            padding: 10px;
            margin-bottom: 15px;
            border-left: 4px solid #c0392b;
        }
        .success {
            background: #d5f4e6;
            color: #27ae60;
            padding: 10px;
            margin-bottom: 15px;
            border-left: 4px solid #27ae60;
        }
        .row {
            display: flex;
            gap: 15px;
        }
        .row .form-group {
            flex: 1;
        }
        @media (max-width: 600px) {
            .row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <h2>EMPLOYEE MANAGEMENT SYSTEM</h2>
    Welcome, <%= session.getAttribute("username") %> | <a href="logout.jsp">LOGOUT</a>
</div>

<div class="container">
    <h2>ADD NEW EMPLOYEE</h2>
    
    <% if(request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>
    
    <% if(session.getAttribute("message") != null) { %>
        <div class="success"><%= session.getAttribute("message") %></div>
        <%
            session.removeAttribute("message");
        %>
    <% } %>
    
    <form action="add-employee" method="post">
        <div class="row">
            <div class="form-group">
                <label>Employee Code *</label>
                <input type="text" name="employeeCode" required placeholder="EMP001">
            </div>
            <div class="form-group">
                <label>Full Name *</label>
                <input type="text" name="name" required placeholder="John Doe">
            </div>
        </div>
        
        <div class="row">
            <div class="form-group">
                <label>Email *</label>
                <input type="email" name="email" required placeholder="john@example.com">
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="text" name="phone" placeholder="9876543210">
            </div>
        </div>
        
        <div class="row">
            <div class="form-group">
                <label>Department *</label>
                <select name="department" required>
                    <option value="">Select Department</option>
                    <option value="IT">IT</option>
                    <option value="HR">HR</option>
                    <option value="Finance">Finance</option>
                    <option value="Marketing">Marketing</option>
                    <option value="Sales">Sales</option>
                    <option value="Operations">Operations</option>
                </select>
            </div>
            <div class="form-group">
                <label>Position *</label>
                <input type="text" name="position" required placeholder="Software Developer">
            </div>
        </div>
        
        <div class="row">
            <div class="form-group">
                <label>Salary *</label>
                <input type="number" name="salary" step="0.01" required placeholder="50000">
            </div>
            <div class="form-group">
                <label>Hire Date *</label>
                <input type="date" name="hireDate" required>
            </div>
        </div>
        
        <div class="form-group">
            <label>Address</label>
            <textarea name="address" rows="3" placeholder="Enter full address"></textarea>
        </div>
        
        <button type="submit" class="btn-submit">SAVE EMPLOYEE</button>
    </form>
    
    <a href="adminDashboard.jsp" class="btn-back">BACK TO DASHBOARD</a>
</div>

<script>
    // Set default hire date to today
    var today = new Date().toISOString().split('T')[0];
    var dateInput = document.querySelector('input[type="date"]');
    if(dateInput) {
        dateInput.value = today;
    }
</script>
</body>
</html>