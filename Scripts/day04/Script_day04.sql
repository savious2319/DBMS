--day04
-- Ű �����ϱ�
-- �������� PRIMARY KEY

--�ɰ� ȭ��

		CREATE TABLE BUYER(
			ID VARCHAR2(20),
			NAME VARCHAR2(20),
			ADDRESS VARCHAR2(30),
			EMAIL VARCHAR2(20),
			CONSTRAINT BUYER_PK PRIMARY KEY(ID)
		);
	
		CREATE TABLE FLOWER(
			FNAME VARCHAR2(20),
			FCOLOR VARCHAR2(10),
			PRICE NUMBER(10),
			CONSTRAINT PK_FNAME PRIMARY KEY(FNAME)
		);
	
		CREATE TABLE FPOT(
			PRODUCT_NUMBER NUMBER(5),
			PCOLOR VARCHAR2(20),
			PSHAPE VARCHAR2(10),
			FNAME VARCHAR2(20),
			CONSTRAINT FK_FNAME_FPOT FOREIGN KEY(FNAME) REFERENCES FLOWER(FNAME),
			CONSTRAINT PK_PRODUCT_NUMBER PRIMARY KEY(PRODUCT_NUMBER) 
		);
	
		CREATE TABLE PURCHASE(
			ID VARCHAR2(20),
			ORDER_NUMBER NUMBER(5),
			PRODUCT_NUMBER NUMBER(5),
			FNAME VARCHAR2(20),
			ADDRESS VARCHAR2(30),
			CONSTRAINT PK_ORDER_NUMBER PRIMARY KEY(ORDER_NUMBER, ID, FNAME, PRODUCT_NUMBER),
			CONSTRAINT FK_PURCHASE_ID FOREIGN KEY(ID)
				REFERENCES BUYER(ID),
			CONSTRAINT FK_PRODUCT_NUMBER FOREIGN KEY(PRODUCT_NUMBER)
				REFERENCES FPOT(PRODUCT_NUMBER),
			CONSTRAINT FK_FNAME_PURCHASE FOREIGN KEY(FNAME)
				REFERENCES FLOWER(FNAME)
		); 

ALTER TABLE PURCHASE DROP PRIMARY KEY;

ALTER TABLE PURCHASE ADD CONSTRAINT PK_PURCHASE PRIMARY KEY(ID, ORDER_NUMBER, PRODUCT_NUMBER, FNAME);

ALTER TABLE PURCHASE ADD(

BUYER_NAME VARCHAR2(20) NOT NULL,
REFUND CHAR(1),
SUPER_ID VARCHAR2(20) CONSTRAINT PURCHASE_PK PRIMARY KEY

);
	
ALTER TABLE MEMBER RENAME TO BUYER; 
ALTER TABLE BUYER MODIFY EMAIL VARCHAR2(30);	

INSERT INTO BUYER VALUES('840910-1042014', 'BRIAN', 'SEOUL, KOREA', 'koreanbradpitt@gmail.com');
INSERT INTO BUYER VALUES('570203-2030324', 'LAKE', 'SEOUL, KOREA', 'lakehae@gmail.com');

SELECT * FROM BUYER;

INSERT INTO FLOWER VALUES('ROSE', 'WHITE', 5000);
INSERT INTO FLOWER VALUES('LILY', 'YELLOW', 6000);
INSERT INTO FLOWER VALUES('TULIP', 'PURPLE', 7000);
	
SELECT * FROM FLOWER;

INSERT INTO FPOT VALUES('23198', 'BROWN', 'SQUARE', 'ROSE');
INSERT INTO FPOT VALUES('23199', 'BLUE', 'TRIANGLE', 'LILY');
INSERT INTO FPOT VALUES('23200', 'GREEN', 'RECTANGLE', 'TULIP');

SELECT * FROM FPOT; 

INSERT INTO PURCHASE VALUES('840910-1042014', '2319', '23200', 'TULIP', 'SEOUL, KOREA');
INSERT INTO PURCHASE VALUES('570203-2030324', '2320', '23200', 'TULIP', 'TOKYO, JAPAN');

