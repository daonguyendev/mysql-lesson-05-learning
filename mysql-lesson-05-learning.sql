/*create database or schema*/
create database if not exists student_management;/*way 1*/
create schema if not exists student_management;/*way 2*/

/*drop database or schema if incorrect*/
drop database if exists student_management;/*way 1*/
drop schema if exists student_management;/*way 2*/

/*create student table include fields: id, full_name, gender, age, city, weight*/
create table if not exists student_management.student (
	id int not null auto_increment primary key,
    full_name varchar(50) not null,
    gender varchar(3),
    age int,
    city varchar(20),
    weight float
);

/*set character as utf8mb4 for student_management database*/
alter database student_management character set utf8mb4 collate utf8mb4_general_ci;

/*add 7 rows in student table*/
insert into student_management.student (full_name, gender, age, city, weight) values 
('Nguyen Thanh Nhan', 'Nam', 19, 'Can Tho', 56.5674), 
('Pham Thu Huong', 'Nu', 20, 'Vinh Long', 72.456),
('Nguyen Nhu Ngoc', 'Nu', 20, 'Soc Trang', 85.387),
('Bui Thanh Bao', 'Nam', 19, 'Soc Trang', 49.3),
('Le My Nhan', 'Nu', 22, 'Can Tho', 62.963),
('Tan Thuc Bao', 'Nam', 35, 'An Giang', 55.5678),
('Trinh Giao Kim', 'Nam', 44, 'Bac Lieu', 67.34);

/*select values in student table*/
select * from student_management.student;
select id, full_name from student_management.student where id = 3 and id = 4; /*incorrect statement*/
select id, full_name from student_management.student where id = 3 or id = 4; /*correct statement*/
select id, full_name from student_management.student where id in (3, 4); /*short correct statement*/

/*learning mysql lesson 05 - part 02*/
-- get students have gender is man
select * from student where gender = 'Nam';
select * from student where gender not in ('Nu');

-- get students with gender is man and order asc by age
select * from student where gender = 'Nam' order by age asc;

-- get full name, age of students at Can Tho or Vinh Long city
select full_name, age from student where city = 'Can Tho' or city = 'Vinh Long';
select full_name, age from student where city in ('Can Tho', 'Vinh Long');

-- get student have gender is woman and age larger than 21
select * from student where gender = 'Nu' and age > 21;
select * from student where gender not in ('Nam') and age > 21;

-- get students have weight larger than 50 and order desc by weight
select * from student where weight > 50 order by weight desc;

-- get 2 first students have gender is woman
select * from student where gender = 'Nu' order by id asc limit 0, 2;

-- calculate average age of students
select avg (age) from student;
select avg (age) as average_age from student;

-- count number of students
select count(*) from student;

-- count number of students with gender is woman
select count(*) from student where gender = 'Nu';

-- get students have max/min age
select max(age) from student where gender = 'Nu';
select min(age) from student where gender = 'Nu';

-- get total age of students
select sum(age) from student where gender = 'Nu';

-- get total weight is rounded to 2 decimal number
select round(sum(weight), 2) from student;

-- get students with full name, weight is rounded to 2 decimal number
select full_name, round(weight, 2) from student;

-- create product_management database
create database if not exists product_management;

-- create category table include: 
-- id (primary key) int auto increment, category name not null, description can be null
create table category (
	id int not null auto_increment primary key,
    name varchar(20) not null,
    description varchar(50)
);

insert into category(name, description) values
('mobile', 'mobile category'),
('laptop', 'laptop category');

select * from category;

-- create product table include: id primary key, product name not null, description can be null, price not null
create table product (
	id int primary key not null auto_increment,
    name varchar(20) not null,
    description varchar(50),
    price float
);

insert into product (id, name, description, price) values
(1, 'Nokia 1234', 'This is Nokia 1234', 12.3),
(2, 'Laptop Dell', 'This is Laptop Dell', 23.4),
(3, 'Samsung Galaxy', 'This is Samsung Galaxy', 15.6);

-- * Note: should be add not null at field will be set foreign key to avoid mismatch data in the system.
alter table product add category_id int not null default (1);

select * from product;

update product set category_id = 2 where id = 2;

-- get products in mobile category
select * from product where category_id = 1;

-- add foreign key for product table on category_id field
alter table product add constraint fk_category foreign key (category_id) references category(id);

-- get products in mobile category
select * from product p join category c on p.category_id = c.id where c.id = 1;

-- in case we create product table with constraint foreign key
create table product (
	id int primary key not null auto_increment,
    name varchar(20) not null,
    description varchar(50),
    price float,
    category_id int not null default (1),
    constraint fk_category_id foreign key (category_id) references category(id)
);

select * from product;


