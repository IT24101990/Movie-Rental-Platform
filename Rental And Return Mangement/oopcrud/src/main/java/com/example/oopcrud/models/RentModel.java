package com.example.oopcrud.models;

public class RentModel extends BaseEntity {
    private String movieName;
    private String customerName;
    private String rentedDate;
    private String rentedTime;
    private double price;
    private double fine = 0.0;
    private String status;
    private String contactNumber;

    public RentModel() {
        // Default constructor
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getRentedDate() {
        return rentedDate;
    }

    public void setRentedDate(String rentedDate) {
        this.rentedDate = rentedDate;
    }

    public String getRentedTime() {
        return rentedTime;
    }

    public void setRentedTime(String rentedTime) {
        this.rentedTime = rentedTime;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getFine() {
        return fine;
    }

    public void setFine(double fine) {
        this.fine = fine;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }
}