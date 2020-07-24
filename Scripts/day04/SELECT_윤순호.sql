--	���� ���̺� ����
--	EMP ��Ŭ�� -> ������ �������� -> �����ͺ��̽� ���̺� ����
--	-> 'Scott.emp' ���� -> �ϴ� new table name ��ư Ŭ��
--	-> EMP_TEST -> NEXT -> NEXT 
--	EMP_TEST ���̺�� homework ����
--���� ���̺��� �����Ͱ� �Ѽյ� �� �ֽ��ϴ�.


--1. �μ���ȣ�� 10���� �μ��� ����� �����ȣ, �̸�,������ ����Ͽ���. 
SELECT empno,ename,sal FROM EMP_TEST WHERE DEPTNO = 10;
--2. �����ȣ�� 7369�� ����� �̸�,�Ի���,�μ���ȣ�� ����϶�.
SELECT ename,hiredate,deptno FROM EMP_TEST WHERE empno = 7369;
--3. �̸��� ALLEN �� ����� ��� ������ ����϶�.
SELECT * FROM EMP_TEST WHERE ename = 'ALLEN';
--4. �Ի����� 81/05/01�� ����� �̸�,�μ���ȣ,������ ����϶�.
SELECT ename,deptno,sal FROM EMP_TEST WHERE TO_DATE(HIREDATE,'YY/MM/DD') = TO_Date('81/05/01','YY/MM/DD');
--5. ������ MANAGER �� �ƴ� ����� ��� ������ ����϶�.
SELECT * FROM EMP_TEST WHERE job != 'MANAGER';
--6. �Ի����� 81/04/02 ���Ŀ� �Ի��� ����� ������ ����϶�.
SELECT * FROM EMP_TEST WHERE TO_DATE(HIREDATE,'YY/MM/DD') >= TO_DATE('81/04/02','YY-MM-DD'); 
--7. �޿��� $800 �̻��� ����� �̸�,�޿�,�μ���ȣ�� ����϶�.
SELECT ename,sal,deptno FROM EMP_TEST WHERE sal >= 800;
--8. �μ���ȣ�� 20�� �̻��� ����� ��� ������ ����϶�.
SELECT * FROM EMP_TEST WHERE deptno >= 20;
--9. �Ի����� 81/12/09 ���� ���� �Ի��� ������� ��� ������ ����϶�.
SELECT * FROM EMP_TEST WHERE TO_DATE(HIREDATE,'YY/MM/DD') <= TO_DATE('81/12/09','YY-MM-DD'); 
--10. �Ի��ȣ�� 7698 ���� �۰ų� ���� ������� �����ȣ�� �̸��� ����϶�.
SELECT empno,ename FROM EMP_TEST WHERE empno <= 7698;
--11. �Ի����� 81/04/02 ���� �ʰ� 82/12/09 ���� ���� ����� �̸�,����,�μ���ȣ,�����ȣ�� ����϶�.
SELECT ename,sal,deptno,empno FROM EMP_TEST
WHERE TO_DATE(HIREDATE,'YY/MM/DD') BETWEEN TO_DATE('81/04/03','YY-MM-DD') AND TO_DATE('82/12/08','YY-MM-DD');
SELECT ename,sal,deptno,empno FROM EMP_TEST
WHERE TO_DATE(HIREDATE,'YY/MM/DD') > TO_DATE('81/04/2','YY-MM-DD')
AND TO_DATE(HIREDATE,'YY/MM/DD') < TO_DATE('82/12/09','YY-MM-DD');
--12. �޿��� 1,600 ���� ũ��, $3,000 ���� ���� ����� �̸�,����,�޿��� ����϶�.
SELECT ename,job,sal FROM EMP_TEST WHERE sal BETWEEN 1601 AND 2999;
SELECT ename,job,sal FROM EMP_TEST WHERE sal > 1600 AND sal < 3000;
--13. �̸��� B�� J������ ��� ����� �̸��� ����϶�.
SELECT ename FROM EMP_TEST WHERE ename BETWEEN 'B%' AND 'J%';
--14. �Ի����� 81���� �ƴ� ����� �Ի��ϰ� �̸��� ����϶�.
SELECT hiredate,ename FROM EMP_TEST WHERE TO_NUMBER(TO_CHAR(hiredate,'YYYY')) != 1981;
SELECT hiredate,ename FROM EMP_TEST WHERE TO_CHAR(hiredate,'YYYY') != '1981';
SELECT hiredate,ename FROM EMP_TEST WHERE hiredate NOT LIKE '%81%';
--15. ������ MANAGER�̰ų� SALESMAN�� ����� �̸��� ������ ����϶�.
SELECT ename,job FROM EMP_TEST WHERE job = 'MANAGER' OR job = 'SALESMAN';
--16. �μ���ȣ�� 20,30 ���� ������ ��� ����� �̸�,�����ȣ,�μ���ȣ�� ����϶�.
SELECT ename,empno,deptno FROM EMP_TEST WHERE deptno != 20 AND deptno != 30;
SELECT ename,empno,deptno FROM EMP_TEST WHERE deptno NOT IN(20,30);
--17. �̸��� S�� �����ϴ� ����� �����ȣ,�̸�,�Ի���,�μ���ȣ�� ����϶�
SELECT empno,ename,hiredate,deptno FROM EMP_TEST WHERE ename LIKE 'S%';
--18. �Ի����� 81�⵵�� ����� �Ի���,�̸��� ����϶�
SELECT hiredate,ename FROM EMP_TEST WHERE TO_NUMBER(TO_CHAR(hiredate,'YYYY')) = 1981;
SELECT hiredate,ename FROM EMP_TEST WHERE TO_CHAR(hiredate,'YYYY') = '1981';
SELECT hiredate,ename FROM EMP_TEST WHERE hiredate LIKE '%81%';
--19. �̸� �� A�ڰ� �� �ִ� ����� �����ȣ,�̸��� ����϶�.
SELECT empno,ename FROM EMP_TEST WHERE ename LIKE '%A%';
--20. �̸��� S�� �����ϰ� ������ ���ڰ� H�� ����� �̸��� ����϶�.
SELECT empno,ename FROM EMP_TEST WHERE ename LIKE 'S%H';
--21. �̸��� �ι�° ���ڰ� A�� ����� �̸��� ����϶�.
SELECT ename FROM EMP_TEST WHERE ename LIKE '_A%';
--22. Ŀ�̼��� NULL�� ����� �̸��� Ŀ�̼��� ����϶�.
SELECT ename,comm FROM EMP_TEST WHERE comm IS NULL;
--23. Ŀ�̼��� NULL�� �ƴ� ����� �̸��� Ŀ�̼��� ����϶�.
SELECT ename,comm FROM EMP_TEST WHERE comm IS NOT NULL;
--24. �μ���ȣ�� 30�� �μ��̰�,�޿��� 1500 �̻��� ����� �̸�,�μ���ȣ,������ ����϶�.
SELECT ename,deptno,sal FROM EMP_TEST WHERE deptno = 30 AND sal >= 1500;
--25. �̸��� ù ���ڰ� K�� �����ϰų� �μ���ȣ�� 30�� ����� �����ȣ,�̸�,�μ���ȣ�� ����϶�.
SELECT empno,ename,deptno FROM EMP_TEST WHERE ename LIKE 'K%' OR DEPTNO = 30;
--26. �޿��� 1500 �̻��̰�,�μ���ȣ�� 30���� ����� ������ MANAGER�� ����� �޿�,�μ���ȣ,������ ����϶�.
SELECT sal,deptno,job FROM EMP_TEST WHERE sal >= 1500 AND deptno = 30 AND job = 'MANAGER';
--27. �μ���ȣ�� 30�� ����� �̸�,�����ȣ,�μ���ȣ�� �����ȣ�� ���������Ͽ���.
SELECT ename,empno,deptno FROM EMP_TEST WHERE deptno = 30 ORDER BY EMPNO ASC;
--28. �̸��� �޿��� �����͸� �޿��� ���� ������ �����϶�.
SELECT ename,sal FROM EMP_TEST ORDER BY sal DESC;
--29. �μ���ȣ�� �������� �������� �޿��� ���� ��������� �̸�,�μ���ȣ,�޿��� ����϶�.
SELECT ename,deptno,sal FROM EMP_TEST ORDER BY deptno ASC, sal DESC;
--30. �μ���ȣ�� �������� �������� ,���������� ��������,�޿������� ���������Ͽ���.
SELECT * FROM EMP_TEST ORDER BY deptno DESC, job ASC, sal DESC;
