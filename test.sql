create table user
(
    id         int not null,
    first_name varchar(50)        not null,
    last_name  varchar(50)        not null,
    zip_code   int,
    constraint pk_user_id primary key (id)
);

insert into user
values (1, 'john', 'doe', 67890),
       (2, 'jane', 'smith', 54321),
       (3, 'bob', 'johnson', 98765),
       (4, 'alice', 'williams', 67890),
       (5, 'charlie', 'brown', 54321),
       (6, 'eva', 'davis', 54321),
       (7, 'frank', 'miller', 67890),
       (8, 'grace', 'anderson', 54321),
       (9, 'henry', 'jones', 54321),
       (10, 'ivy', 'taylor', 54321);

create table address
(
    id int not null,
    details json not null
);

insert into address
values  (1, '{"street": "456 Elm St","city": "Townsville","state": "TS","zipCode": "67890"}'),
        (2, '{"street": "789 Oak St","city": "Villagetown","state": "VT","zipCode": "54321"}'),
        (3, '{"city": "Villagetown","state": "VT","zipCode": "54321"}');

select id, JSON_EXTRACT(details, '$.street') from address;
select * from address where JSON_EXTRACT(details, '$.street') = '456 Elm St';
select * from address where JSON_CONTAINS(details, '{"street": "456 Elm St"}');

select * from user
    join address on JSON_EXTRACT(address.details, '$.zipCode') = user.zip_code;

select * from address
    join user on user.zip_code = JSON_EXTRACT(address.details, '$.zipCode');


# LIKE not working as expected: empty result
select * from address where JSON_EXTRACT(details, '$.street') like '456 Elm St';
