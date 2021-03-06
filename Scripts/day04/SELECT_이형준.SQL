﻿--1 부서번호가 10번인 부서의 사람중 사원번호, 이름,월급을 출력하여라. 
SELECT empno, ename, SAL FROM emp WHERE DEPTNO = 10;
--2 사원번호가 7369인 사람중 이름,입사일,부서번호를 출력하라.
select ename, hiredate, deptno from emp where empno = 7369;
--3 이름이 ALLEN 인 사람의 모든 정보를 출력하라.
SELECT * FROM emp WHERE ename = 'ALLEN';
--4 입사일이 81/05/01인 사원의 이름,부서번호,월급을 출력하라.
SELECT ename, deptno, sal FROM emp WHERE to_char(HIREDATE, 'yyyymmdd') > '19810402';
--5 직업이 MANAGER 가 아닌 사람의 모든 정보를 출력하라.
SELECT * FROM emp WHERE job != 'MANAGER';
--6 입사일이 81/04/02 이후에 입사한 사원의 정보를 출력하라.
SELECT * FROM emp WHERE to_char(HIREDATE, 'yyyymmdd') > '19810402';
--7. 급여가 $800 이상인 사람의 이름,급여,부서번호를 출력하라.
SELECT ename, sal, DEPTNO FROM emp WHERE sal >= 800;
--8. 부서번호가 20번 이상인 사원의 모든 정보를 출력하라.
SELECT * FROM emp WHERE DEPTNO = 20;
--9. 입사일이 81/12/09 보다 먼저 입사한 사람들의 모든 정보를 출력하라.
SELECT * FROM emp WHERE to_char(HIREDATE, 'yyyymmdd') < '19811209'; 
--10. 입사번호가 7698 보다 작거나 같은 사람들의 입사번호와 이름을 출력하라.
SELECT empno, ename FROM emp WHERE EMPNO <= 7698; 
--11. 입사일이 81/04/02 보다 늦고 82/12/09 보다 빠른 사원의 이름,월급,부서번호,입사번호를 출력하라.
SELECT ename, sal, DEPTNO, empno, HIREDATE FROM emp WHERE 
to_char(HIREDATE, 'yyyymmdd') > '19810402' AND to_char(HIREDATE, 'yyyymmdd') < '19821209'; 
--12. 급여가 1,600 보다 크고, $3,000 보다 작은 사람의 이름,직업,급여를 출력하라.
SELECT ename, job, sal FROM emp WHERE sal > 1600 AND sal < 3000; 
--13. 이름이 B와 J사이의 모든 사원의 이름을 출력하라.
SELECT ename FROM emp WHERE ename BETWEEN 'B' AND 'J';
--14. 입사일이 81년 이외에 입사한 사람의 입사일과 이름을 출력하라.
SELECT ename, HIREDATE FROM emp WHERE to_char(HIREDATE, 'yyyy') != '1981';
--15. 직업이 MANAGER와 SALESMAN인 사람의 이름과 직업을 출력하라.
SELECT ename, job FROM emp WHERE job = 'MANAGER' or job = 'SALESMAN';
--16. 부서번호가 20,30 번을 제외한 모든 사람의 이름,사원번호,부서번호를 출력하라.
SELECT ename, EMPNO , DEPTNO FROM emp WHERE deptno != 20 AND DEPTNO !=30;
--17. 이름이 S로 시작하는 사원의 사원번호,이름,입사일,부서번호를 출력하라
SELECT empno, ename, HIREDATE, DEPTNO FROM emp WHERE ename LIKE 'S%';
--18. 입사일이 81년도인 사람의 입사일,이름을 출력하라
SELECT ename, HIREDATE FROM emp WHERE to_char(HIREDATE, 'yyyy') = '1981';
--19. 이름 중 A자가 들어가 있는 사람만 입사번호,이름을 출력하라.
SELECT empno, ename FROM emp WHERE ename LIKE '%A%';
--20. 이름이 S로 시작하고 마지막 글자가 T인 사람의 이름을 출력하라. <-- null
SELECT empno, ename FROM emp WHERE ename LIKE 'S%H'; --스미스형님
--21. 이름의 두번째 문자가 A인 사람의 이름을 출력하라.
SELECT ename FROM emp WHERE ename LIKE '_A%';
--22. 커미션이 NULL인 사람의 이름과 커미션을 출력하라.
SELECT ename, comm FROM emp WHERE comm  IS null;
--23. 커미션이 NULL인 아닌 사람의 이름과 커미션을 출력하라.
SELECT ename, comm FROM emp WHERE comm  IS NOT null;
--24. 부서번호가 30번 부서이고,급여가 1500 이상인 사람의 이름,부서번호,월급을 출력하라.
SELECT ename, DEPTNO, sal FROM emp WHERE DEPTNO =30 AND sal >= 1500;
--25. 이름의 첫 글자가 K로 시작하거나 부서번호가 30인 사람의 사원번호,이름,부서번호를 출력하라.
SELECT EMPNO , ename, DEPTNO FROM emp WHERE ename LIKE 'K%' OR DEPTNO =30;
--26. 급여가 1500 이상이고,부서번호가 30번인 사원중 직업이 MANAGER인 사람의 급여,부서번호,직업을 출력하라.
SELECT sal, DEPTNO, job FROM emp WHERE sal >= 1500 AND DEPTNO = 30 AND job = 'MANAGER';
--27. 부서번호가 30인 사람의 이름,사원번호,부서번호를 사원번호로 오름정렬하여라.
SELECT ename, deptno, empno FROM emp WHERE DEPTNO = 30 ORDER BY EMPNO asc;
--28. 이름과 급여의 데이터를 급여가 많은 순으로 정렬하라.
SELECT ename, sal FROM emp ORDER BY sal desc;
--29. 부서번호로 오름차순 정렬한후 급여가 많은 사람순으로 이름,부서번호,급여를 출력하라.
SELECT ename, DEPTNO, sal FROM emp ORDER BY DEPTNO ASC, sal desc;
--30. 부서번호를 내림차순 정렬한후 ,직업순으로 오름정렬,급여순으로 내림정렬하여라.
SELECT DEPTNO FROM emp ORDER BY DEPTNO Desc, job ASC, sal desc;