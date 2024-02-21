-- day06

/*
    WHERE 절에 사용되는 서브질의
        1. 서브질의의 결과가 단일행 단일컬럼으로 조회되는 경우
        ==> 일반 데이터 입력하는 형식으로 사용하면 된다.
            
            예 ]
                'SMITH' 사원과 같은 부서의 사원들 사원이름, 직급, 부서번호를 조회하세요.
                
                SELECT
                    ename 사원이름, job 직급, deptno 부서번호
                FROM
                    emp
                WHERE
                    deptno = (
                                SELECT
                                    deptno
                                FROM
                                    emp
                                WHERE
                                    ename = 'SMITH'
                            )
                ;
                
        2. 서브질의의 결과가 다중행 단일컬럼으로 조회되는 경우
        ==> 데이터가 여러개 조회되는 경우이므로
            다중값 비교연산자로 처리해야 한다.
            
            IN
            ==> 여러개의 데이터중 하나만 맞으면 되는 경우
                사용할 수 있는 연산자는 없고 
                묵시적으로 동등비교연산을 한다.
                
                형식 ]
                    컬럼이름 IN (서브질의)
                    
            ANY
            ==> 여러개의 데이터중 하나만 맞으면 되는 경우
                사용할 수 있는 연산자는 모든 비교연산자를 사용할 수 있다.
                
                형식 ]
                    
                    컬럼이름 = ANY ( 다중행 단일컬럼 서브질의)
                    컬럼이름 >= ANY ( 다중행 단일컬럼 서브질의 )
                                    
            ALL
            ==> 여러개의 데이터가 모두 조건에 맞아야 되는 경우
            
            참고 ]
                조건처리는 크다(>), 작다(<)등과 같은 비교도 가능하다.
            
            
        3. 서브질의의 결과가 다중행 다중컬럼으로 조회되는 경우
            
            EXISTS
            ==> 서브질의의 결과가 존재하면 true 로 처리고
                없으면 false로 처리되는 연산자
                비교할 컬럼을 기술하지 않는다.
        
*/

-- 10번부서 사원들과 같은 직급의 사원들의 사원이름, 직급을 조회하세요.
SELECT
    ename 사원이름, job 직급
FROM
    emp
WHERE
    job IN (
                SELECT
                    job
                FROM
                    emp
                WHERE
                    deptno = 10
            )
;

-- 부서의 평균급여중 한 부서라도 급여가 높은 사원의 사원이름, 직급, 급여를 조회하세요.

SELECT
    AVG(sal)
FROM
    emp
GROUP BY
    deptno
;

SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    sal > ANY (
                    SELECT
                        AVG(sal)
                    FROM
                        emp
                    GROUP BY
                        deptno
                )
ORDER BY
    사원이름
;

-- 모든 부서의 평균급여보다 급여가 높은 사원의 사원이름, 직급, 급여를 조회하세요.
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    sal > ALL (
                    SELECT
                        AVG(sal)
                    FROM
                        emp
                    GROUP BY
                        deptno
                )
ORDER BY
    사원이름
;

-- 이번달에 커미션을 지급할 예정인데 'smith' 사원이 근무하고 있으면
-- 모든 사원의 커미션을 20% 인상해서 지급하고 없으면 지급하지 않는다.
-- 단, 커미션이 없는 사원은 200으로 하고 계산하기로 한다.
SELECT
    ename 사원이름, sal 급여, NVL2(comm, comm * 1.2, 200 * 1.2) 지급커미션
FROM
    emp
WHERE
    EXISTS (
                SELECT
                    *
                FROM
                    emp
                WHERE
                    ename = 'smith'
            )
;

/*
    직급이 'MANAGER'인 사원들보다 급여가 한 명이라도 급여가 높은사원의 
    사원이름, 직급, 급여를 조회하세요.
*/

SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    sal > ANY (
                    SELECT
                        sal
                    FROM
                        emp
                    WHERE
                        job = 'MANAGER'
            )
;

/*
    직급이 'MANAGER'인 모든 사원들의 급여보다 급여가 높은사원의 
    사원이름, 직급, 급여를 조회하세요.
*/

SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    sal > ALL  (
                    SELECT
                        sal
                    FROM
                        emp
                    WHERE
                        job = 'MANAGER'
                )
;
