insert into usr(id, active, username, password) values (3, true, 'admin', 123);

insert into user_role(user_id, role_set) values (3, 'USER'), (3, 'ADMIN');