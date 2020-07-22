-- hr 계정에서 각종 테이블 내용을 확인해 보자 (select * from 테이블 구조 이용해서 조회해 보기)
--SELECT * FROM JOBS; --한줄은 ctrl + enter 로 실행한다.
--SELECT * FROM COUNTRIES;
--SELECT * FROM DEPARTMENTS d ;
--SELECT * FROM EMPLOYEES e ;
--SELECT * FROM JOB_HISTORY jh ;
--SELECT * FROM LOCATIONS l ;
--SELECT * FROM REGIONS r 

CREATE TABLE MEMBER(
	ID varchar2(50),
	PWD varchar2(50),
	NAME varchar2(50),
	GENDER varchar2(50),
	AGE NUMBER,
	BIRTHDAY varchar2(50),
	PHONE varchar2(50),
	REGDATE date
	); 
