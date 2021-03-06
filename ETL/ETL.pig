wget <link>

pwd noise_dataset.csv
/home/mh4047/data/noise_dataset.csv

From the site
dumbo:/mnt/hdfs/user/mh4047/noise_dataset.csv

> pig
Noise = LOAD 'noise_dataset.csv' USING PigStorage(',') as (Unique_Key:chararray,Created_Date:chararray,Closed_Date:chararray,Agency:chararray,Agency_Name:chararray,Complaint_Type:chararray,Descriptor:chararray,Location_Type:chararray,Incident_Zip:chararray,Incident_Address:chararray,Street_Name:chararray,Cross_Street_1:chararray,Cross_Street_2:chararray,Intersection_Street_1:chararray,Intersection_Street_2:chararray,Address_Type:chararray,City:chararray,Landmark:chararray,Facility_Type:chararray,Status:chararray,Due_Date:chararray,Resolution_Action_Updated_Date:chararray,Community_Board:chararray,Borough:chararray,X_Coordinate:chararray,Y_Coordinate:chararray,Park_Facility_Name:chararray,Park_Borough:chararray,School_Name:chararray,School_Number:chararray,School_Region:chararray,School_Code:chararray,School_Phone_Number:chararray,School_Address:chararray,School_City:chararray,School_State:chararray,School_Zip:chararray,School_Not_Found:chararray,School_or_Citywide_Complaint:chararray,Vehicle_Type:chararray,Taxi_Company_Borough:chararray,Taxi_Pick_Up_Location:chararray,Bridge_Highway_Name:chararray,Bridge_Highway_Direction:chararray,Road_Ramp:chararray,Bridge_Highway_Segment:chararray,Garage_Lot_Name:chararray,Ferry_Direction:chararray,Ferry_Terminal_Name:chararray,Latitude:chararray,Longitude:chararray,Location:chararray);
Noise_Clean = FOREACH  Noise {
    GENERATE Unique_Key,Created_Date,Closed_Date,Agency,Agency_Name,Complaint_Type,Descriptor,Location_Type,Incident_Zip,Incident_Address,Street_Name,Cross_Street_1,Cross_Street_2,Intersection_Street_1,Intersection_Street_2,Address_Type,City,Landmark,Facility_Type,Status,Due_Date,Resolution_Action_Updated_Date,Community_Board,Borough,X_Coordinate,Y_Coordinate,Latitude,Longitude,Location;
}



Street = LOAD 'street_condition.csv' USING PigStorage(',') as (Unique_Key:chararray,Created_Date:chararray,Closed_Date:chararray,Agency:chararray,Agency_Name:chararray,Complaint_Type:chararray,Descriptor:chararray,Location_Type:chararray,Incident_Zip:chararray,Incident_Address:chararray,Street_Name:chararray,Cross_Street_1:chararray,Cross_Street_2:chararray,Intersection_Street_1:chararray,Intersection_Street_2:chararray,Address_Type:chararray,City:chararray,Landmark:chararray,Facility_Type:chararray,Status:chararray,Due_Date:chararray,Resolution_Action_Updated_Date:chararray,Community_Board:chararray,Borough:chararray,X_Coordinate:chararray,Y_Coordinate:chararray,Park_Facility_Name:chararray,Park_Borough:chararray,School_Name:chararray,School_Number:chararray,School_Region:chararray,School_Code:chararray,School_Phone_Number:chararray,School_Address:chararray,School_City:chararray,School_State:chararray,School_Zip:chararray,School_Not_Found:chararray,School_or_Citywide_Complaint:chararray,Vehicle_Type:chararray,Taxi_Company_Borough:chararray,Taxi_Pick_Up_Location:chararray,Bridge_Highway_Name:chararray,Bridge_Highway_Direction:chararray,Road_Ramp:chararray,Bridge_Highway_Segment:chararray,Garage_Lot_Name:chararray,Ferry_Direction:chararray,Ferry_Terminal_Name:chararray,Latitude:chararray,Longitude:chararray,Location:chararray);
Street_Clean = FOREACH  Street {
    GENERATE Unique_Key,Created_Date,Closed_Date,Agency,Agency_Name,Complaint_Type,Descriptor,Location_Type,Incident_Zip,Incident_Address,Street_Name,Cross_Street_1,Cross_Street_2,Intersection_Street_1,Intersection_Street_2,Address_Type,City,Landmark,Facility_Type,Status,Due_Date,Resolution_Action_Updated_Date,Community_Board,Borough,X_Coordinate,Y_Coordinate,Latitude,Longitude,Location;
}



