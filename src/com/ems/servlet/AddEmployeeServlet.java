package com.ems.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ems.util.EmailUtil;

public class AddEmployeeServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String employeeCode = request.getParameter("employeeCode");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        String position = request.getParameter("position");
        double salary = Double.parseDouble(request.getParameter("salary"));
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String hireDate = request.getParameter("hireDate");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
            
            String sql = "INSERT INTO employees (employee_code, name, email, department, position, salary, phone, address, hire_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'active')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, employeeCode);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, department);
            ps.setString(5, position);
            ps.setDouble(6, salary);
            ps.setString(7, phone);
            ps.setString(8, address);
            ps.setString(9, hireDate);
            
            int result = ps.executeUpdate();
            con.close();
            
            if(result > 0) {
                // Send email notification
                String details = "Employee Code: " + employeeCode + "\n"
                        + "Name: " + name + "\n"
                        + "Email: " + email + "\n"
                        + "Department: " + department + "\n"
                        + "Position: " + position + "\n"
                        + "Salary: $" + String.format("%,.2f", salary) + "\n"
                        + "Hire Date: " + hireDate;
                
                boolean emailSent = EmailUtil.sendEmployeeNotification(email, name, "Created", details);
                
                if(emailSent) {
                    session.setAttribute("message", "Employee added successfully! Email notification sent to " + email);
                } else {
                    session.setAttribute("message", "Employee added successfully! (Email not sent - configure email settings)");
                }
                response.sendRedirect("adminDashboard.jsp");
            } else {
                request.setAttribute("error", "Failed to add employee");
                request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
    }
}