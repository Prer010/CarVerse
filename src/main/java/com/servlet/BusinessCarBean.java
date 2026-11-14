package com.servlet;

/**
 * Bean / DTO for the CAR_DETAILS table, scoped to a Business Partner.
 * Mapped to CAR_DETAILS columns (MODEL_NAME, BRAND, PRICE_RANGE, etc.).
 * "businessId" maps to CAR_DETAILS.COMPANY_ID in the database.
 */
public class BusinessCarBean {

    // Primary key
    private String carId;

    // Owner
    private String businessId;

    // Car identification
    private String registrationNumber;
    private String modelName;
    private String carName;
    private String brand;
    private String model;
    private int    manufacturingYear;

    // Specs
    private String bodyType;
    private String fuelType;
    private String transmission;
    private int    seatingCapacity;
    private String color;

    // Pricing
    private String priceRange;
    private double pricePerDay;
    private String location;

    // Image URLs
    private String images;

    // Status: AVAILABLE | BOOKED | MAINTENANCE | INACTIVE
    private String availabilityStatus;

    // Timestamps
    private String createdAt;
    private String updatedAt;

    public BusinessCarBean() {}

    // Getters and Setters
    public String getCarId()                      { return carId; }
    public void   setCarId(String v)              { this.carId = v; }

    public String getBusinessId()                 { return businessId; }
    public void   setBusinessId(String v)         { this.businessId = v; }

    public String getRegistrationNumber()         { return registrationNumber; }
    public void   setRegistrationNumber(String v) { this.registrationNumber = v; }

    public String getModelName()                  { return modelName != null ? modelName : carName; }
    public void   setModelName(String v)          { this.modelName = v; if (this.carName == null) this.carName = v; }

    public String getCarName()                    { return getModelName(); }
    public void   setCarName(String v)            { setModelName(v); }

    public String getBrand()                      { return brand; }
    public void   setBrand(String v)              { this.brand = v; }

    public String getModel()                      { return model != null ? model : getModelName(); }
    public void   setModel(String v)              { this.model = v; }

    public int    getManufacturingYear()          { return manufacturingYear; }
    public void   setManufacturingYear(int v)     { this.manufacturingYear = v; }

    public String getBodyType()                   { return bodyType; }
    public void   setBodyType(String v)           { this.bodyType = v; }

    public String getFuelType()                   { return fuelType; }
    public void   setFuelType(String v)           { this.fuelType = v; }

    public String getTransmission()               { return transmission; }
    public void   setTransmission(String v)       { this.transmission = v; }

    public int    getSeatingCapacity()            { return seatingCapacity; }
    public void   setSeatingCapacity(int v)       { this.seatingCapacity = v; }

    public String getColor()                      { return color; }
    public void   setColor(String v)              { this.color = v; }

    public String getPriceRange()                 { return priceRange != null ? priceRange : (pricePerDay > 0 ? "₹" + (long)pricePerDay : ""); }
    public void   setPriceRange(String v)         { this.priceRange = v; }

    public double getPricePerDay() {
        if (pricePerDay > 0) return pricePerDay;
        if (priceRange != null) {
            try {
                String clean = priceRange.replaceAll("[^0-9.]", "").trim();
                if (!clean.isEmpty()) return Double.parseDouble(clean);
            } catch (Exception ignored) {}
        }
        return 0.0;
    }
    public void   setPricePerDay(double v)        { this.pricePerDay = v; if (priceRange == null) priceRange = "₹" + (long)v; }

    public String getLocation()                   { return location; }
    public void   setLocation(String v)           { this.location = v; }

    public String getImages()                     { return images; }
    public void   setImages(String v)             { this.images = v; }

    public String getAvailabilityStatus()         { return availabilityStatus; }
    public void   setAvailabilityStatus(String v) { this.availabilityStatus = v; }

    public String getCreatedAt()                  { return createdAt; }
    public void   setCreatedAt(String v)          { this.createdAt = v; }

    public String getUpdatedAt()                  { return updatedAt; }
    public void   setUpdatedAt(String v)          { this.updatedAt = v; }
}
