create table Trains(
TrainID int ,
TrainName varchar(50),
TrainType varchar(50),
TotalSeats Int);

Create table Routes(
RouteID int ,
StartStation varchar(50),
EndStation varchar(50),
Distance int);

Create table Schedules(
ScheduleID int ,
TrainId int,
RouteId int,
DepartureTime DateTime,
ArrivalTime DateTime);
   

create table Passengers(
PassengerID int ,
FirstName varchar(50),
LastName varchar(50),
Age int,
Email varchar(118));

create table Bookings(
BookingID int ,
PassengerID int,
ScheduleID int,
BookingDate Date,
SeatNumber int);



 insert into Trains(TrainID,TrainName,TrainType,TotalSeats)values
    -> (1,'Rajdhani Express','Express',300),
    -> (2,'Tejas Express','Superfast',200),
    -> (3,'Shatabdi Express','Passenger',250),
    -> (4,'Duronto Express','Superfast',150),
    -> (5,'Garib Rath','Express',350);


 insert into Routes(RouteID,StartStation,EndStation,Distance)values
    -> (1,'Delhi','Mumbai',1400),
    -> (2,'Kolkata','Chennai',1650),
    -> (3,'Jaipur','Ahmedabad',650);

 insert into schedules (ScheduleID,TrainID,RouteID,DepartureTime,ArrivalTime) values
    -> (1,1,1,'2024-10-20 9:00:00','2024-10-20 21:00:00'),
    -> (2,2,2,'2024-10-21 8:30:00','2024-10-21 22:00:00'),
    -> (3,3,3,'2024-10-22 6:00:00','2024-10-22 14:00:00'),
    -> (4,4,1,'2024-10-23 10:00:00','2024-10-23 22:00:00'),
    -> (5,5,2,'2024-10-24 7:00:00','2024-10-24 21:00:00');
Query OK, 5 rows affected (0.01 sec)

insert into Passengers(PassengerID,FirstName,LastName,Age,Email)values
    -> (1,'Rajesh','Sharma',45,'rajesh.sharma@specialforce.com'),
    -> (2,'Priya','Mehra',32,'priya.mehra@specialforce.com'),
    -> (3,'Ankit','Verma',29,'ankit.verma@specialforce.com'),
    -> (4,'Kavita','Gupta',40,'kavita.gupta@specialforce.com'),
    -> (5,'Arun','Patel',50,'arun.patel@specialforce.com'),
    -> (6,'Neha','Joshi',27,'neha.joshi@specialforce.com'),
    -> (7,'Suresh','Nair',33,'suresh.nair@specialforce.com'),
    -> (8,'Pooja','Reddy',36,'pooja.reddy@specialforce.com'),
    -> (9,'Vikram','Singh',42,'vikram.singh@specialforce.com'),
    -> (10,'Aarti','Desai',25,'aarti.desai@specialforce.com');

 insert into Bookings(BookingID,PassengerID,ScheduleID,BookingDate,SeatNumber) values
    -> (1,1,1,'2024-10-10',12),
    -> (2,2,1,'2024-10-11',34),
    -> (3,3,2,'2024-10-12',56),
    -> (4,4,3,'2024-10-13',18),
    -> (5,5,4,'2024-10-14',22);

ALTER TABLE Trains
ADD CONSTRAINT PK_Trains PRIMARY KEY (TrainID);

ALTER TABLE Routes
ADD CONSTRAINT PK_Routes PRIMARY KEY (RouteID);

ALTER TABLE Schedules
ADD CONSTRAINT PK_Schedules PRIMARY KEY (ScheduleID);

ALTER TABLE Passengers
ADD CONSTRAINT PK_Passengers PRIMARY KEY (PassengerID);

ALTER TABLE Bookings
ADD CONSTRAINT PK_Bookings PRIMARY KEY (BookingID);


ALTER TABLE Schedules
ADD CONSTRAINT FK_Schedules_Trains FOREIGN KEY (TrainID)
REFERENCES Trains(TrainID);

ALTER TABLE Schedules
ADD CONSTRAINT FK_Schedules_Routes FOREIGN KEY (RouteID)
REFERENCES Routes(RouteID);

ALTER TABLE Bookings
ADD CONSTRAINT FK_Bookings_Passengers FOREIGN KEY (PassengerID)
REFERENCES Passengers(PassengerID);

ALTER TABLE Bookings
ADD CONSTRAINT FK_Bookings_Schedules FOREIGN KEY (ScheduleID)
REFERENCES Schedules(ScheduleID);

SELECT T.TrainName, R.StartStation, R.EndStation, S.DepartureTime, S.ArrivalTime
    -> FROM Trains T
    -> INNER JOIN Schedules S ON T.TrainID = S.TrainID
    -> INNER JOIN Routes R ON S.RouteID = R.RouteID;

select trains.TrainID,trains.TrainName from trains
    -> left join schedules on trains.trainid = schedules.trainid
    -> left join bookings on bookings.scheduleid=schedules.scheduleid
    -> where bookings.scheduleid is null;

 select concat(firstname," ",lastname) as 'Passangers Name',Bookings.PassengerID,Passengers.PassengerID ,Schedules.ScheduleID,Routes.RouteID
  from Passengers
 right join Bookings on Bookings.PassengerID=Passengers.PassengerID
 right join Schedules on Bookings.ScheduleID=Schedules.ScheduleID
 right join Routes on Schedules.RouteID=Routes.RouteID
 where Routes.Distance in (
 select Distance from Routes
 where Distance>500)
order by PassengerID;

 select s.ScheduleID,s.TrainID,s.RouteID,s.DepartureTime,s.ArrivalTime from Schedules s
    -> left join Bookings b on s.ScheduleID=b.ScheduleID;