Services = LOAD 'service_requests.csv' USING PigStorage(',') as (Unique_Key:chararray,Created_Date:chararray,Closed_Date:chararray,Agency:chararray,Agency_Name:chararray,Complaint_Type:chararray,Descriptor:chararray,Location_Type:chararray,Incident_Zip:chararray,Incident_Address:chararray,Street_Name:chararray,Cross_Street_1:chararray,Cross_Street_2:chararray,Intersection_Street_1:chararray,Intersection_Street_2:chararray,Address_Type:chararray,City:chararray,Landmark:chararray,Facility_Type:chararray,Status:chararray,Due_Date:chararray,Resolution_Description:chararray,Resolution_Action_Updated_Date:chararray,Community_Board:chararray,Borough:chararray,X_Coordinate:chararray,Y_Coordinate:chararray,Park_Facility_Name:chararray,Park_Borough:chararray,School_Name:chararray,School_Number:chararray,School_Region:chararray,School_Code:chararray,School_Phone_Number:chararray,School_Address:chararray,School_City:chararray,School_State:chararray,School_Zip:chararray,School_Not_Found:chararray,School_or_Citywide_Complaint:chararray,Vehicle_Type:chararray,Taxi_Company_Borough:chararray,Taxi_Pick_Up_Location:chararray,Bridge_Highway_Name:chararray,Bridge_Highway_Direction:chararray,Road_Ramp:chararray,Bridge_Highway_Segment:chararray,Garage_Lot_Name:chararray,Ferry_Direction:chararray,Ferry_Terminal_Name:chararray,Latitude:chararray,Longitude:chararray,Location:chararray);
Services_Clean = FOREACH  Services {
    GENERATE Unique_Key,Created_Date,Closed_Date,Agency,Agency_Name,Complaint_Type,Descriptor,Location_Type,Incident_Zip,Incident_Address,Street_Name,Cross_Street_1,Cross_Street_2,Intersection_Street_1,Intersection_Street_2,Address_Type,City,Landmark,Facility_Type,Status,Due_Date,Resolution_Action_Updated_Date,Community_Board,Borough,X_Coordinate,Y_Coordinate,Latitude,Longitude,Location;
}


X = UNION Noise, Street, Services;
store X into 'union.csv' using PigStorage(',', '-schema');

> hadoop fs -getmerge union.csv ./union.csv
-------------------------------------------------------------------------------------------------------------------------------------


importUnion = LOAD 'union.csv' USING PigStorage(',') as (Unique_Key:chararray,Created_Date:chararray,Closed_Date:chararray,Agency:chararray,Agency_Name:chararray,Complaint_Type:chararray,Descriptor:chararray,Location_Type:chararray,Incident_Zip:chararray,Incident_Address:chararray,Street_Name:chararray,Cross_Street_1:chararray,Cross_Street_2:chararray,Intersection_Street_1:chararray,Intersection_Street_2:chararray,Address_Type:chararray,City:chararray,Landmark:chararray,Facility_Type:chararray,Status:chararray,Due_Date:chararray,Resolution_Action_Updated_Date:chararray,Community_Board:chararray,Borough:chararray,X_Coordinate:chararray,Y_Coordinate:chararray,Park_Facility_Name:chararray,Park_Borough:chararray,School_Name:chararray,School_Number:chararray,School_Region:chararray,School_Code:chararray,School_Phone_Number:chararray,School_Address:chararray,School_City:chararray,School_State:chararray,School_Zip:chararray,School_Not_Found:chararray,School_or_Citywide_Complaint:chararray,Vehicle_Type:chararray,Taxi_Company_Borough:chararray,Taxi_Pick_Up_Location:chararray,Bridge_Highway_Name:chararray,Bridge_Highway_Direction:chararray,Road_Ramp:chararray,Bridge_Highway_Segment:chararray,Garage_Lot_Name:chararray,Ferry_Direction:chararray,Ferry_Terminal_Name:chararray,Latitude:chararray,Longitude:chararray,Location:chararray);

