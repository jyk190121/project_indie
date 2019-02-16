--create user indiemoa identified by 1111;
--grant dba to indiemoa;
select * from 
(select rownum rnum, b.* from 
(select * from 
(select rownum rank, a.* from (select * from users order by lev desc) a)) b)
		where rank <= 1*30 and rank >= (1-1)*30 order by rank;
    

select * from (select rownum rnum, a.* from 
		(select * from board where writer = 'test' order by id desc)a) 
		where rnum between 1 and 22;
select*from users ;
select * from (select rownum rnum, a.* from (select * from users where rownum < 3 order by lev desc) a);
delete from users where id ='test2';
create sequence seq_id_a;
update users set 
		lev = lev + 1 ,
		exp = exp - 150
		where id = 'test' and exp >= 150;
desc users;
select *
		from (select rownum rnum, a.* from
		(select * from (select * from board where type = 'notice' and writer = 'test' order by id desc)
		union all select * from 
		(select * from board where type = 'normal' and writer = 'test' order by id desc)) a)
		where rnum between 1 and 11;
select * from board where writer is null;
select * from users;
select * from authority;
delete from users where id='jin2';
insert into AUTHORITY values(SEQ_AUTHORITY_ID.NEXTVAL,'jin2','ROLE_ADMIN');
select * from game;
update users set lev = 2,exp=100 where id='jin';
update users set password ='1111';
update users set image = 'default.png' where image is null and rownum = 1;
insert into users values('jin2','1111','tester!!','test2323@gamil.com','default.png','test123231', 1, 0);
select a.id from ((select id,nickname from users) a) where nickname = 'tester!!' and rownum >= 1;
select nickname,id from users;

select * from (select rownum rnum, a.* from (select * from  
		(select * from users)) a) where rnum between 1 and 10;
update users set 
			password = 2222,
			nickname = '?��?��?��',
			image = 'default.png',
			myinfo = '?��?��?��2'
			where id = 'test2';
select * from board;
create table users (
    id varchar2(20) primary key,
    password varchar2(60)    not null,
    nickname varchar2(20) not null,
    email varchar2(50) unique,
    image varchar2(100) default 'default.png',
    myinfo clob default '?��?��?�� ?��개해보세?��',
    lev number default 1,
    exp number default 0
);
select * from users;
alter table users modify(password varchar2(60));
insert into users values('test','1111','tester','test@gmail.com','default.png','?��?��?��?��?��?��?��', 1, 0);
select * from users where nickname like '%%';
create sequence seq_authority_id;
create sequence seq_board_id;
create sequence seq_game_id;
create sequence seq_reply_id;
create sequence seq_likes_id;
create sequence seq_score_id;
create sequence seq_hotgame_id;


--select * from (select * from board_notice order by id)
-- union all select * from (select * from board order by id);

create table authority(
    id number primary key,
    users_id varchar2(20) references users(id) on delete cascade,
    role varchar2(15) check(role like 'ROLE#_%' escape '#')                          
);
insert into users values('test3','1111','tester','test3@gmail.com','default.png','안녕', 1, 0);
insert into authority values (seq_authority_id.nextval, 'test3', 'ROLE_ADMIN');
select * from authority;
create table board (
    id number primary key,
    writer varchar2(20) references users(id) on delete set null,
    title varchar2(100) not null,
    content clob,
    write_date date not null,
    ip varchar2(15) not null,   
    hit number default 0,
    attach_file varchar2(300),
    reply_count number default 0,
    type char(6) check (type in ('normal','notice')) 
);

select * from board;
insert into board values (seq_board_id.nextval, 'test', '�? 공�?', '?��?��?�� 만들�? ?��?��?��', sysdate, 0, 0, null, 0, 'notice');
insert into board values (seq_board_id.nextval, 'test', '?��번째 공�?', '계속 ?��?��?�� 만들�? ?��?��?��', sysdate, 0, 0, null, 0, 'notice');
insert into board values (seq_board_id.nextval, 'test', '?��반�?', '그냥 뻘�??��미다', sysdate, 0, 0, null, 0, 'normal');

select * from (select * from board where type = 'notice' order by id desc)
union all select * from (select * from board where type = 'normal' order by id desc);

create table game (
    id number primary key,
    name varchar2(30) not null,
    type char(3) check (type in ('web', 'exe', 'etc')),
    src clob not null,
    info clob not null,
    image varchar2(100) not null,
    users_id varchar2(200) references users(id),
    hit number default 0,
    regist_date date not null,
    likes number default 0,
    unlikes number default 0,
    reply_count number default 0,
    etc_info clob
);

select * from game ;
delete from game;
insert into game values(1, 'testGame', 'web', '<script>test</script>','?��?��?��게임?��?��?��', 'test1.jpg', 'test', 0, sysdate, 0, 0 ,0);
insert into game values(2, 'testGame', 'exe', '<script>test</script>','?��?��?��게임?��?��?��2', 'test2.jpg', 'test', 0, sysdate, 0, 0 ,0);
insert into game values(3, 'testGame', 'etc', '<script>test</script>','?��?��?��게임?��?��?��3', 'test3.jpg', 'test', 0, sysdate, 0, 0 ,0);
insert into game values(seq_game_id.nextval, 'testGame', 'exe', 'zipfiletest한글.zip','파일명에 한글 들어가도되나', 'gameDefault.jpg', 'test', 0, sysdate, 0, 0 ,0, null);
insert into game values(seq_game_id.nextval, 'pacman', 'web', 'index.html','깃허브에?�� �??��?�� ?���?', 'pacman.jpg', 'user', 0, sysdate, 0, 0 ,0, null);
update game set likes = 3, unlikes = 14 where id = 2;
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
select * from user_constraints where TABLE_NAME='GAME';
--create sequence seq_gameLike_id;
create table gameLike (
    id number primary key,
    game_id number references game(id) on delete set null,
    type varchar2(6) check (type in ('like', 'unlike')),
    users_id varchar2(20) references users(id) on delete cascade
);
select * from gameLike;
alter table gameLike drop constraint SYS_C004166; 
alter table gameLike add constraint users_id on delete cascade;
insert into gameLike values(1, 61, 'like', 'test');
--drop table gameLike;
select * from gameLike;
select * from users;

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
insert into hotGame values(seq_hotgame_id.nextval, 1, '19/02/01', last_day(sysdate));
insert into hotGame values(seq_hotgame_id.nextval, 2, '19/02/01', last_day(sysdate));
insert into hotGame values(seq_hotgame_id.nextval, 3, '19/02/01', last_day(sysdate));
select * from hotGame;
select * from game;
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

alter table users add writer_id number;
select * from users;
update users set writer_id = SEQ_USERS_ID.NEXTVAL;
create sequence seq_users_id;
update users set ranking = 1 where exp = (select max(exp) from users);

select * from reply;
alter table users drop column ranking;