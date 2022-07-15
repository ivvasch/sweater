delete from user_role;
delete from usr;

insert into usr(id, active, password, username)
values (1, true, '$2a$08$Ty5X8.u4leGyCP.41/DDSuKY8g46D7mXsJszdjs9Afjvx81Hxz9Pq', 'user22'),
       (2, true, '$2a$08$Ty5X8.u4leGyCP.41/DDSuKY8g46D7mXsJszdjs9Afjvx81Hxz9Pq', 'mike');

insert into user_role (user_id, role_set)
values (1, 'ADMIN'),
       (1, 'USER'),
       (2, 'USER');
