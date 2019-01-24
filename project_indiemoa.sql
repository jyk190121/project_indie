--create user indiemoa identified by 1111;
--grant dba to indiemoa;
select * from users;
create table users (
    id varchar2(20) primary key,
    password varchar2(20) not null,
    nickname varchar2(20) not null,
    email varchar2(50) unique,
    image varchar2(100) default 'default.png',
    myinfo clob default '당신을 소개해보세요',
    lev number default 1,
    exp number default 0
);
insert into users values('test','1111','tester','test@gmail.com','default.png','테스트다테스트', 1, 0);

create sequence seq_authority_id;
create sequence seq_board_id;
create sequence seq_game_id;
create sequence seq_reply_id;
create sequence seq_likes_id;
create sequence seq_score_id;
create sequence seq_hotgame_id;

create table authority(
    id number primary key,
    users_id varchar2(20) constraint FK_users_id references users(id),
    role varchar2(15) check(role like 'ROLE#_%' escape '#')                          
);

create table board (
    id number primary key,
    writer varchar2(20) references users(id),
    title varchar2(100) not null,
    content clob,
    write_date date not null,
    ip varchar2(15) not null,   
    hit number default 0,
    attach_file varchar2(300),
    reply_count number default 0
);

create table game (
    id number primary key,
    name varchar2(30) not null,
    type char(3) check (type in ('web', 'exe', 'etc')),
    src clob not null,
    etc_info clob,
    info clob not null,
    image varchar2(100) not null,
    users_id varchar2(200) references users(id),
    hit number default 0,
    regist_date date not null,
    likes number default 0,
    unlikes number default 0,
    reply_count number default 0
);
select * from game ;
delete from game;
insert into game values(1, 'testGame', 'web', '<script>test</script>','테스트게임입니다', 'test1.jpg', 'test', 0, sysdate, 0, 0 ,0);
insert into game values(2, 'testGame', 'exe', '<script>test</script>','테스트게임입니다2', 'test2.jpg', 'test', 0, sysdate, 0, 0 ,0);
insert into game values(3, 'testGame', 'etc', '<script>test</script>','테스트게임입니다3', 'test3.jpg', 'test', 0, sysdate, 0, 0 ,0);
insert into game values(seq_game_id.nextval, 'testGame', 'web', '<script>test</script>','테스트게임입니다', 'gameDefault.jpg', 'test', 0, sysdate, 0, 0 ,0);
update game set unlikes = 5 where id in (1);
create table reply (
    id number primary key,
    type varchar2(5) check (type in ('game', 'board')) not null,
    idx number not null,
    writer varchar2(20) references users(id),
    content varchar2(300) not null,
    write_date date not null,
    ref number,
    depth number,
    step number
);
select * from reply;
select * from user_constraints;
create table likes (
    id number primary key,
    type varchar2(6) check (type in ('like', 'unlike')),
    users_id varchar2(20) references users(id)
);

create table score (
    id number primary key,
    game_id number references game(id) on delete set null,
    users_id varchar2(20) references users(id) on delete set null,
    score number not null,
    play_timestamp timestamp not null
);
insert into score values(1,1,'test',100,systimestamp);
insert into score values(2,1,'test',200,systimestamp);
insert into score values(3,1,'test',300,systimestamp);
insert into score values(4,2,'test',100,systimestamp);
insert into score values(5,2,'test',200,systimestamp);
insert into score values(6,3,'test',150,systimestamp);
insert into score values(7,3,'test',300,systimestamp);
select * from score where play_timestamp < sysdate;
create table hotgame(
    id number primary key,
    game_id number references game(id) on delete set null,
    startdate date not null,
    enddate date not null
);
insert into hotGame values(1, 1, '19/01/01', last_day(sysdate));
insert into hotGame values(2, 2, '19/01/01', last_day(sysdate));
insert into hotGame values(3, 3, '19/01/01', last_day(sysdate));
select * from hotGame;

select * from (select rownum rnum, g.* from (select * from game order by regist_date desc) g) where rnum  <= 3;

select add_months(systimestamp, 1) from dual;

create table hotGameHighScore(
    users_id varchar2(20) references users(id) on delete set null,
    score_a number default 0,
    score_b number default 0,
    score_c number default 0
);
drop table hotGameHighScore;
insert into hotGameHighScore values('test', 100, 0, 200);
insert into hotGameHighScore values('jin', 0, 0, 200);
select users_id, (score_a + score_B + score_c) score from 
			(select rownum rnum, h.* from hotGameHighScore h order by score_a + score_B + score_c desc)
				where rnum <= 2;
--drop table authority
--drop table reply;
--drop table likes;
--drop table board;
--drop table game;
--drop table users;