package com.ems.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ems.model.Employee;

public class EmployeeListServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Pagination parameters
        int page = 1;
        int pageSize = 5;
        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");
        
        if(pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }
        if(pageSizeParam != null && !pageSizeParam.isEmpty()) {
            pageSize = Integer.parseInt(pageSizeParam);
        }
        
        // Sorting parameters
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        
        if(sortBy == null || sortBy.isEmpty()) {
            sortBy = "id";
        }
        if(sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }
        
        List<Employee> employees = new ArrayList<Employee>();
        int totalEmployees = 0;
        int totalPages = 0;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "root123");
            
            // Get total count
            java.sql.Statement countStmt = con.createStatement();
            ResultSet countRs = countStmt.executeQuery("SELECT COUNT(*) FROM employees");
            if(countRs.next()) {
                totalEmployees = countRs.getInt(1);
            }
            totalPages = (int) Math.ceil((double) totalEmployees / pageSize);
            countRs.close();
            countStmt.close();
            
            // Get employees with pagination and sorting
            int offset = (page - 1) * pageSize;
            String query = "SELECT * FROM employees ORDER BY " + sortBy + " " + sortOrder + " LIMIT ? OFFSET ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                Employee emp = new Employee();
                emp.setId(rs.getInt("id"));
                emp.setEmployeeCode(rs.getString("employee_code"));
                emp.setName(rs.getString("name"));
                emp.setEmail(rs.getString("email"));
                emp.setDepartment(rs.getString("department"));
                emp.setPosition(rs.getString("position"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setPhone(rs.getString("phone"));
                emp.setAddress(rs.getString("address"));
                emp.setHireDate(rs.getString("hire_date"));
                emp.setStatus(rs.getString("status"));
                employees.add(emp);
            }
            
            con.close();
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        request.setAttribute("employees", employees);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalEmployees", totalEmployees);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        
        request.getRequestDispatcher("employeeList.jsp").forward(request, response);
    }
}