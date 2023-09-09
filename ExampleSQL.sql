--Найдите учеников и все группы, в которых преподает учитель с почтой
SELECT group_student.* From group_student
inner join teacher
on group_student.group_id = teacher.group_id
WHERE teacher.email = 'blanda.jamil@yahoo.com'
  
--Выведите уровень ученика с почтой gpagac@jacobs.com.
SELECT level From student inner join users 
on users.user_id = student.user_id 
WHERE user_email = 'gpagac@jacobs.com'

--Выведите уникальные названия предметов, которые изучает ученик c user_id=11300 (таблицы user и subject).
SELECT distinct subject_title From subject inner join users 
on users.subject_id = subject.subject_id
WHERE users.user_id = 11300

--Выведите уникальные уровни учеников, которые занимаются в группе с id = 10.
SELECT distinct level From student inner join group_student
on group_student.user_id = student.user_id
WHERE group_student.group_id = 10


CREATE TABLE Positions ( 
  id_check  INTEGER,
	id_pos INTEGER,
	art varchar(255),
	quantity INTEGER
);

INSERT INTO Positions (id_check, id_pos, art, quantity)
VALUES
(1, 1, 'A1',1),
(1, 2, 'A4',3),
(1, 3, 'A2',2),
(1, 4, 'A10',1),
(1, 5, 'A8',4),
(2, 1, 'A5',1),
(2, 2, 'A7',1),
(2, 3, 'A3',2),
(3, 1, 'A2',1),
(3, 2, 'A9',1),
(3, 3, 'A5',2),
(3, 4, 'A6',1),
(3, 5, 'A3',3),
(4, 1, 'A1',3),
(4, 2, 'A2',1),
(5, 1, 'A2',1),
(5, 2, 'A8',5),
(5, 3, 'A3',1),
(5, 4, 'A4',1),
(5, 5, 'A5',1);

CREATE TABLE Products ( 
  art varchar(255),
	product varchar(255),
	category varchar(255)
);

INSERT INTO Products (art, product, category)
VALUES
('A1', 'кросовки', 'обувь'),
('A2', 'кеды', 'обувь'),
('A3', 'сланцы', 'обувь'),
('A4', 'куртка', 'одежда'),
('A5', 'ветровка', 'одежда'),
('A6', 'шорты', 'одежда'),
('A7', 'палатка', 'туризм'),
('A8', 'коврик', 'туризм'),
('A9', 'спальник', 'туризм'),
('A10', 'рюкзак', 'туризм'),
('A11', 'туфли', 'обувь'),
('A12', 'солнечные очки', 'аксессуары');

--Выведите названия уникальных категорий, которые были куплены в чеке с id = 3.
SELECT distinct category from Products
inner join Positions
on Positions.art = Products.art
WHERE Positions.id_check = 3

--Выведите артикулы продуктов, которые не покупали (т. е. они не встречаются ни в одном чеке).
SELECT distinct Products.art from Products
left join Positions
on Positions.art = Products.art
where Positions.art is null

--Посчитайте количество чеков, в которых куплено больше двух пар одинаковой обуви.
SELECT count (*) from positions
inner join Products
on Positions.art = Products.art
where Positions.quantity > 2 and Products.category = 'обувь'

--Посчитайте количество чеков, в которых куплено больше двух позиций любой одежды.
SELECT distinct P1.id_check from positions as p1
where (select  sum (p2.quantity) from positions as p2 inner join Products
on P2.art = Products.art where p2.id_check = p1.id_check and Products.category = 'одежда') > 2
