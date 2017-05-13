/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.slu.scis.webtek.beans;

/**
 *
 * @author Hiromi Uematsu
 */
public class Requests {
    private int bookingId; 
    private String bookingStatus;

    public Requests(int bookingId, String bookingStatus) {
        this.bookingId = bookingId;
        this.bookingStatus = bookingStatus;
    }

    public int getBookingId() {
        return bookingId;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingId(int bookingId){
        this.bookingId = bookingId;
    }
    
    public void setBookingStatus(String bookingStatus){
        this.bookingStatus = bookingStatus;
    }
    
}

