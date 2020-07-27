--Ctrl + ] : �� ��ũ��Ʈ ���� ����

--PLAYER���̺��� TEAM_ID�� 'K02'�̰ų� 'K07'�̰�
--�������� 'MF'�� ���� �˻�(AND, OR ���)
--���� �÷��� Ȥ�� ���̺������ ���� �翷�� ū ����ǥ�� ���δ�.
--��) POSITION(X) --> "POSITION" (O)
SELECT *FROM PLAYER 
--WHERE (TEAM_ID = 'K02' OR TEAM_ID ='K07') AND "POSITION" = 'MF'; --POSITION�� Ű����� ""�� ��ü�Ѵ�
WHERE "POSITION" = 'MF' AND (TEAM_ID = 'K02' OR TEAM_ID ='K07');

--AND�� OR�� �켱����
--WHERE ���������� OR���� AND�� ���� ���δ�.
--��üȭ��/���� : CTRL + M

--TCL
--PLAYER ���̺��� TEAM_ID�� 'K01'�� ���� �̸��� �� �̸����� �ٲٱ�
UPDATE PLAYER 
SET PLAYER_NAME  = '�鼺��'
WHERE TEAM_ID = 'K01';


SELECT * FROM PLAYER WHERE TEAM_ID = 'K01';

--PLAYER ���̺��� POSITION�� 'MF'�� ���� �����ϱ�
DELETE FROM PLAYER
WHERE "POSITION" = 'MF';

SELECT * FROM PLAYER
WHERE "POSITION" = 'MF';

--PLAYER ���̺��� HEIGHT�� 180�̻��� ���� �����ϱ�
DELETE FROM PLAYER 
WHERE HEIGHT >= 180;

SELECT * FROM PLAYER
WHERE HEIGHT >= 180;

--AS(ALIAS) : ��Ī
--PLAYER ���̺��� ���� �̸���, TEAM ���̺��� �ּҸ� �˻�
--SELECT�� �� �� ���� ����Ѵ�.

SELECT T.TEAM_ID, P.PLAYER_NAME "���� �̸�", T.ADDRESS �ּ� 
FROM PLAYER P , TEAM T;

--STADIUM ���̺��� ADDRESS�� TEAM ���̺��� TEL �˻�
SELECT S.ADDRESS AS "����� �ּ�", T.TEL
FROM STADIUM S, TEAM T; --FROM������ ���� �ϸ� ���߿� �ڵ� �ϼ��� �ȴ�

--CONCATENATION(����)
SELECT PLAYER_NAME || '������ ' || NICKNAME AS ���� FROM PLAYER;

--LIKE : ���Ե� ���ڿ��� ���� ã��
-- % : ��� ��
-- '%A' : A�� ������ ��� ��
-- '_A' : A�� ������ �� �ڸ��� ��

--PLAYER ���̺��� �达�� �ƴ� ��� ã��
--SELECT * FROM PLAYER WHERE PLAYER_NAME NOT LIKE'��%';
SELECT * FROM PLAYER WHERE NOT PLAYER_NAME LIKE ('��%');


--CASE��
--CASE WHEN THEN ELSE END
--CASE WHEN ���ǽ� THEN TRUE ELSE FLASE END


--EMP ���̺��� SAL 3000�̻��̸� HIGH, 1000�̻��̸� MID �� �ƴϸ� LOW
SELECT ENAME, SAL, 
CASE
WHEN SAL >= 3000 THEN 'HIGH' 
WHEN SAL > = 1000 THEN 'MID'  
ELSE 'LOW' END AS Ŭ��  
FROM EMP;

--��ø CASE��(Nested CASE)
--EMP ���̺��� SAL 2000 �̻��̸� ���ʽ� 1000
--SAL 1000�̻��̸� ���ʽ� 500
--�� �ƴϸ� 0
SELECT ENAME �����, SAL �޿�, 
CASE
WHEN SAL >= 2000 THEN 1000
ELSE 
(
	CASE
	WHEN SAL >= 1000 THEN 500
	ELSE 0
	END
) 
END AS ���ʽ�
FROM EMP;