SELECT * FROM PURCHASE;

TRUNCATE TABLE FLOWER;
TRUNCATE TABLE FPOT;
TRUNCATE TABLE PURCHASE;

DROP TABLE PURCHASE;	
DROP TABLE FLOWER;
DROP TABLE BUYER;
DROP TABLE FPOT;

	
--dual
SELECT 2354*989757456745 FROM DUAL;

--�ð� ���� : sysdate �Լ� (����ܾ�ڿ� �Ұ�ȣ�� ���� ����)
SELECT SYSDATE FROM DUAL;

--alias
SELECT SYSDATE as ����ð� FROM DUAL;
--���࿡ ��Ī(alias)�� ������ ���� ����, �ֵ���ǥ�� ���� �ָ�ȴ�.
select sysdate "���� �ð��� ��¥" from dual;

select
	sysdate -1000 "1000�� ��",
	sysdate "���� ��¥",
	sysdate + 1000 "1000�� ��",
	sysdate + 48/24 "2�� ��", --24�ð�
	sysdate + 3/24 "3�ð� ��"
from
	dual;

--�ٹ� ���� �� üũ : MONTH_BETWEEN(A, B) A, B ��¥ ������ "������"�� ���Ѵ�
SELECT ENAME, SYSDATE "����", MONTHS_BETWEEN(SYSDATE, HIREDATE) FROM EMP;

--�� �Ҽ����� �߻��Ѵ�.. �Ҽ����� ���ִ� �Լ� TRUC(��)

SELECT ENAME, SYSDATE "����", 
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) ������ 
FROM EMP;

--SELECT TRUNC(10/3, �ڸ���) FROM EMP; --�����θ�!!!
SELECT TRUNC(10/3, 2) FROM EMP; --�����θ�!!!

SELECT 
	
	ENAME "�̸�",
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12) "�ټ� ���"

FROM EMP;


--��¥�� �⺻ ��� ���İ� �ٸ� ���·� ����ϰ� �ʹ�.
--���� ����, 'YYYY-MM-DD' FORMAT
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;


--��¥ + �ð� ���� +���ϱ���
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM EMP;

--���ϱ���
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY HH:MI:SS') FROM EMP;

--������� 19801217 �� ������ �ִ�!
--�� ����� ������ �������� �̸��� ������� ����ʹ�.
SELECT ENAME, HIREDATE FROM EMP 
WHERE HIREDATE = TO_DATE(19801217, 'YYYYMMDD'); --������ ���ڿ��̵� �������

--emp ���̺���... job�� clerk�� ����� ��� ã�ƶ�.
SELECT * FROM EMP WHERE JOB = 'CLERK';

--EMP ���̺��� �Ŵ����� 7902�� ����� ������ȣ, �̸�, job �� ����� ��
SELECT EMPNO, ENAME, JOB FROM EMP WHERE MGR = 7902;



--����) 
--���� ���� : EMP ���̺��� SAL�� 1500�̻��� ����� ������ ��ȸ
SELECT * FROM EMP WHERE SAL > 1500;

--���� ���� : �̸��� KING�� ��� ��ȸ
SELECT * FROM EMP WHERE ENAME = 'KING';

--��¥ ���� : 81/02/20 ������ �Ի��� ������� ��ȸ
SELECT * FROM EMP WHERE HIREDATE < TO_DATE('1981-02-20', 'YYYY-MM-DD');
SELECT * FROM EMP WHERE HIREDATE < '81-02-20';--TO_DATE('1981-02-20', 'YYYY-MM-DD'); �ڵ�����ȯ

--�� : �μ���ȣ�� 30���� "�ƴ�" ������� ��� ������ ��ȸ
SELECT * FROM EMP WHERE DEPTNO != 30;

--��+�� : �μ���ȣ�� 30�̰� �޿��� 2000 �̻��� ������� ����̸��� �޿�, �μ���ȣ�� ��ȸ
SELECT ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO = 30 AND SAL > 2000;

