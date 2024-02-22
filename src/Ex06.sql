/*
    1. 
        직급이 'MANAGER'인 사원들의
        사원이름, 직급, 입사일, 급여, 부서이름
        을 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, HIREDATE 입사일, sal 급여, dname 부서이름
FROM
    emp e, dept d
WHERE
    -- 조인조건
    e.deptno = d.deptno
    AND job = 'MANAGER'
;
/*
    2. 
        급여가 가장 낮은 사원의
        사원이름, 직급, 입사일, 급여, 부서이름, 부서위치를 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여, 
    dname 부서이름, loc 부서위치
FROM
    emp e, dept d
WHERE
    -- 조인조건
    e.deptno = d.deptno
    AND sal = (
                    SELECT
                        MIN(sal)
                    FROM
                        emp
                )
;

SELECT
    MIN(sal)
FROM
    emp
;
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
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여, grade 급여등급
FROM
    emp, salgrade
WHERE
    -- 조인조건
    sal BETWEEN losal AND hisal
    -- 일반조건
    AND LENGTH(ename) = 5
;

/*
    5. 
        사원들 중 입사년도가 81년이고 직급이 'MANAGER'인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급,
            부서이름, 부서위치
        를 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여, grade 급여등급,
    dname 부서이름, loc 부서위치
FROM
    emp e, dept d, salgrade
WHERE
    -- 조인조건
    e.deptno = d.deptno
    AND sal BETWEEN losal AND hisal
    -- 일반조건
    AND TO_CHAR(hiredate, 'YY') = '81'
    AND job = 'MANAGER'
;
/*
    6. 
        사원들의
            사원이름, 직급, 급여, 상사이름, 급여등급
        을 조회하세요.
*/
SELECT
    e.ename 사원이름, e.job 직급, e.sal 급여, NVL(s.ename, '상사없음') 상사이름, grade 급여등급
FROM
    emp e, -- 사원정보테이블
    emp s, -- 상사정보테이블
    salgrade -- 급여등급 테이블
WHERE
    e.mgr = s.empno(+)
    AND e.sal BETWEEN losal AND hisal
;

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
    emp e, emp s, dept d, salgrade
WHERE
    -- 조인조건
    e.mgr = s.empno(+)
    AND e.deptno = d.deptno
    AND e.sal BETWEEN losal AND hisal
    -- 일반조건
    AND e.sal > (
                    SELECT
                        AVG(sal)
                    FROM
                        emp
                )
ORDER BY -- 정렬
    e.sal DESC
;

SELECT
    e.ename 사원이름, e.job 직급, e.sal 급여, s.ename 상사이름, 
    dname 부서이름, loc 부서위치, grade 급여등급
FROM
    emp e, emp s, dept d, salgrade,
    (
        SELECT
            AVG(sal) avg
        FROM
            emp
    ) -- 이 테이블(인라인 뷰)은 1행으로 되어있으므로 굳이 조인하지 않아도 된다.
WHERE
    -- 조인조건
    e.mgr = s.empno(+)
    AND e.deptno = d.deptno
    AND e.sal BETWEEN losal AND hisal
    -- 일반조건
    AND e.sal > avg
ORDER BY -- 정렬
    e.sal DESC
;

--- 여기서부터 인라인 뷰를 이용해서 처리할 것.
/*
    8. 
        사원들 중 부서 최소급여자들의
            사원번호, 사원이름, 직급, 상사이름, 급여, 급여등급, 부서이름,
            부서평균급여, 부서최소급여, 부서원수
        를 조회하세요.
*/
-- 부서들의 집계를 해놓은 테이블
SELECT
    deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
FROM
    emp
GROUP BY
    deptno
;

SELECT
    e.empno 사원번호, e.ename 사원이름, e.job 직급, s.ename 상사이름, e.sal 급여, 
    grade 급여등급, dname 부서이름,
    TRUNC(avg, 2) 부서평균급여, min 부서최소급여, cnt 부서원수
FROM
    emp e, emp s, salgrade, dept d,
    (
        SELECT
            deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
    -- 조인조건
    e.mgr = s.empno(+)
    AND e.sal BETWEEN losal AND hisal
    AND e.deptno = d.deptno
    AND e.deptno = dno
    -- 일반조건
    AND e.sal = min
;
/*
    9. 
        사원들 중 부서원수가 제일 적은 부서에 속한 사원들의
            사원이름, 급여, 급여등급, 부서급여합계, 부서원수
        를 조회하세요.
*/
SELECT
    MIN(COUNT(*))-- 최소부서원수
FROM
    emp
GROUP BY
    deptno
;

SELECT
    ename 사원이름, sal 급여, grade 급여등급, sum 부서급여합계, cnt 부서원수
FROM
    emp, salgrade,
    (
        SELECT
            deptno dno, SUM(sal) sum, COUNT(*) cnt
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
    -- 조인조건
    sal BETWEEN losal AND hisal
    AND deptno = dno
    -- 일반조건 : 최소사원수의 부서 찾기 ==> cnt 가 최소인 행 걸러내기
    AND cnt = (
                    SELECT
                        MIN(COUNT(*))-- 최소부서원수
                    FROM
                        emp
                    GROUP BY
                        deptno
                )
;

/*
    10.
        사원들 중 부서평균급여보다 급여가 적은 사원들의
            사원이름, 직급, 급여, 부서이름, 부서평균급여, 부서원수
        를 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, sal 급여, dname 부서이름, TRUNC(avg, 2) 부서평균급여, cnt 부서원수
FROM
    emp e, dept d, 
    (
        SELECT
            deptno dno, AVG(sal) avg, COUNT(*) cnt
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
    -- 조인조건
    e.deptno = d.deptno
    AND d.deptno = dno
    -- 일반조건
    AND sal < avg
;




















