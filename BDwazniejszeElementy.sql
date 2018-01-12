-- Tabele zawierające klucze główne i obce -------------------------------------------------------
DROP TABLE IF EXISTS level;
CREATE TABLE level (
  id INT NOT NULL AUTO_INCREMENT,
  sign VARCHAR(5) NOT NULL ,
  PRIMARY KEY (id)
);
DROP TABLE IF EXISTS type;
CREATE TABLE type (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50),
  PRIMARY KEY (id)
);
DROP TABLE IF EXISTS course;
CREATE TABLE course(
  id INT NOT NULL AUTO_INCREMENT,
  type INT NOT NULL ,
  level INT NOT NULL ,
  description VARCHAR(100),
  PRIMARY KEY (id),
    FOREIGN KEY (type) REFERENCES type(id),
    FOREIGN KEY (level) REFERENCES level(id)
);
-- classes
DROP TABLE IF EXISTS weekday;
CREATE TABLE weekday(
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50),
  PRIMARY KEY (id)
);
DROP TABLE IF EXISTS class_weekday;
CREATE TABLE class_weekday(
  class_id INT NOT NULL AUTO_INCREMENT,
  weekday_id INT NOT NULL ,
  hours VARCHAR(20) NOT NULL ,
  PRIMARY KEY (class_id),
  FOREIGN KEY (weekday_id) REFERENCES weekday(id)
);
DROP TABLE IF EXISTS class_student;
CREATE TABLE class_student (
  id INT NOT NULL AUTO_INCREMENT,
  class_id INT NOT NULL ,
  student_id INT NOT NULL ,
  PRIMARY KEY (id),
  FOREIGN KEY (class_id) REFERENCES class(id)
  -- FOREIGN KEY (student_id) REFERENCES student(id)
);
DROP TABLE IF EXISTS class;
CREATE TABLE class (
  id INT NOT NULL AUTO_INCREMENT,
  name varchar(30),
  start_date DATE NOT NULL ,
  end_date DATE NOT NULL ,
  price DECIMAL(7,2) NOT NULL ,
  teacher_id INT NOT NULL ,
  course_id INT NOT NULL ,
  max_participants INT NOT NULL ,
  PRIMARY KEY (id),
  FOREIGN KEY (course_id) REFERENCES course(id)
  -- FOREIGN KEY (teacher_id) REFERENCES teacher(id)
);

-- Procedura do generowania randomowych studentów ----------------------------------------------------------------
DROP PROCEDURE IF EXISTS randomStudents;
DELIMITER //
CREATE  PROCEDURE randomStudents(IN n INT)
  BEGIN

    DECLARE cityT VARCHAR(50);
    DECLARE streetT VARCHAR(50);
    DECLARE nameT varchar(30);
    DECLARE lastT VARCHAR(30);
    DECLARE emailAdress varchar(50);
    DECLARE domenaT VARCHAR(20);
    DECLARE phoneT VARCHAR(15);
    DECLARE i INT;
    set i =0;

    WHILE i < n DO

      set cityT = (SELECT name from MiastaP ORDER BY RAND() LIMIT 1);

      set streetT = (SELECT ulica from UliceP ORDER BY RAND() LIMIT 1);
      set streetT = concat(streetT, " ", FLOOR(RAND()*(100-1+1)+1));

      set nameT = (SELECT imie FROM imieP ORDER BY RAND() LIMIT 1);
      set lastT = (SELECT nazwisko FROM nazwiskaP ORDER BY RAND() LIMIT 1);

      set domenaT = (SELECT domena FROM Pemail ORDER BY RAND() LIMIT 1);
      set emailAdress = concat(nameT, FLOOR(RAND()*(100-1+1)+1), lastT, '@', domenaT);

      SET phoneT = FLOOR(RAND()*(999999999-100000000+1)+100000000);

      INSERT INTO student(city, street, first_name, last_name, email, phone) VALUES (cityT, streetT, nameT, lastT, emailAdress, phoneT);

      set i = i +1;
    END WHILE ;
  END;
//
DELIMITER ;


-- Nie pozwala na zapisanie studenta do kursu, w którym już uczestniczy -----------------------------------------
ALTER TABLE class_student
    ADD CONSTRAINT unique_student_in_class UNIQUE
  (
    class_id, student_id
  );

-- nie pozwala zapisać więcej swtudentów na dany kurs niż w liczba podana w polu max_participants ---------------------
DROP TRIGGER always_below_max_participants;
DELIMITER //
CREATE TRIGGER always_below_max_participants
BEFORE INSERT ON class_student
FOR EACH ROW
BEGIN
  DECLARE curr_num_of_participants INT;
  DECLARE max_participants INT;

  SET curr_num_of_participants = (SELECT COUNT(*) FROM class_student WHERE class_id=NEW.class_id);
  SET max_participants = (SELECT class.max_participants FROM class WHERE id=NEW.class_id);

  IF curr_num_of_participants >= max_participants
  THEN
   SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Warning: you cant add more students';
  END IF;

END;
//
    DELIMITER ;

-- wybiera dostępne kursy
ALTER VIEW show_available_classes AS
SELECT
  c.id,
  c.name,
  start_date,
  end_date,
  price,
  t.id as teacher_id,
  t.first_name,
  t.last_name,
  w.name AS day,
  cw.hours,
  l.sign AS level,
  COUNT(cs.student_id) AS n,
  c.max_participants
FROM class c
  JOIN class_student cs ON c.id = cs.class_id
  JOIN teacher t ON c.teacher_id = t.id
  JOIN class_weekday cw ON c.id = cw.class_id
  JOIN weekday w ON cw.weekday_id = w.id
  JOIN course c2 ON c.course_id = c2.id
  JOIN level l ON c2.level = l.id
 GROUP BY cs.class_id;

-- wybiera studentów dla wszystkich kursów
ALTER VIEW show_student_classes AS
SELECT
  cs.student_id,
  c.id,
  c.name,
  start_date,
  end_date,
  price,
  teacher.first_name,
  teacher.last_name,
  w.name AS day,
  cw.hours
FROM class_student cs
  JOIN class c ON c.id = cs.class_id
  JOIN teacher ON teacher_id = teacher.id
  JOIN class_weekday cw ON c.id = cw.class_id
  JOIN weekday w ON cw.weekday_id = w.id;

ALTER VIEW show_students_in_class AS
  SELECT
    class_id,
    student_id,
    s.first_name,
    s.last_name,
    s.phone
  FROM class_student
    JOIN student s ON class_student.student_id = s.id;







