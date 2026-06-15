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
import com.ems.model.Employee;

public class EmployeeSalaryServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        if(username == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Employee employee = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
            
            String sql = "SELECT e.* FROM employees e " +
                         "INNER JOIN users u ON u.employee_id = e.id " +
                         "WHERE u.username = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()) {
                employee = new Employee();
                employee.setId(rs.getInt("id"));
                employee.setEmployeeCode(rs.getString("employee_code"));
                employee.setName(rs.getString("name"));
                employee.setSalary(rs.getDouble("salary"));
                employee.setPosition(rs.getString("position"));
                employee.setDepartment(rs.getString("department"));
                employee.setHireDate(rs.getString("hire_date"));
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        request.setAttribute("employee", employee);
        request.getRequestDispatcher("employeeSalary.jsp").forward(request, response);
    }
}