--�� : ������ MANAGER�� �ƴ� ����� ��ȸ
SELECT * FROM EMP WHERE JOB != 'MANAGER';

--��+�� : �μ���ȣ�� 10���̰ų� 20���� ������� �μ���ȣ�� ����̸��� ��ȸ (IN ���)
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN(10,20); --WHERE DEPTNO=10 OR DEPTNO=20;

--SQL ������ : �޿��� 1000�̻� 3000������ ������� ��ȸ (BETWEEN)
SELECT * FROM EMP WHERE SAL BETWEEN 1000 AND 3000;

--SQL ������ : ����̸��� 'J'�� �����ϴ� ����� �����ȣ�� �̸��� ��ȸ(LIKE)
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE 'J%' --J�� �����ؾ� �ȴ�!! J�� �����ϴ� ���ڿ�

--SQL ������ : ����̸��� 'T'�� �����ϴ� ����� ������ ��ȸ
SELECT * FROM EMP WHERE ENAME LIKE '%T%';  --%����% ���ڿ��� T�� �����ϰ� �ִ�...

--SQL ������ : ����̸� 2��° ���ڰ� 'A'�� ��� ��ȸ (LIKE) --���� �ϳ��� ī��Ʈ �Ҷ��� _���� �ϳ�
SELECT * FROM EMP WHERE ENAME LIKE '_A%'; --ù��°�� �ƴ� �ι�° �׷��� _������ ���� ó����

--SQL ������ : 81�⵵�� �Ի��� ����� ��ȸ (LIKE)
SELECT * FROM EMP WHERE HIREDATE LIKE '%81%'; --����ȯ ���� ���� �Ǵ��� Ȯ���� ����!!!

--SQL ������ : Ŀ�̼��� NULL�� ����� ��ȸ
SELECT * FROM EMP WHERE COMM IS NULL;

--���� ������ : �÷��� ���ڿ��� �����Ѵ�. || ������ ���
SELECT ENAME || '�� �޿���' || SAL || '�Դϴ�' FROM EMP;




CREATE TABLE INFO(
		
		ID_NO NUMBER(4),
		NAME VARCHAR2(10),
		JOB VARCHAR2(9),
		BUNHO NUMBER(4)
		);

INSERT INTO INFO (ID_NO, NAME, JOB, BUNHO)
		SELECT EMPNO, ENAME, JOB, MGR FROM EMP
		WHERE JOB = 'CLERK';

SELECT * FROM INFO;
DROP TABLE INFO;

--�ǽ�] �μ���ȣ�� 20�� ������� ��� ã�Ƽ�... �̸��� SUPERMAN���� ����
	UPDATE EMP_TEST SET
		ENAME = 'SUPERMAN'
	WHERE DEPTNO = 20;
SELECT * FROM EMP_TEST;

--�ǽ�] �̸��� A�� ���� ����� ã�� 'A-MAN'���� ������ �ּ���
		UPDATE EMP_TEST SET
		ENAME = 'A-MAN'
	WHERE ENAME LIKE '%A%';


--�ǽ�] �̸��� A�� ���� ����� ã��.. �����̸� + '-TAG' �� �ٿ��ּ���.
	UPDATE EMP_TEST SET
		ENAME = ENAME || '-TAG'
	WHERE ENAME LIKE '%A%';	



TRUNCATE TABLE EMP_TEST; 

INSERT INTO EMP_TEST SELECT * FROM EMP

--�ǽ�] �μ� ��ȣ 10�� ����� �����ϱ�
-- �ٽ� INSERT ���� �����ؼ� ������ �����ϱ�!!! ��ƾ �ݺ�!!!!
	DELETE FROM EMP_TEST
	WHERE DEPTNO = 10;

	INSERT INTO EMP_TEST
	SELECT * FROM EMP WHERE DEPTNO = 10;

