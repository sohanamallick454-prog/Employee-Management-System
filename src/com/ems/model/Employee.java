package com.ems.model;

public class Employee {
    private int id;
    private String employeeCode;
    private String name;
    private String email;
    private String department;
    private String position;
    private double salary;
    private String phone;
    private String address;
    private String hireDate;
    private String status;
    
    // Constructor
    public Employee() {}
    
    // Getters
    public int getId() { return id; }
    public String getEmployeeCode() { return employeeCode; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getDepartment() { return department; }
    public String getPosition() { return position; }
    public double getSalary() { return salary; }
    public String getPhone() { return phone; }
    public String getAddress() { return address; }
    public String getHireDate() { return hireDate; }
    public String getStatus() { return status; }
    
    // Setters
    public void setId(int id) { this.id = id; }
    public void setEmployeeCode(String employeeCode) { this.employeeCode = employeeCode; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setDepartment(String department) { this.department = department; }
    public void setPosition(String position) { this.position = position; }
    public void setSalary(double salary) { this.salary = salary; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setAddress(String address) { this.address = address; }
    public void setHireDate(String hireDate) { this.hireDate = hireDate; }
    public void setStatus(String status) { this.status = status; }
}