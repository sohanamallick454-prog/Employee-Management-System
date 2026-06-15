package com.ems.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
    
    // Email configuration - UPDATED WITH YOUR CREDENTIALS
    private static final String FROM_EMAIL = "kaliputri111@gmail.com";
    private static final String FROM_PASSWORD = "lpnq bvyq xful kqag";
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    
    /**
     * Send email to employee when record is created or updated
     */
    public static boolean sendEmployeeNotification(String toEmail, String employeeName, String action, String details) {
        
        if (toEmail == null || toEmail.isEmpty()) {
            System.out.println("No email address provided for " + employeeName);
            return false;
        }
        
        String subject = "Employee Record " + action;
        String body = "Dear " + employeeName + ",\n\n"
                + "Your employee record has been " + action.toLowerCase() + " successfully.\n\n"
                + "Details:\n"
                + "-----------------------\n"
                + details
                + "-----------------------\n\n"
                + "Best Regards,\n"
                + "HR Team\n"
                + "Employee Management System";
        
        return sendEmail(toEmail, subject, body);
    }
    
    /**
     * Send salary update notification
     */
    public static boolean sendSalaryUpdateEmail(String toEmail, String employeeName, double oldSalary, double newSalary) {
        String subject = "Salary Update Notification";
        String body = "Dear " + employeeName + ",\n\n"
                + "Your salary has been updated.\n\n"
                + "Previous Salary: $" + String.format("%,.2f", oldSalary) + "\n"
                + "New Salary: $" + String.format("%,.2f", newSalary) + "\n"
                + "Effective Date: Immediately\n\n"
                + "Please check your profile for more details.\n\n"
                + "Best Regards,\n"
                + "HR Department";
        
        return sendEmail(toEmail, subject, body);
    }
    
    /**
     * Send welcome email to new employee
     */
    public static boolean sendWelcomeEmail(String toEmail, String employeeName, String employeeCode, String password) {
        String subject = "Welcome to the Company!";
        String body = "Dear " + employeeName + ",\n\n"
                + "Welcome to the team! Your employee account has been created.\n\n"
                + "Your login credentials:\n"
                + "Username: " + toEmail + "\n"
                + "Password: " + password + "\n"
                + "Employee Code: " + employeeCode + "\n\n"
                + "Please login to the Employee Management System to complete your profile.\n\n"
                + "Login URL: http://localhost:8080/EmployeeManagementSystem/login.jsp\n\n"
                + "Best Regards,\n"
                + "HR Department";
        
        return sendEmail(toEmail, subject, body);
    }
    
    /**
     * Send email using SMTP
     */
    private static boolean sendEmail(String toEmail, String subject, String body) {
        
        // Don't send if email not configured
        if (FROM_EMAIL.equals("your_email@gmail.com") || FROM_PASSWORD.equals("your_app_password")) {
            System.out.println("Email not sent - Please configure email settings in EmailUtil.java");
            System.out.println("To: " + toEmail + ", Subject: " + subject);
            return false;
        }
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);
            
            Transport.send(message);
            System.out.println("Email sent successfully to: " + toEmail);
            return true;
            
        } catch (MessagingException e) {
            System.out.println("Failed to send email to: " + toEmail);
            e.printStackTrace();
            return false;
        }
    }
}