select routes.routeid,
    -> (select count(distinct bookings.passengerid)from bookings
    -> join schedules on bookings.scheduleid=schedules.scheduleid
    -> where schedules.routeid=routes.routeID) as 'Total Passengers' from routes;


select Trains.TrainName, (select avg(totalpassangers) from 
(select Schedules.trainid,count(Bookings.passengerid) as totalpassangers
from schedules
join bookings on Schedules.Scheduleid=bookings.Scheduleid
group by Schedules.trainid)as PassengerCountquerry )
as 'Average Passengers Booked' from trains;

select b.BookingID, b.PassengerID, b.ScheduleID, b.BookingDate, b.SeatNumber from bookings b
join passengers p on b.PassengerID=p.PassengerID
where p.PassengerID in (
select p.age from passengers
where p.age>60);

select b.BookingID, b.PassengerID, b.ScheduleID, b.BookingDate, b.SeatNumber from bookings b
join passengers p on b.PassengerID=p.PassengerID
where p.PassengerID in (
select p.PassengerID from passengers
where p.age>40);


alter table Schedules
add column AvailableSeats int;

update Schedules s
join Trains t on s.TrainID = t.TrainID
set s.AvailableSeats = t.TotalSeats;


DELIMITER //
create procedure UpdateAvailableSeatsFromBookings(in input_ScheduleID int)
begin
declare totalSeats int;
declare bookedSeats int;
select t.TotalSeats into totalSeats
from Trains t
join Schedules s on t.TrainID = s.TrainID
where s.ScheduleID = input_ScheduleID;
select count(*) into bookedSeats
from Bookings
where ScheduleID = input_ScheduleID;
update Schedules
set AvailableSeats = totalSeats - bookedSeats
where ScheduleID = input_ScheduleID;
end //
DELIMITER ;

delimiter //
create function gettraveltimehours(schedule_id int)
returns decimal(5,2)
deterministic
begin
declare traveltime decimal(5,2);
select timestampdiff(minute, departuretime, arrivaltime) / 60.0
into traveltime
from schedules
where scheduleid = schedule_id;
return traveltime;
end //
delimiter ;

create view PassengerBookingsView as 
select * from Passengers p 
join Bookings b on b.PassengerID= p.PassengerID
join Schedules s on s.ScheduleID= b.ScheduleID
join trains t on t.TrainID= s.TrainID
order by p.PassengerID;

create view passengerbookingsview as
select 
    p.passengerid as passenger_id,
    p.firstname,
    p.lastname,
    p.age,
    p.email,
    b.bookingid,
    b.bookingdate,
    b.seatnumber,
    s.scheduleid,
    s.departuretime,
    s.arrivaltime,
    t.trainid,
    t.trainname,
    t.traintype,
    t.totalseats
from passengers p
join bookings b on b.passengerid = p.passengerid
join schedules s on s.scheduleid = b.scheduleid
join trains t on t.trainid = s.trainid
order by p.passengerid;

create index idx_bookingdate
on bookings (bookingdate);
select * from bookings where bookingdate = '2024-10-10';

create temporary table temp_schedule_2024_10_21 as
select *
from schedules
where date(departuretime) = '2024-10-21';

===================================================================================

delimiter //
create procedure show_frequent_passengers()
begin
    declare done int default false;
    declare pass_id int;
    declare pass_cursor cursor for
        select passengerid
        from bookings
        group by passengerid
        having count(*) > 5;
    declare continue handler for not found set done = true;
    open pass_cursor;
    read_loop: loop
        fetch pass_cursor into pass_id;
        if done then
            leave read_loop;
        end if;
        select pass_id as passenger_with_more_than_5_bookings;
    end loop;
    close pass_cursor;
end //
delimiter ;
call show_frequent_passengers();


start transaction;

update trains set totalseats = totalseats - 1
where trainid = 1;

savepoint before_delete;

delete from bookings
where bookingid = 10;

rollback to before_delete;  

commit;

delimiter //
create trigger update_avaliableseats_after_booking
after insert on bookings
for each row
begin
    update trains t
    join schedules s on t.trainid = s.trainid
    set t.availableseats = t.availableseats - 1
    where s.scheduleid = new.scheduleid;
end //
delimiter ;

delimiter //
create trigger assign_seat_before_insert
before insert on bookings
for each row
begin
    declare next_seat int;
    select ifnull(max(seatnumber), 0) + 1 into next_seat
    from bookings
    where scheduleid = new.scheduleid;
    set new.seatnumber = next_seat;
end //
delimiter ;

alter table schedules add available_seats int;

update schedules s
join trains t on s.trainid = t.trainid
set s.available_seats = t.totalseats;

-- Now the trigger
delimiter //

create trigger update_seats_after_booking
after insert on bookings
for each row
begin
    update schedules
    set available_seats = available_seats - 1
    where scheduleid = new.scheduleid;
end //

delimiter ;


select p.firstname, p.lastname
from passengers p
join bookings b on p.passengerid = b.passengerid
join schedules s on b.scheduleid = s.scheduleid
where s.routeid = 1

union

select p.firstname, p.lastname
from passengers p
join bookings b on p.passengerid = b.passengerid
join schedules s on b.scheduleid = s.scheduleid
where s.routeid = 2;


select * from bookings where bookingdate = '2024-10-10'
union all
select * from bookings where bookingdate = '2024-10-11';


create table oldpassengers like passengers;

create table archivedbookings like bookings;
insert into archivedbookings
select * from bookings;


create table employeeprojects (
    empid int,
    projectid varchar(10),
    primary key (empid, projectid));
insert into employeeprojects (empid, projectid) values
(101, 'P01'),
(102, 'P02'),
(103, 'P03'),
(104, 'P01'),
(105, 'P03');