cleanedUnion = FOREACH importUnion GENERATE Unique_Key,Created_Date,Closed_Date,Agency,Agency_Name,Complaint_Type,Descriptor,Location_Type,Incident_Zip,Incident_Address,Street_Name,Cross_Street_1,Cross_Street_2,Intersection_Street_1,Intersection_Street_2,Address_Type,City,Landmark,Facility_Type,Status,Due_Date,Resolution_Action_Updated_Date,Community_Board,Borough,X_Coordinate,Y_Coordinate, Latitude,Longitude,Location;

store cleanedUnion into 'cleanunion' using PigStorage(',', '-schema');

hadoop fs -rm cleanunion/.pig_schema
hadoop fs -getmerge cleanunion ./cleanunion.csv
hadoop fs -put cleanunion.csv
-------------------------------------------------------------------------------------------------------------------------------------
> d_Agency= DISTINCT (FOREACH Noise GENERATE Agency);
> dump d_Agency
(DEP)
(EDC)
(DSNY)
(NYPD)
(3-1-1)
(Agency)

> d_Agency_Name = DISTINCT (FOREACH Noise GENERATE Agency_Name);
> dump(d_Agency_Name)
(NYPD)
(3-1-1)
(Bronx 03)
(Bronx 04)
(Bronx 05)
(Bronx 08)
(Bronx 10)
(Bronx 11)
(Agency Name)
(BCC - Bronx)
(Manhattan 01)
(Manhattan 02)
(Manhattan 03)
(Manhattan 04)
(Manhattan 05)
(Manhattan 06)
(Manhattan 07)
(Manhattan 08)
(Queens East 10)
(Queens East 12)
(Queens West 02)
(Queens West 03)
(Queens West 06)
(BCC - Manhattan)
(3-1-1 Call Center)
(BCC - Queens East)
(BCC - Queens West)
(Brooklyn North 03)
(Brooklyn South 10)
(BCC - Staten Island)
(BCC - Brooklyn North)
(BCC - Brooklyn South)
(New York City Police Department)
(Economic Development Corporation)
(Department of Environmental Protection)

> d_Complaint_Type = DISTINCT (FOREACH Noise GENERATE Complaint_Type);
> dump(d_Complaint_Type)
(Noise)
(Noise - Park)
(Noise Survey)
(Complaint Type)
(Noise - Vehicle)
(Noise - Commercial)
(Noise - Helicopter)
(Noise - Residential)
(Collection Truck Noise)
(Noise - Street/Sidewalk)
(Noise - House of Worship)