--STADIUM ���̺��� SEAT_COUNT �� 0�̻� 30000 ���ϸ� 'S'
--30001�̻� 50000���ϸ� 'M' �� �ƴϸ� 'L'
--��ø CASE�� ���
SELECT STADIUM_NAME �����, SEAT_COUNT �¼���,
CASE 
WHEN SEAT_COUNT BETWEEN 0 AND 30000 THEN 'S' --SEAT_COUNT > 0 AND SEAT_COUNT < 30000 THEN 'S' 
ELSE
(
	CASE 
	WHEN SEAT_COUNT BETWEEN 30001 AND 50000 THEN 'M'--SEAT_COUNT > 30001 AND SEAT_COUNT < 50000 THEN 'M'
	ELSE 'L'
	END 
) 
END AS �Ը�
FROM STADIUM;


--PLAYER ���̺��� WEIGHT�� 50�̻� 70���ϸ� 'L'
--71�̻� 80���ϸ� 'M' NULL�̸� (IS NULL) '�̵��' �� �ƴϸ� 'H'
--��Ī�� 'ü��'���� �ֱ�

SELECT PLAYER_NAME ����, WEIGHT || 'kg' AS ������, --|| �� kg���� ���� �����ش�! 
CASE
WHEN WEIGHT BETWEEN 50 AND 70 THEN 'L' --WEIGHT > 50 AND WEIGHT < 70 THEN 'L'
WHEN WEIGHT BETWEEN 71 AND 80 THEN 'M'
ELSE 
(
	CASE
	WHEN WEIGHT IS NULL THEN '�̵��'
	ELSE 'H'
	END

)
END AS ü��
FROM PLAYER;

--������ �Լ�(���� ����) FROM DUAL;
--���밪
SELECT ABS(-10) FROM DUAL;

--��������(1), ��(0), ��������(-1)
SELECT SIGN(-234), SIGN(0), SIGN(123) FROM DUAL;F --�� ���� ������� ������ �������� �� �� �ִ�

--������ (% ��ⷯ��)
SELECT MOD(10, 8) FROM DUAL;

--�� ���� ū �ֱ��� ����
SELECT CEIL(3.14), CEIL(-3.14) FROM DUAL;

--�� ���� ���� �ֱ��� ����
SELECT FLOOR(3.14), FLOOR(-3.14) FROM DUAL;

--�ݿø�
SELECT ROUND(3.5513435) FROM DUAL;
SELECT ROUND(3.5513435, 2) FROM DUAL; --2�� �ڸ���

--����
SELECT TRUNC(3.9) FROM DUAL;

--PLAYER ���̺��� Ű�� �Ҽ��� ��°�ڸ����� �ݿø�, �����Դ� �Ҽ��� ����
SELECT PLAYER_NAME, ROUND(HEIGHT, 2) || 'cm' AS Ű, TRUNC(WEIGHT, 0) || 'kg' AS ������ 
FROM PLAYER;

--NVL, NVL2
--PLAYER ���̺��� POSITION�� NULL �̸� '����' ���� �˻��ϱ�
SELECT PLAYER_NAME �����̸�, NVL("POSITION", '����') ������ FROM PLAYER --SELECT�ڿ��� ���� ������ �ڸ��� 
--WHERE "POSITION" IS NULL;

--PLAYER ���̺���  POSITION�� NULL �̸� '����', ������ 'Ȯ��' ���� �˻��ϱ�
SELECT PLAYER_NAME �����̸�, NVL2("POSITION", 'Ȯ��', '����') "������ ����" FROM PLAYER; --DB������ �Լ��� PROCEDURE�̴�


