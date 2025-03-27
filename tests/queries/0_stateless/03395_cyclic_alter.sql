-- Tags: no-parallel
drop dictionary if exists d0;
drop table if exists t0;
create table t0 (key int, value int) engine=MergeTree() primary key key;

create dictionary d0 (key int, value int) primary key key source(clickhouse(table t0)) layout(flat()) lifetime(min 1 max 2);

alter table t0 add column key2 int default dictGetOrDefault('d0', 'value', 1, 1); -- {serverError 269}
