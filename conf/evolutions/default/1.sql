# --- !Ups

create table "shows" (
  "id" bigint generated by default as identity(start with 1) not null primary key,
  "title" varchar not null,
  "description" varchar not null
);

# --- !Downs

drop table "shows";
