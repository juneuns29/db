/*
    사원들의 
        사원이름, 부서번호
    를 조회하세요.
*/
SELECT
    ename 사원이름, deptno 부서번호
FROM
    emp
;

/*
    사원들의 부서번호를 조회하세요.
    단, 중복되는 부서번호는 한번만 조회되게 하세요.
*/
SELECT
    DISTINCT deptno
FROM
    emp
;
/*
    사원들의
        사원이름, 직급, 연봉 을 조회하세요.
    연봉은 급여 * 12로 계산하세요.
*/

/*
    사원들의 사원이름, 급여, 커미션, 연봉을 조회하세요.
    연봉은 급여 * 12 + 커미션으로 계산하세요.
    커미션이 없는 사원은 커미션을 50을 지급하는 것으로 계산하세요.
        * nvl() 로 처리하는 문제
*/

/*
    사원들의 사원번호, 사원이름, 직급을 조회하세요.
    사원이름은 이름뒤에 ' 사원' 붙여져서 조회하세요.
*/

--------------------------------------------------------------------------------
/*
    부서번호가 20번인 사원들의
    사원번호, 사원이름, 직급, 부서번호
    를 조회하세요.
*/

/*
    직급이 'SALESMAN'인 사원들의 
    사원이름, 직급, 부서번호를 조회하세요.
*/


/*
    급여가 1000 미만인 사원들의
    사원번호, 사원이름, 급여를 조회하세요.
*/


/*
    입사일이 81년 9월 8일인 사원의
    사원이름, 직급, 입사일
    을 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, TO_CHAR(hiredate, 'YYYY"년" MM"월" DD"일"') 입사일
FROM
    emp
WHERE
    hiredate = TO_DATE('1981-09-08', 'YYYY-MM-DD')
;

/*
    사원의 이름이 'M' 이후 문자로 시작하는 사원중
    급여가 1000 이상인 사원의
    사원이름, 직급, 급여를 조회하세요.
*/


/*
    직급이 'MANAGER'이고 급여가 1000보다 높고
    부서번호가 10번인 사원의 
    사원이름, 직급, 급여, 부서번호
    를 조회하세요.
*/


/*
    직급이 'MANAGER'가 아닌 사원들의
    사원이름, 직급, 입사일을 조회하세요.
    
    NOT 연산자 사용해서 처리하세요.
*/


/*
    사원이름이 'C'로 시작하는 것보다 크고
    'M'으로 시작하는 것보다 작은 사원의
    사원이름, 직급, 급여를 조회하세요.
    
    BETWEEN - AND 연산자 사용하세요.
*/
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    ename BETWEEN 'D' AND 'LZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'
;

/*
    급여가 800, 950이 아닌 사원들의
    사원이름, 직급, 급여를 조회하세요.
    
    NOT IN 연산자 사용해서 처리하세요.
*/

/*
    사원이름이 'S'로 시작하고 
    이름 글자수가 5글자인 사원들의
    사원이름, 직급을 조회하세요.
*/


/*
    입사일이 3일인 사원들의
    사원이름, 직급, 입사일을 조회하세요.
*/


/*
    사원이름이 4글자 또는 5글자인 사원들의
    사원이름, 직급, 급여를 조회하세요.
*/


/*
    입사년도가 81년이거나 82년인 사원들의
    사원이름, 급여, 입사일을 조회하세요.
    단, 급여는 현재급여보다 10% 인상된 급여로 조회하세요.
*/
SELECT
    ename 사원이름, sal 급여, hiredate 입사일
FROM
    emp
WHERE
--    TO_CHAR(hiredate, 'YY') IN ('81', '82')
    hiredate LIKE '81/%'
    OR hiredate LIKE '82/%'
;

/*
    이름이 'S'로 끝나는 사원들의
    사원이름, 급여, 커미션을 조회하세요.
    단, 커미션은 현재 커미션보다 100 증가된 커미션으로 하고
    커미션이 없는 사원은 50으로 조회되게 하세요.
*/