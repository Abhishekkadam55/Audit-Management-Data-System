create schema Audit_score;

# hrdata has some unwanted records, so will drop those records and keep where Empstatus is active
# Using delete function remove records
delete from hrdata
where Empstatus in ("Terminated for Cause","Voluntarily Terminated","Future Start");

# From above all the unwanted records are deleted 

# Cal No. of Active employee in Organization
# use count() function
select count(EmpID) as Total_Employee from hrdata;

# Gender wise Employee in Organization
# Use count() and group by () function to group then F and M
Select Gender,count(EmpID) as Count from hrdata
group by Gender;

# Employee by Citizen 
Select CitizenDesc,Count(EmpID) from hrdata
group by CitizenDesc;

# Employrr by RaceDese
Select RaceDesc,Count(EmpID) as count from hrdata
group by RaceDesc;

# Employee by RecruitmentSource
Select RecruitmentSource,Count(EmpID) as count from hrdata
group by RecruitmentSource;

# Import Department data
#Show Manager details using distinct function
select distinct ManagerName, Department,ManagerID from departmentdata;

# Join HR Data To Department Data by matching values by using Inner Join 
# Creating a view

create view HRDepData
as select * from hrdata
inner join departmentdata using (EmpID);

# Employee department details
select Employee_Name, Department, Position, ManagerName from hrdepdata;

# Employee in each Department
select Department, count(Position) from hrdepdata
group by Department;

# Import Employee Audit Score by importing table

# Join hrdepdata to empscore and create view using inner join to match records

create view Hrdeptscore
as  
select * from hrdepdata
inner join empscore using (Employee_Name);

# Employee score
# Use Avg() for average of all five col, round() to round value upto Two deciaml 
# order by in decreasing order to show highest at top 
Create view EmployeeHighestscore
as
select Employee_Name, round(avg(Seiri_Sort+Seiton_Set_in_Order+Seiso_Shine+Seiketsu_Standardize+Shitsuke_Sustain),2) as Score from hrdeptscore
group by Employee_Name
order by Score DESC;

# Department Highest score
Create view Departmentscore
as
select Department, round(avg(Seiri_Sort+Seiton_Set_in_Order+Seiso_Shine+Seiketsu_Standardize+Shitsuke_Sustain),2) as Score_of_25 from hrdeptscore
group by Department;






  