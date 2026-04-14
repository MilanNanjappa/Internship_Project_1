use  factory_analysis;

-- Hourly aggregate :
SELECT 
    Plant,
    DATE_FORMAT(Timestamp, '%Y-%m-%d %H:00:00') AS Hour,
    SUM(ProductionUnits) AS Total_ProductionUnits
FROM production_unit
GROUP BY 
    Plant,
    DATE_FORMAT(Timestamp, '%Y-%m-%d %H:00:00')
ORDER BY 
    Plant, Hour;
    
    
-- daily aggregate :
SELECT 
    Plant,
    DATE(Timestamp) AS Day,
    SUM(ProductionUnits) AS Total_ProductionUnits
FROM production_unit
GROUP BY 
    Plant,
    DATE(Timestamp)
ORDER BY 
    Plant, Day;
    
 
    
-- top 10 machines with lowest average ProductionUnits and their maintenance counts. 
SELECT 
    MachineID,
    AVG(ProductionUnits) AS Avg_ProductionUnits,
    SUM(MaintenanceFlag) AS Maintenance_Count
FROM production_unit
GROUP BY MachineID
ORDER BY Avg_ProductionUnits ASC
LIMIT 10;


USE factory_analysis;

DROP TABLE IF EXISTS capacity_stability_2025;

CREATE TABLE capacity_stability_2025 (
    MachineID INT,
    Plant VARCHAR(50),
    AvgOutput FLOAT,
    StdOutput FLOAT,
    CV_Output FLOAT,
    MaintenanceCount INT,
    DefectCountTotal INT
);

DESCRIBE capacity_stability_2025;

SHOW TABLES;
INSERT INTO capacity_stability_2025
(MachineID, Plant, AvgOutput, StdOutput, CV_Output, MaintenanceCount, DefectCountTotal)

SELECT 
    MachineID,
    Plant,
    AVG(ProductionUnits) AS AvgOutput,
    STDDEV(ProductionUnits) AS StdOutput,
    STDDEV(ProductionUnits) / AVG(ProductionUnits) AS CV_Output,
    SUM(MaintenanceFlag) AS MaintenanceCount,
    SUM(DefectCount) AS DefectCountTotal
FROM production_data
GROUP BY MachineID, Plant;

SELECT * FROM capacity_stability_2025 LIMIT 10;