--PLAYER ���̺��� NATION�� NULL �� �ƴϸ� '���'
--NULL �̸� '�̵��'���� ���� ��  �����̸�, ���� �˻��ϱ�
--��Ī�� ���� ��� ���η� �ֱ�
SELECT PLAYER_NAME �����̸�, NVL2(NATION, '���', '�̵��') AS "���� ��� ����" FROM PLAYER;



--COALESCE(�ھ󷹽�) : �����ϴ�
--NULL �� �ƴϸ� 1�� ����, NULL �̸� 2�� ����, �Ѵ� NULL�̸� NULL
--PLAYER ���̺��� NICKNAME, PLAYER_NAME �� NULL�� �ƴ� ������ �˻�(NULL�̸� NULL�� �˻�)

SELECT PLAYER_NAME, COALESCE(NICKNAME, PLAYER_NAME) AS KNOWN FROM PLAYER;

--PLAYER ���̺��� NICKNAME�� ������ '���� ����' ���� ���� �� �˻�
--�ھ󷹽� ���

SELECT PLAYER_NAME, NICKNAME, COALESCE(NICKNAME, '���� ����') AS ���� FROM PLAYER;


--���� �Լ� (NULL�� �������� �ʴ´�)

SELECT AVG(HEIGHT), MAX(HEIGHT), MIN(HEIGHT), SUM(HEIGHT) FROM PLAYER;

SELECT * FROM PLAYER WHERE HEIGHT IS NULL;

SELECT COUNT(*) FROM PLAYER;

SELECT * FROM PLAYER;

SELECT COUNT(HEIGHT) FROM PLAYER;

--PLAYER ���̺��� HEIGHT ���� �˻�(NULL �����ؼ� COUNT�ϱ�)
SELECT COUNT(NVL(HEIGHT, 0)) AS "�� �ο���" FROM PLAYER;

--ORDER BY : ����
--ASC : ��������(���� ����)
--DESC : ��������

--PLAYER ���̺��� Ű ������ �˻�(���� ����)
SELECT PLAYER_NAME, HEIGHT FROM PLAYER
WHERE HEIGHT IS NOT NULL 
ORDER BY HEIGHT DESC;

--PLAYER ���̺��� Ű ��, ������ ��(��������)���� �˻�
--NULL�� �ƴ� ���� �˻�
SELECT PLAYER_NAME, HEIGHT, WEIGHT FROM PLAYER
WHERE HEIGHT IS NOT NULL AND WEIGHT IS NOT NULL 
ORDER BY 2, 3 DESC; --2��° �÷�, 3��° �÷� --HEIGHT, WEIGHT DESC;  --HEIGHT�� ������ WEIGHT�� ���ĵȴ�
--�÷��� �Ӹ��ƴ϶� ��� �÷� ��ȣ�� �ۼ��ص� �ȴ�.
--�÷� ���� ��ų� �ۼ��ϱ� ����� ��� ��ȣ�� �ۼ��Ͽ� �ذ��Ѵ�.
----------------------------------------------------------------------------------------------------------------------------
--GROUP BY : ~��(�� : ������ �� ���Ű)

--GROUP BY �÷���
--HAVING ���ǽ� (HAVING���� ���� ����)

--PLAYER ���̺��� ������ �� �˻�
--1��
SELECT "POSITION" FROM PLAYER
GROUP BY "POSITION" 
HAVING "POSITION" IS NOT NULL; --���� 1)FROM 2)GROUP BY 3)HAVING 4)SELECT 5)ORDER BY

--2�� (WHERE������ ������ ó���� �� �ִٸ� �ݵ�� WHERE������ ���� ó�����ش�.)
SELECT "POSITION" FROM PLAYER
WHERE "POSITION" IS NOT NULL
GROUP BY "POSITION";

--2���� 1�� ���� �� ������

