--	기존 테이블 복사
--	EMP 우클릭 -> 데이터 내보내기 -> 데이터베이스 테이블 선택
--	-> 'Scott.emp' 선택 -> 하단 new table name 버튼 클릭
--	-> EMP_TEST -> NEXT -> NEXT 
--	EMP_TEST 테이블로 homework 진행
--기존 테이블의 데이터가 훼손될 수 있습니다.


--1. 부서번호가 10번인 부서의 사람중 사원번호, 이름,월급을 출력하여라. 
SELECT empno,ename,sal FROM EMP_TEST WHERE DEPTNO = 10;
--2. 사원번호가 7369인 사람의 이름,입사일,부서번호를 출력하라.
SELECT ename,hiredate,deptno FROM EMP_TEST WHERE empno = 7369;
--3. 이름이 ALLEN 인 사람의 모든 정보를 출력하라.
SELECT * FROM EMP_TEST WHERE ename = 'ALLEN';
--4. 입사일이 81/05/01인 사원의 이름,부서번호,월급을 출력하라.
SELECT ename,deptno,sal FROM EMP_TEST WHERE TO_DATE(HIREDATE,'YY/MM/DD') = TO_Date('81/05/01','YY/MM/DD');
--5. 직업이 MANAGER 가 아닌 사람의 모든 정보를 출력하라.
SELECT * FROM EMP_TEST WHERE job != 'MANAGER';
--6. 입사일이 81/04/02 이후에 입사한 사원의 정보를 출력하라.
SELECT * FROM EMP_TEST WHERE TO_DATE(HIREDATE,'YY/MM/DD') >= TO_DATE('81/04/02','YY-MM-DD'); 
--7. 급여가 $800 이상인 사람의 이름,급여,부서번호를 출력하라.
SELECT ename,sal,deptno FROM EMP_TEST WHERE sal >= 800;
--8. 부서번호가 20번 이상인 사원의 모든 정보를 출력하라.
SELECT * FROM EMP_TEST WHERE deptno >= 20;
--9. 입사일이 81/12/09 보다 먼저 입사한 사람들의 모든 정보를 출력하라.
SELECT * FROM EMP_TEST WHERE TO_DATE(HIREDATE,'YY/MM/DD') <= TO_DATE('81/12/09','YY-MM-DD'); 
--10. 입사번호가 7698 보다 작거나 같은 사람들의 사원번호와 이름을 출력하라.
SELECT empno,ename FROM EMP_TEST WHERE empno <= 7698;
--11. 입사일이 81/04/02 보다 늦고 82/12/09 보다 빠른 사원의 이름,월급,부서번호,사원번호를 출력하라.
SELECT ename,sal,deptno,empno FROM EMP_TEST
WHERE TO_DATE(HIREDATE,'YY/MM/DD') BETWEEN TO_DATE('81/04/03','YY-MM-DD') AND TO_DATE('82/12/08','YY-MM-DD');
SELECT ename,sal,deptno,empno FROM EMP_TEST
WHERE TO_DATE(HIREDATE,'YY/MM/DD') > TO_DATE('81/04/2','YY-MM-DD')
AND TO_DATE(HIREDATE,'YY/MM/DD') < TO_DATE('82/12/09','YY-MM-DD');
--12. 급여가 1,600 보다 크고, $3,000 보다 작은 사람의 이름,직업,급여를 출력하라.
SELECT ename,job,sal FROM EMP_TEST WHERE sal BETWEEN 1601 AND 2999;
SELECT ename,job,sal FROM EMP_TEST WHERE sal > 1600 AND sal < 3000;
--13. 이름이 B와 J사이의 모든 사원의 이름을 출력하라.
SELECT ename FROM EMP_TEST WHERE ename BETWEEN 'B%' AND 'J%';
--14. 입사일이 81년이 아닌 사람의 입사일과 이름을 출력하라.
SELECT hiredate,ename FROM EMP_TEST WHERE TO_NUMBER(TO_CHAR(hiredate,'YYYY')) != 1981;
SELECT hiredate,ename FROM EMP_TEST WHERE TO_CHAR(hiredate,'YYYY') != '1981';
SELECT hiredate,ename FROM EMP_TEST WHERE hiredate NOT LIKE '%81%';
--15. 직업이 MANAGER이거나 SALESMAN인 사람의 이름과 직업을 출력하라.
SELECT ename,job FROM EMP_TEST WHERE job = 'MANAGER' OR job = 'SALESMAN';
--16. 부서번호가 20,30 번을 제외한 모든 사람의 이름,사원번호,부서번호를 출력하라.
SELECT ename,empno,deptno FROM EMP_TEST WHERE deptno != 20 AND deptno != 30;
SELECT ename,empno,deptno FROM EMP_TEST WHERE deptno NOT IN(20,30);
--17. 이름이 S로 시작하는 사원의 사원번호,이름,입사일,부서번호를 출력하라
SELECT empno,ename,hiredate,deptno FROM EMP_TEST WHERE ename LIKE 'S%';
--18. 입사일이 81년도인 사람의 입사일,이름을 출력하라
SELECT hiredate,ename FROM EMP_TEST WHERE TO_NUMBER(TO_CHAR(hiredate,'YYYY')) = 1981;
SELECT hiredate,ename FROM EMP_TEST WHERE TO_CHAR(hiredate,'YYYY') = '1981';
SELECT hiredate,ename FROM EMP_TEST WHERE hiredate LIKE '%81%';
--19. 이름 중 A자가 들어가 있는 사람만 사원번호,이름을 출력하라.
SELECT empno,ename FROM EMP_TEST WHERE ename LIKE '%A%';
--20. 이름이 S로 시작하고 마지막 글자가 H인 사람의 이름을 출력하라.
SELECT empno,ename FROM EMP_TEST WHERE ename LIKE 'S%H';
--21. 이름의 두번째 문자가 A인 사람의 이름을 출력하라.
SELECT ename FROM EMP_TEST WHERE ename LIKE '_A%';
--22. 커미션이 NULL인 사람의 이름과 커미션을 출력하라.
SELECT ename,comm FROM EMP_TEST WHERE comm IS NULL;
--23. 커미션이 NULL인 아닌 사람의 이름과 커미션을 출력하라.
SELECT ename,comm FROM EMP_TEST WHERE comm IS NOT NULL;
--24. 부서번호가 30번 부서이고,급여가 1500 이상인 사람의 이름,부서번호,월급을 출력하라.
SELECT ename,deptno,sal FROM EMP_TEST WHERE deptno = 30 AND sal >= 1500;
--25. 이름의 첫 글자가 K로 시작하거나 부서번호가 30인 사람의 사원번호,이름,부서번호를 출력하라.
SELECT empno,ename,deptno FROM EMP_TEST WHERE ename LIKE 'K%' OR DEPTNO = 30;
--26. 급여가 1500 이상이고,부서번호가 30번인 사원중 직업이 MANAGER인 사람의 급여,부서번호,직업을 출력하라.
SELECT sal,deptno,job FROM EMP_TEST WHERE sal >= 1500 AND deptno = 30 AND job = 'MANAGER';
--27. 부서번호가 30인 사람의 이름,사원번호,부서번호를 사원번호로 오름정렬하여라.
SELECT ename,empno,deptno FROM EMP_TEST WHERE deptno = 30 ORDER BY EMPNO ASC;
--28. 이름과 급여의 데이터를 급여가 많은 순으로 정렬하라.
SELECT ename,sal FROM EMP_TEST ORDER BY sal DESC;
--29. 부서번호로 오름차순 정렬한후 급여가 많은 사람순으로 이름,부서번호,급여를 출력하라.
SELECT ename,deptno,sal FROM EMP_TEST ORDER BY deptno ASC, sal DESC;
--30. 부서번호를 내림차순 정렬한후 ,직업순으로 오름정렬,급여순으로 내림정렬하여라.
SELECT * FROM EMP_TEST ORDER BY deptno DESC, job ASC, sal DESC;
