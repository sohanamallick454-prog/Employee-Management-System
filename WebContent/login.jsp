<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>EMS Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Courier New', monospace;
            background-color: #8FBC8F;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
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
        
        .container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 450px;
            margin: 20px;
        }
        
        .login-card {
            background: #F0F7E6;
            padding: 40px;
            border-radius: 0px;
            box-shadow: 8px 8px 0px #5a7c5a;
            border: 3px solid #4a6b4a;
            transition: all 0.3s;
        }
        
        .login-card:hover {
            transform: translate(-2px, -2px);
            box-shadow: 12px 12px 0px #5a7c5a;
        }
        
        h2 {
            text-align: center;
            color: #4a6b4a;
            margin-bottom: 30px;
            font-family: 'Courier New', monospace;
            font-size: 28px;
            letter-spacing: 2px;
            text-transform: uppercase;
            border-bottom: 3px dotted #8FBC8F;
            padding-bottom: 15px;
        }
        
        .input-group {
            margin-bottom: 25px;
        }
        
        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: #4a6b4a;
            font-weight: bold;
            font-family: 'Courier New', monospace;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .input-group input {
            width: 100%;
            padding: 12px 15px;
            border: 3px solid #8FBC8F;
            border-radius: 0px;
            font-size: 14px;
            font-family: 'Courier New', monospace;
            background: #FFFFF0;
            transition: all 0.3s;
            box-sizing: border-box;
        }
        
        .input-group input:focus {
            outline: none;
            border-color: #4a6b4a;
            background: #FFFFFF;
            transform: scale(1.01);
        }
        
        .password-wrapper {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 12px;
            user-select: none;
            background: #FFFFF0;
            padding: 2px 6px;
            color: #4a6b4a;
            border: 1px solid #8FBC8F;
        }
        
        button {
            width: 100%;
            padding: 14px;
            background: #6B8E6B;
            color: #FFFFF0;
            border: 3px solid #4a6b4a;
            border-radius: 0px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            font-family: 'Courier New', monospace;
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: all 0.3s;
        }
        
        button:hover {
            background: #4a6b4a;
            transform: translate(-2px, -2px);
            box-shadow: 4px 4px 0px #2d4a2d;
        }
        
        button:active {
            transform: translate(2px, 2px);
            box-shadow: none;
        }
        
        .signup-link {
            text-align: center;
            margin-top: 20px;
            color: #5a7c5a;
            font-family: 'Courier New', monospace;
        }
        
        .signup-link a {
            color: #4a6b4a;
            text-decoration: none;
            font-weight: bold;
            border-bottom: 2px dotted #8FBC8F;
        }
        
        .signup-link a:hover {
            color: #2d4a2d;
            border-bottom: 2px solid #4a6b4a;
        }
        
        .error {
            color: #c0392b;
            text-align: center;
            margin-top: 15px;
            padding: 10px;
            background: #f0e0dd;
            border-left: 4px solid #c0392b;
            font-family: 'Courier New', monospace;
            font-size: 13px;
        }
        
        .success {
            color: #27ae60;
            text-align: center;
            margin-top: 15px;
            padding: 10px;
            background: #d5f4e6;
            border-left: 4px solid #27ae60;
            font-family: 'Courier New', monospace;
            font-size: 13px;
        }
        
        .info {
            background: #E8F0E0;
            padding: 15px;
            margin-top: 20px;
            border-left: 4px solid #6B8E6B;
            font-size: 12px;
            text-align: center;
            font-family: 'Courier New', monospace;
            color: #5a7c5a;
        }
        
        .credentials-list {
            margin-top: 10px;
            text-align: left;
            font-size: 11px;
            border-top: 1px dotted #8FBC8F;
            padding-top: 8px;
        }
        
        .credentials-list p {
            margin: 3px 0;
        }
        
        .admin-text {
            color: #4a6b4a;
            font-weight: bold;
        }
        
        .employee-text {
            color: #6B8E6B;
            font-weight: bold;
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
        
        @keyframes floatDaisy {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-8px) rotate(3deg); }
        }
        
        .floating {
            position: absolute;
            animation: floatDaisy 4s ease-in-out infinite;
            pointer-events: none;
            z-index: 1;
            font-size: 24px;
            font-weight: bold;
            color: #FFD700;
        }
        
        @media (max-width: 768px) {
            .login-card { padding: 25px; margin: 15px; }
            h2 { font-size: 22px; }
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

<div class="container">
    <div class="login-card">
        <h2>EMS LOGIN</h2>
        
        <form action="LoginServlet" method="post">
            <div class="input-group">
                <label>USERNAME</label>
                <input type="text" name="username" id="username" placeholder="Enter username" required>
            </div>
            
            <div class="input-group">
                <label>PASSWORD</label>
                <div class="password-wrapper">
                    <input type="password" name="password" id="password" placeholder="Enter password" required>
                    <span class="toggle-password" onclick="togglePassword()">SHOW</span>
                </div>
            </div>
            
            <button type="submit">LOGIN</button>
        </form>
        
        <div class="signup-link">
            Don't have an account? <a href="#" onclick="alert('Contact admin to create account')">Sign Up</a>
        </div>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if(request.getAttribute("message") != null) { %>
            <div class="success"><%= request.getAttribute("message") %></div>
        <% } %>
        
        <div class="info">
            <strong>DEMO CREDENTIALS</strong><br><br>
            
            <strong class="admin-text">🔐 ADMIN</strong><br>
            Username: admin | Password: admin123<br><br>
            
            <strong class="employee-text">👥 EMPLOYEES</strong>
            <div class="credentials-list">
                <p>📌 john.doe | Password: john123</p>
                <p>📌 jane.smith | Password: jane123</p>
                <p>📌 mike.johnson | Password: mike123</p>
                <p>📌 sarah.wilson | Password: sarah123</p>
                <p>📌 robert.brown | Password: robert123</p>
                <p>📌 lisa.davis | Password: lisa123</p>
            </div>
        </div>
    </div>
</div>

<script>
    function togglePassword() {
        var passwordInput = document.getElementById('password');
        var toggleBtn = document.querySelector('.toggle-password');
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleBtn.textContent = 'HIDE';
        } else {
            passwordInput.type = 'password';
            toggleBtn.textContent = 'SHOW';
        }
    }
    
    var inputs = document.querySelectorAll('input');
    for(var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('focus', function() {
            this.style.borderColor = '#4a6b4a';
            this.style.backgroundColor = '#FFFFFF';
        });
        inputs[i].addEventListener('blur', function() {
            this.style.borderColor = '#8FBC8F';
            this.style.backgroundColor = '#FFFFF0';
        });
    }
</script>

</body>
</html>