--PLAYER ���̺��� �����԰� 80�̻��� �������� ��Ŧ Ű�� 180�̻��� ������ �˻�
SELECT "POSITION", ROUND(AVG(HEIGHT), 2) "��� Ű", MIN(WEIGHT) "�ּ� ������" 
FROM PLAYER
WHERE WEIGHT >= 80 
GROUP BY "POSITION" --GROUP BY �� ���ſ� ���ؼ��� �˻��ؾ� �Ѵ�!
HAVING AVG(HEIGHT) >= 180; --�����Լ��� HAVING������ ����Ѵ�!

--EMPLOYEES ���̺��� JOB_ID ���� ��� SALARY�� 10000�̸���
--(SALARY �հ�, ���, �ִ밪, �ּҰ�, JOB_ID�� ���) �˻��ϱ�
--JOB_ID ���ĺ� ������ �������� ����

SELECT JOB_ID, SUM(SALARY), ROUND(AVG(SALARY), 2), MAX(SALARY), MIN(SALARY), COUNT(JOB_ID) 
FROM EMPLOYEES
GROUP BY JOB_ID 
HAVING AVG(SALARY) < 10000
ORDER BY JOB_ID; 

--SUB QUERY : SQL�� ���ο� SQL�� ����
--FROM��	: IN LINE VIEW
--SELECT��	: SCALAR
--WHERE��	: SUB_QUERY

--PLAYER ���̺��� TEAM_ID�� 'K01'�� ���� �߿� POSITION�� 'GK' �� ����
SELECT * FROM (SELECT * FROM PLAYER WHERE TEAM_ID = 'K01')
WHERE "POSITION" = 'GK';


SELECT * FROM PLAYER
WHERE TEAM_ID = 'K01' AND "POSITION" = 'GK';

--PLAYER ���̺��� ���Ű���� ���� ���� �˻�
SELECT * FROM PLAYER WHERE HEIGHT < (SELECT AVG(HEIGHT) FROM PLAYER);


--PLAYER ���̺��� ��ü ��� Ű�� �����Ǻ� ���Ű ���ϱ�
SELECT "POSITION", AVG(HEIGHT ) "�����Ǻ� ��� Ű", 
(SELECT AVG(HEIGHT) FROM PLAYER) "��ü ��� Ű"
FROM PLAYER 
WHERE "POSITION" IS NOT NULL
GROUP BY "POSITION"; 


--�� 4���� ���� �� ���� ������ �������� CASE���� ����Ͽ� ��� �˻�
SELECT 
ROUND(AVG(CASE "POSITION" WHEN 'DF' THEN HEIGHT END), 2) AS DF, --������� ���Ű
ROUND(AVG(CASE "POSITION" WHEN 'GK' THEN HEIGHT END), 2) AS GK, 
ROUND(AVG(CASE "POSITION" WHEN 'FW' THEN HEIGHT END), 2) AS FW, 
ROUND(AVG(CASE "POSITION" WHEN 'MF' THEN HEIGHT END), 2) AS MF, 
ROUND(AVG(HEIGHT), 2) AS "��ü ���"
FROM PLAYER;



--PLAYER ���̺��� NICKNAME�� NULL�� �������� ���¹� ������ �г������� �ٲٱ�
UPDATE PLAYER 
SET (NICKNAME) = (SELECT NICKNAME FROM PLAYER WHERE PLAYER_NAME = '���¹�')
WHERE NICKNAME IS NULL;

SELECT * FROM PLAYER;

--PLAYER ���̺��� NICKNAME�� NULL�� �������� �̸��� ���¹� ������ �ٲٱ�
UPDATE PLAYER 
SET (NICKNAME, PLAYER_NAME ) = (SELECT NICKNAME, PLAYER_NAME FROM PLAYER WHERE PLAYER_NAME = '���¹�')
WHERE NICKNAME IS NULL;

SELECT * FROM PLAYER;


--EMPLOYEES ���̺��� ��� �޿����� ���� ������� �޿��� 10% �λ��ϱ�
SELECT * FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES); 


UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);


SELECT * FROM EMPLOYEES;














