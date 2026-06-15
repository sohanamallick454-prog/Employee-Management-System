package com.ems.model;

public class Announcement {
    private int id;
    private String title;
    private String content;
    private String postedDate;
    private String status;
    
    public Announcement() {}
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getPostedDate() { return postedDate; }
    public void setPostedDate(String postedDate) { this.postedDate = postedDate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