--�ǽ�] 81/02/20 ������ �Ի��� ����� �����ϱ�
-- ��� ������ ������ �ٽ� ������ ����!!!
	DELETE FROM EMP_TEST
	WHERE HIREDATE < '81/02/20';--TO_DATE(81/02/20, 'YY/MM/DD');

	INSERT INTO EMP_TEST
	SELECT * FROM EMP WHERE HIREDATE < '81/02/20';

SELECT * FROM EMP_TEST;





-----------------------------------------------------------------------------------
--1. �μ���ȣ�� 10���� �μ��� ����� �����ȣ, �̸�,������ ����Ͽ���. 
SELECT EMPNO, ENAME, SAL FROM EMP WHERE DEPTNO = 10;

--2. �����ȣ�� 7369�� ����� �̸�,�Ի���,�μ���ȣ�� ����϶�.
SELECT ENAME, HIREDATE, DEPTNO FROM EMP WHERE EMPNO = 7369;

--3. �̸��� ALLEN �� ����� ��� ������ ����϶�.
SELECT * FROM EMP WHERE ENAME = 'ALLEN';

--4. �Ի����� 81/05/01�� ����� �̸�,�μ���ȣ,������ ����϶�.
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE HIREDATE = '81/05/01';--TO_DATE('1981-05-01', 'YYYY-MM-DD');
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY/MM/DD') = '1981/05/01';

--TO_DATE('1981-05-01', 'YYYY-MM-DD');
SELECT ename,deptno,sal FROM EMP WHERE TO_DATE(HIREDATE,'YY/MM/DD') = TO_Date('81/05/01','YY/MM/DD');

--5. ������ MANAGER �� �ƴ� ����� ��� ������ ����϶�.
SELECT * FROM EMP WHERE JOB != 'MANAGER';

--6. �Ի����� 81/04/02 ���Ŀ� �Ի��� ����� ������ ����϶�.
SELECT * FROM EMP WHERE HIREDATE > '81/04/02';--TO_DATE('1981/04/02', 'YYYY/MM/DD'); 

--7. �޿��� $800 �̻��� ����� �̸�,�޿�,�μ���ȣ�� ����϶�.
SELECT ENAME, SAL, DEPTNO FROM EMP WHERE SAL > 800;

--8. �μ���ȣ�� 20�� �̻��� ����� ��� ������ ����϶�.
SELECT * FROM EMP WHERE DEPTNO > 20;

--9. �Ի����� 81/12/09 ���� ���� �Ի��� ������� ��� ������ ����϶�.
SELECT * FROM EMP WHERE HIREDATE < '81/12/09';--TO_DATE('81/12/09', 'YY/MM/DD'); 

--10. �Ի��ȣ�� 7698 ���� �۰ų� ���� ������� �Ի��ȣ�� �̸��� ����϶�.
SELECT EMPNO, ENAME FROM EMP WHERE EMPNO <= 7698;

--11. �Ի����� 81/04/02 ���� �ʰ� 82/12/09 ���� ���� ����� �̸�,����,�μ���ȣ,�Ի��ȣ�� ����϶�.
SELECT HIREDATE, ENAME, SAL, DEPTNO, EMPNO FROM EMP 
WHERE TO_DATE(HIREDATE, 'YY/MM/DD') BETWEEN TO_DATE('81/04/02', 'YY/MM/DD') AND TO_DATE('82/12/09', 'YY/MM/DD'); 

SELECT HIREDATE, ENAME, SAL, DEPTNO, EMPNO FROM EMP
WHERE HIREDATE BETWEEN '81/04/02' AND '82/12/09';

--12. �޿��� 1,600 ���� ũ��, $3,000 ���� ���� ����� �̸�,����,�޿��� ����϶�.
SELECT ENAME, JOB, SAL FROM EMP WHERE SAL > 1600 AND SAL < 3000;


--13. �̸��� B�� J������ ��� ����� �̸��� ����϶�.
SELECT ENAME FROM EMP WHERE ENAME BETWEEN 'B' AND 'J';