> d_Descriptor = DISTINCT (FOREACH Noise GENERATE Descriptor);
> dump d_Descriptor 
(NYPD)
(Other)
("Noise)
(Descriptor)
(Loud Talking)
(Engine Idling)
(Car/Truck Horn)
(News Gathering)
(Car/Truck Music)
(Loud Television)
(Banging/Pounding)
(Loud Music/Party)
("Noise: Boat(Engine)
(Noise: Alarms (NR3))
(Noise: Vehicle (NR2))
(People Created Noise)
(21 Collection Truck Noise)
(Noise: Jack Hammering (NC2))
(Noise: Manufacturing Noise (NK1))
(Horn Honking Sign Requested (NR9))
(Noise:  lawn care equipment (NCL))
(Noise: Private Carting Noise (NQ1))
(Noise: Construction Equipment (NC1))
("Noise: Air Condition/Ventilation Equip)
(Noise: Construction Before/After Hours (NM1))
(Noise: Other Noise Sources (Use Comments) (NZZ))
(Noise: air condition/ventilation equipment (NV1))
(Noise: Loud Music/Daytime (Mark Date And Time) (NN1))
(Noise: Loud Music/Nighttime(Mark Date And Time) (NP1))

> d_Location_Type = DISTINCT (FOREACH Noise GENERATE Location_Type);
> dump d_Location_Type 
(Home)
(Music)
(Sidewalk)
(Above Address)
(Location Type)
(Bar/Restaurant)
(Park/Playground)
(Street/Sidewalk)
(House of Worship)
(Store/Commercial)
( Commercial (NJ2)")
( Barking Dog (NR5)")
( Residential (NJ1)")
(Club/Bar/Restaurant)
( Other Animals (NR6)")
( Ice Cream Truck (NR4)")
(Residential Building/House)
()

> d_Incident_Zip = DISTINCT (FOREACH Noise GENERATE Incident_Zip);
> dump d_Incident_Zip 
(00083)
(10000)
(10001)
(10002)
(10003)
(10004)
(10005)
(10006)
(10007)
(10009)
(10010)
(10011)
(10012)
(10013)
(10014)
(10016)
(10017)
(10018)
(10019)
(10020)
(10021)
(10022)
(10023)
(10024)
(10025)
(10026)
(10027)
(10028)
(10029)
(10030)
(10031)
(10032)
(10033)
(10034)
(10035)
(10036)
(10037)
(10038)
(10039)
(10040)
(10041)
(10044)
(10048)
(10065)
(10069)
(10075)
(10103)
(10107)
(10111)
(10112)
(10119)
(10123)
(10128)
(10129)
(10153)
(10162)
(10280)
(10281)
(10282)
(10301)
(10302)
(10303)
(10304)
(10305)
(10306)
(10307)
(10308)
(10309)
(10310)
(10312)
(10314)
(10451)
(10452)
(10453)
(10454)
(10455)
(10456)
(10457)
(10458)
(10459)
(10460)
(10461)
(10462)
(10463)
(10464)
(10465)
(10466)
(10467)
(10468)
(10469)
(10470)
(10471)
(10472)
(10473)
(10474)
(10475)
(10803)
(11001)
(11004)
(11005)
(11040)
(11101)
(11102)
(11103)
(11104)
(11105)
(11106)
(11109)
(11201)
(11203)
(11204)
(11205)
(11206)
(11207)
(11208)
(11209)
(11210)
(11211)
(11212)
(11213)
(11214)
(11215)
(11216)
(11217)
(11218)
(11219)
(11220)
(11221)
(11222)
(11223)
(11224)
(11225)
(11226)
(11228)
(11229)
(11230)
(11231)
(11232)
(11233)
(11234)
(11235)
(11236)
(11237)
(11238)
(11239)
(11241)
(11242)
(11249)
(11354)
(11355)
(11356)
(11357)
(11358)
(11360)
(11361)
(11362)
(11363)
(11364)
(11365)
(11366)
(11367)
(11368)
(11369)
(11370)
(11372)
(11373)
(11374)
(11375)
(11377)
(11378)
(11379)
(11385)
(11411)
(11412)
(11413)
(11414)
(11415)
(11416)
(11417)
(11418)
(11419)
(11420)
(11421)
(11422)
(11423)
(11426)
(11427)
(11428)
(11429)
(11430)
(11432)
(11433)
(11434)
(11435)
(11436)
(11691)
(11692)
(11693)
(11694)
(11697)
(Etc) (NR10)")
(Incident Zip)
()

-------------------------------------------------------------------------------------------------------------------------------------
REGISTER piggybank.jar
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();

A =  LOAD 'data/complaints.xml' using org.apache.pig.piggybank.storage.XMLLoader('row') as (x:chararray);

B = FOREACH A GENERATE XPath(x, 'row/created_date');

STORE B INTO 'output' using PigStorage('\t');

sed -e "s/<\/row>/&\n/g" < complaints.xml >formatted_complaints.xml