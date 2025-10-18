/*You are tasked with designing a database for a university learning management system. The system should allow professors to create courses,
  upload assignments, and grade students. Each student can enroll in multiple courses,
  and each course can have multiple professors and many students. Assignments can have multiple submissions,
  each containing one or more files. Students can also participate in course discussions by creating posts, adding comments, and replying to comments. Reactions (like, dislike, etc.)
  can be given to any post, comment, or reply.
  Additionally, professors can issue plagiarism reports on student submissions.*/

CREATE database LMS;

use LMS;

create table users(
    id int primary key auto_increment,
    name varchar(100),
    age int,
    gender varchar(10),
    email varchar(100),
    password varchar(100)
);

create table students(
    id int primary key auto_increment,
    user_id int not null ,
    foreign key (user_id) references users(id)
);
create table professors(
    id int primary key auto_increment,
    user_id int not null,
    name varchar(100),
    age int,
    gender varchar(10),
    email varchar(100),
    password varchar(100),
    foreign key (user_id) references users(id)
);

create table courses(
    id int primary key auto_increment,
    name varchar(100),
    professor_id int not null,
    foreign key (professor_id) references professors(id)

);
create table enrollments(
    id int auto_increment primary key,
    student_id int not null,
    course_id int not null,
    foreign key (student_id) references students(id),
    foreign key (course_id) references courses(id)
);

create table professor_courses(
       id int primary key auto_increment,
       professor_id int not null,
       course_id int not null,
       foreign key (professor_id) references professors(id),
       foreign key (course_id) references courses(id)
);

create table assignments(
    id int primary key auto_increment,
    name varchar(100),
    course_id int not null,
    foreign key (course_id) references courses(id)
);
create table submissions(
    id int primary key auto_increment,
    assignment_id int not null,
    student_id int not null,
    submission_date datetime,
    foreign key (assignment_id) references assignments(id),
    foreign key (student_id) references students(id)
);

create table files(
    id int primary key auto_increment,
    student_id int not null,
    file_path varchar(255),
    foreign key (student_id) references students(id)
);

create table files_submissions(
    id int primary key auto_increment,
    file_id int not null,
    submission_id int not null,
    foreign key (file_id) references files(id),
    foreign key (submission_id) references submissions(id)
);