--14. �Ի����� 81�� �̿ܿ� �Ի��� ����� �Ի��ϰ� �̸��� ����϶�.
SELECT HIREDATE, ENAME FROM EMP WHERE HIREDATE NOT LIKE '%81%'; 
SELECT HIREDATE, ENAME FROM EMP WHERE HIREDATE < '81/01/01' AND HIREDATE < '82/01/01';
SELECT HIREDATE, ENAME FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') != '1981';

--15. ������ MANAGER�� SALESMAN�� ����� �̸��� ������ ����϶�.
SELECT ENAME, JOB FROM EMP WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN';
SELECT ENAME, JOB FROM EMP WHERE JOB IN('MANAGER', 'SALESMAN');


--16. �μ���ȣ�� 20,30 ���� ������ ��� ����� �̸�,�����ȣ,�μ���ȣ�� ����϶�.
SELECT ENAME, EMPNO, DEPTNO FROM EMP WHERE DEPTNO != 20 AND DEPTNO != 30;


--17. �̸��� S�� �����ϴ� ����� �����ȣ,�̸�,�Ի���,�μ���ȣ�� ����϶�
SELECT EMPNO, ENAME, HIREDATE, DEPTNO FROM EMP WHERE ENAME LIKE 'S%';


--18. �Ի����� 81�⵵�� ����� �Ի���,�̸��� ����϶�
SELECT HIREDATE, ENAME FROM EMP WHERE HIREDATE LIKE '%81%';


--19. �̸� �� A�ڰ� �� �ִ� ����� �Ի��ȣ,�̸��� ����϶�.
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE '%A%';


--20. �̸��� S�� �����ϰ� ������ ���ڰ� H�� ����� �̸��� ����϶�.
SELECT ENAME FROM EMP WHERE ENAME LIKE 'S%H';


--21. �̸��� �ι�° ���ڰ� A�� ����� �̸��� ����϶�.
SELECT ENAME FROM EMP WHERE ENAME LIKE '_A%';


--22. Ŀ�̼��� NULL�� ����� �̸��� Ŀ�̼��� ����϶�.
SELECT ENAME, COMM FROM EMP WHERE COMM IS NULL;


--23. Ŀ�̼��� NULL�� �ƴ� ����� �̸��� Ŀ�̼��� ����϶�.
SELECT ENAME, COMM FROM EMP WHERE COMM IS NOT NULL;


--24. �μ���ȣ�� 30�� �μ��̰�,�޿��� 1500 �̻��� ����� �̸�,�μ���ȣ,������ ����϶�.
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE DEPTNO = 30 AND SAL > 1500;


--25. �̸��� ù ���ڰ� K�� �����ϰų� �μ���ȣ�� 30�� ����� �����ȣ,�̸�,�μ���ȣ�� ����϶�.
SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE ENAME LIKE 'K%' OR DEPTNO = 30;


--26. �޿��� 1500 �̻��̰�,�μ���ȣ�� 30���� ����� ������ MANAGER�� ����� �޿�,�μ���ȣ,������ ����϶�.
SELECT SAL, DEPTNO, JOB FROM EMP WHERE SAL > 1500 AND DEPTNO = 30 AND JOB = 'MANAGER';


--27. �μ���ȣ�� 30�� ����� �̸�,�����ȣ,�μ���ȣ�� �����ȣ�� ���������Ͽ���.
SELECT ENAME, EMPNO, DEPTNO FROM EMP WHERE DEPTNO = 30 ORDER BY EMPNO ASC;


--28. �̸��� �޿��� �����͸� �޿��� ���� ������ �����϶�.
SELECT ENAME, SAL FROM EMP ORDER BY SAL DESC;


--29. �μ���ȣ�� �������� �������� �޿��� ���� ��������� �̸�,�μ���ȣ,�޿��� ����϶�.
SELECT ENAME, DEPTNO, SAL FROM EMP ORDER BY DEPTNO ASC, SAL DESC;


--30. �μ���ȣ�� �������� �������� ,���������� ��������,�޿������� ���������Ͽ���.
SELECT * FROM EMP ORDER BY DEPTNO DESC, JOB ASC, SAL DESC;
