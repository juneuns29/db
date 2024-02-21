/*
    1. 
        직급이 'MANAGER'인 사원들의
        사원이름, 직급, 입사일, 급여, 부서이름
        을 조회하세요.
*/

/*
    2. 
        급여가 가장 낮은 사원의
        사원이름, 직급, 입사일, 급여, 부서이름, 부서위치를 조회하세요.
*/

/*
    3. 
        사원들의
            사원이름, 직급, 입사년도, 부서번호, 부서이름, 급여, 급여등급, 
            상사이름, 상사직급, 상사급여, 상사급여등급
        을 조회하세요. 
        단, 81년 입사한 사원만 조회하세요.
*/
SELECT
    e.ename 사원이름, e.job 직급, TO_CHAR(e.hiredate, 'YYYY') 입사년도, 
    e.deptno 부서번호, dname 부서이름, e.sal 급여, s1.grade 급여등급, 
    s.ename 상사이름, s.job 상사직급, s.sal 상사급여, s2.grade 상사급여등급
FROM
    emp e, -- 사원정보
    dept d, 
    salgrade s1, -- 사원급여등급 
    emp s, -- 상사정보
    salgrade s2 -- 상사급여등급
WHERE
    e.mgr = s.empno(+)
    AND e.sal BETWEEN s1.losal AND s1.hisal
    AND s.sal BETWEEN s2.losal AND s2.hisal
    AND e.deptno = d.deptno
    -- 일반조건
    AND TO_CHAR(e.hiredate, 'YYYY') = '1981'
;
/*
    4. 
        이름의 글자 수가 5인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급
        을 조회하세요.
*/


/*
    5. 
        사원들 중 입사년도가 81년이고 직급이 'MANAGER'인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급,
            부서이름, 부서위치
        를 조회하세요.
*/

/*
    6. 
        사원들의
            사원이름, 직급, 급여, 상사이름, 급여등급
        을 조회하세요.
*/


/*
    7. 
        사원들의
            사원이름, 직급, 급여, 상사이름, 부서이름, 부서위치, 급여등급
        을 조회하세요.
        단, 급여가 전체평균급여보다 많은 사원만 조회하세요.
*/


SELECT
    e.ename 사원이름, e.job 직급, e.sal 급여, s.ename 상사이름, 
    dname 부서이름, loc 부서위치, grade 급여등급
FROM
    emp e, dept d, salgrade, emp s,
    -- 전체 평균급여
    (
        SELECT
            AVG(sal) avg
        FROM
            emp
    )
WHERE
    e.mgr = s.empno(+)
    AND e.sal BETWEEN losal AND hisal
    AND e.deptno = d.deptno
    AND e.sal > avg
ORDER BY
    grade DESC
;

--- 여기서부터 인라인 뷰를 이용해서 처리할 것.
/*
    8. 
        사원들 중 부서 최소급여자들의
            사원번호, 사원이름, 직급, 상사이름, 급여, 급여등급, 부서이름,
            부서평균급여, 부서최소급여, 부서원수
        를 조회하세요.
*/

/*
    9. 
        사원들 중 부서원수가 제일 적은 부서에 속한 사원들의
            사원이름, 급여, 급여등급, 부서급여합계, 부서원수
        를 조회하세요.
*/

/*
    10.
        사원들 중 부서평균급여보다 급여가 적은 사원들의
            사원이름, 직급, 급여, 부서이름, 부서평균급여, 부서원수
        를 조회하세요.
*/




















