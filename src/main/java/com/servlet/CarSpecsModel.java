package com.servlet;

/**
 * Bean / DTO for the CAR_SPECS table.
 * Contains detailed technical specifications for a car.
 * Linked to CAR_DETAILS via CAR_ID.
 */
public class CarSpecsModel {

    private int    carId;
    private String brand;
    private String model;

    /* Dimensions */
    private String length;
    private String width;
    private String height;
    private String wheelbase;

    /* Engine & Performance */
    private String engineType;
    private String displacement;
    private String motorType;
    private String maxPower;
    private String maxTorque;
    private String noOfCylinders;
    private String valvesPerCylinder;

    /* Electric / Battery */
    private String batteryType;
    private String regenerativeBraking;
    private String wirelessCharging;

    /* Transmission */
    private String transmissionType;
    private String gearbox;
    private String hybridType;
    private String driveType;

    /* Fuel & Efficiency */
    private String fuelType;
    private String petrolMileageArai;
    private String petrolFuelTankCapacity;
    private String emissionNormCompliance;

    /* Suspension & Steering */
    private String frontSuspension;
    private String rearSuspension;
    private String steeringType;
    private String steeringColumn;
    private String steeringGearType;
    private String turningRadius;

    /* Brakes */
    private String frontBrakeType;
    private String rearBrakeType;

    /* General */
    private String seatingCapacity;
    private String grossWeight;
    private String sourceUrl;

    // -----------------------------------------------------------------------
    // Getters and Setters
    // -----------------------------------------------------------------------

    public int    getCarId()                                   { return carId; }
    public void   setCarId(int carId)                          { this.carId = carId; }

    public String getBrand()                                   { return brand; }
    public void   setBrand(String brand)                       { this.brand = brand; }

    public String getModel()                                   { return model; }
    public void   setModel(String model)                       { this.model = model; }

    public String getLength()                                  { return length; }
    public void   setLength(String length)                     { this.length = length; }

    public String getWidth()                                   { return width; }
    public void   setWidth(String width)                       { this.width = width; }

    public String getHeight()                                  { return height; }
    public void   setHeight(String height)                     { this.height = height; }

    public String getWheelbase()                               { return wheelbase; }
    public void   setWheelbase(String wheelbase)               { this.wheelbase = wheelbase; }

    public String getEngineType()                              { return engineType; }
    public void   setEngineType(String engineType)             { this.engineType = engineType; }

    public String getDisplacement()                            { return displacement; }
    public void   setDisplacement(String displacement)         { this.displacement = displacement; }

    public String getMotorType()                               { return motorType; }
    public void   setMotorType(String motorType)               { this.motorType = motorType; }

    public String getMaxPower()                                { return maxPower; }
    public void   setMaxPower(String maxPower)                 { this.maxPower = maxPower; }

    public String getMaxTorque()                               { return maxTorque; }
    public void   setMaxTorque(String maxTorque)               { this.maxTorque = maxTorque; }

    public String getNoOfCylinders()                           { return noOfCylinders; }
    public void   setNoOfCylinders(String noOfCylinders)       { this.noOfCylinders = noOfCylinders; }

    public String getValvesPerCylinder()                       { return valvesPerCylinder; }
    public void   setValvesPerCylinder(String v)               { this.valvesPerCylinder = v; }

    public String getBatteryType()                             { return batteryType; }
    public void   setBatteryType(String batteryType)           { this.batteryType = batteryType; }

    public String getRegenerativeBraking()                     { return regenerativeBraking; }
    public void   setRegenerativeBraking(String v)             { this.regenerativeBraking = v; }

    public String getWirelessCharging()                        { return wirelessCharging; }
    public void   setWirelessCharging(String wirelessCharging) { this.wirelessCharging = wirelessCharging; }

    public String getTransmissionType()                        { return transmissionType; }
    public void   setTransmissionType(String v)                { this.transmissionType = v; }

    public String getGearbox()                                 { return gearbox; }
    public void   setGearbox(String gearbox)                   { this.gearbox = gearbox; }

    public String getHybridType()                              { return hybridType; }
    public void   setHybridType(String hybridType)             { this.hybridType = hybridType; }

    public String getDriveType()                               { return driveType; }
    public void   setDriveType(String driveType)               { this.driveType = driveType; }

    public String getFuelType()                                { return fuelType; }
    public void   setFuelType(String fuelType)                 { this.fuelType = fuelType; }

    public String getPetrolMileageArai()                       { return petrolMileageArai; }
    public void   setPetrolMileageArai(String v)               { this.petrolMileageArai = v; }

    public String getPetrolFuelTankCapacity()                  { return petrolFuelTankCapacity; }
    public void   setPetrolFuelTankCapacity(String v)          { this.petrolFuelTankCapacity = v; }

    public String getEmissionNormCompliance()                  { return emissionNormCompliance; }
    public void   setEmissionNormCompliance(String v)          { this.emissionNormCompliance = v; }

    public String getFrontSuspension()                         { return frontSuspension; }
    public void   setFrontSuspension(String v)                 { this.frontSuspension = v; }

    public String getRearSuspension()                          { return rearSuspension; }
    public void   setRearSuspension(String rearSuspension)     { this.rearSuspension = rearSuspension; }

    public String getSteeringType()                            { return steeringType; }
    public void   setSteeringType(String steeringType)         { this.steeringType = steeringType; }

    public String getSteeringColumn()                          { return steeringColumn; }
    public void   setSteeringColumn(String steeringColumn)     { this.steeringColumn = steeringColumn; }

    public String getSteeringGearType()                        { return steeringGearType; }
    public void   setSteeringGearType(String v)                { this.steeringGearType = v; }

    public String getTurningRadius()                           { return turningRadius; }
    public void   setTurningRadius(String turningRadius)       { this.turningRadius = turningRadius; }

    public String getFrontBrakeType()                          { return frontBrakeType; }
    public void   setFrontBrakeType(String frontBrakeType)     { this.frontBrakeType = frontBrakeType; }

    public String getRearBrakeType()                           { return rearBrakeType; }
    public void   setRearBrakeType(String rearBrakeType)       { this.rearBrakeType = rearBrakeType; }

    public String getSeatingCapacity()                         { return seatingCapacity; }
    public void   setSeatingCapacity(String seatingCapacity)   { this.seatingCapacity = seatingCapacity; }

    public String getGrossWeight()                             { return grossWeight; }
    public void   setGrossWeight(String grossWeight)           { this.grossWeight = grossWeight; }

    public String getSourceUrl()                               { return sourceUrl; }
    public void   setSourceUrl(String sourceUrl)               { this.sourceUrl = sourceUrl; }
}
