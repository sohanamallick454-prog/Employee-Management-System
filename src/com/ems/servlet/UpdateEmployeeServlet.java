package com.ems.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ems.util.EmailUtil;

public class UpdateEmployeeServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        String employeeCode = request.getParameter("employeeCode");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        String position = request.getParameter("position");
        double salary = Double.parseDouble(request.getParameter("salary"));
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String hireDate = request.getParameter("hireDate");
        String status = request.getParameter("status");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
            
            // Get old salary for comparison
            double oldSalary = 0;
            PreparedStatement getPs = con.prepareStatement("SELECT salary, email, name FROM employees WHERE id = ?");
            getPs.setInt(1, id);
            ResultSet rs = getPs.executeQuery();
            if(rs.next()) {
                oldSalary = rs.getDouble("salary");
                email = rs.getString("email");
                name = rs.getString("name");
            }
            rs.close();
            getPs.close();
            
            String sql = "UPDATE employees SET employee_code=?, name=?, email=?, department=?, position=?, salary=?, phone=?, address=?, hire_date=?, status=? WHERE id=?";
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
            ps.setString(10, status);
            ps.setInt(11, id);
            
            int result = ps.executeUpdate();
            con.close();
            
            if(result > 0) {
                // Send email notification based on changes
                String details = "Employee Code: " + employeeCode + "\n"
                        + "Name: " + name + "\n"
                        + "Email: " + email + "\n"
                        + "Department: " + department + "\n"
                        + "Position: " + position + "\n"
                        + "Salary: $" + String.format("%,.2f", salary) + "\n"
                        + "Status: " + status;
                
                boolean emailSent = EmailUtil.sendEmployeeNotification(email, name, "Updated", details);
                
                // Send salary update notification if salary changed
                if(oldSalary != salary && oldSalary > 0) {
                    EmailUtil.sendSalaryUpdateEmail(email, name, oldSalary, salary);
                }
                
                if(emailSent) {
                    session.setAttribute("message", "Employee updated successfully! Email notification sent.");
                } else {
                    session.setAttribute("message", "Employee updated successfully!");
                }
                response.sendRedirect("manageEmployees.jsp");
            } else {
                session.setAttribute("error", "Failed to update employee");
                response.sendRedirect("manageEmployees.jsp");
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect("manageEmployees.jsp");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("updateEmployee.jsp").forward(request, response);
    }
}
