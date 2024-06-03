-- Statements inserting tuples --
insert into Musician values ('1234567890','Alice','North Ryde','0404123456');
insert into Musician values ('9876543210','Bob','Circular Quay','0404654321');
insert into Musician values ('1231231230','Charlie','Parramatta','0426802468');
insert into Musician values ('1234543210','David','North Ryde','0404123000');

insert into Album values (1001,'Beat it','2017-01-01','cd','1234567890');
insert into Album values (1002,'Purpose','2017-04-01','dvd','9876543210');
insert into Album values (1003,'Run away','2016-01-01','cd','9876543210');
insert into Album values (1004,'Summer of 69','2015-01-01','cd','1231231230');

insert into Song values (2001,'A song','Composer 1','Author 1',1001);
insert into Song values (2002,'Some song','Composer 1','Author 2',1002);
insert into Song values (2003,'Other song','Composer 2','Author 1',1002);
insert into Song values (2004,'Another song','Composer 3','Author 2',1003);

insert into Instrument values (3001,'Violin','C-Sharp');
insert into Instrument values (3002, 'Piano', 'D-Minor');
insert into Instrument values (3003, 'Guitar', 'B-Flat');

insert into Performs values ('1234567890', 2001);
insert into Performs values ('1231231230', 2002);
insert into Performs values ('1234543210', 2003);
insert into Performs values ('1234543210', 2004);

insert into Plays values ('9876543210', 3001, 10);
insert into Plays values ('9876543210', 3003, 20);
insert into Plays values ('1234567890', 3002, 2);
insert into Plays values ('1231231230', 3001, 8);

-- Task 5 SQL Statements -- 
SELECT ssn, name, phone_no FROM Musician WHERE address = 'North Ryde';
SELECT songid, song_title from Song WHERE Composer_name = 'Composer 1';
SELECT * FROM Instrument WHERE musical_key = 'C-Sharp';
SELECT album_title FROM Album WHERE format = 'cd';

SELECT album_identifier FROM Album WHERE copyright_date between '2017-01-01' and '2017-12-31'; 
SELECT album_identifier FROM Album WHERE copyright_date >= '2017-01-01' and copyright_date <='2017-12-31'; 
SELECT album_identifier FROM Album WHERE year(Copyright_date) = 2017;

