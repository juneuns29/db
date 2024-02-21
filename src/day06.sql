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

--------------------------------------------------------------------------------
/*
    서브질의의 결과를 테이블 처럼 사용할 수 있다.
    이렇게 FROM 절에 포함된 서브질의를 가리켜 "인라인 뷰" 라고 부른다.
    
    형식 ]
        SELECT
            컬럼이름들...
        FROM
            ( 서브질의 ) [별칭]
        ;
        
    참고 ]
        인라인 뷰의 SELECT 절에 함수가 사용될때는 반드시 별칭을 부여해야 한다.
        인라인 뷰의 SELECT 절에 별칭들이 붙여지면
        컬럼이름은 별칭으로 고정된다.
*/

-- 부서별 부서번호, 급여합계, 평균급여, 최대급여, 최소급여, 사원수 를 
-- 인라인 뷰를 이용해서 조회하세요.
SELECT
    *
FROM
    (
        SELECT
            deptno dno, SUM(sal), AVG(sal), MAX(sal), MIN(sal), COUNT(*)
        FROM
            emp
        GROUP BY
            deptno
    )
;

SELECT
    dno 부서번호, sumSal 급여합계, TRUNC(avgSal, 2) 평균급여, 
    maxSal 최대급여, minSal 최소급여, cnt 사원수
FROM
    (
        SELECT
            deptno dno, SUM(sal) sumSal, AVG(sal) avgSal, 
            MAX(sal) maxSal, MIN(sal) minSal, COUNT(*) cnt
        FROM
            emp
        GROUP BY
            deptno
    )
;

--------------------------------------------------------------------------------
/*
    조인(JOIN)
    ==> 두 개 이상의 테이블에서 원하는 데이터를 조회하는 방법
    
        데이터베이스 설계시 데이터의 무결성 확보를 위해서
        테이블을 분리해서 만들어 놓았다.
        이때 분리된 데이터를 합쳐서 조회해야 하는 경우가 발생할 수 있다.
        그때 분리된 데이터를 가져오는 방법이다.
        
        형식 ]
            SELECT
                컬럼이름들...
            FROM
                테이블1, 테이블2, ...
            WHERE
                조인조건식1
                AND 조인조건식2
                ...
            ;
            
        오라클은 관계형 데이터베이스이다.
        관계형 데이터베이스는 엔티티 간의 관계를 형성해서 데이터를 보관하는 데이터베이스이다.
        
        그래서 분리된 엔티티들에서 데이터를 꺼내오면
        컴퓨터는 어떤 데이터가 연결되어있는 데이터인지를 알 수 없으므로
        모든 가능한 조합을 만들어서 조회가 된다.
        이 조회된 모든 가능한 조합의 결과를 Cartesian Product(데카르트 곱)이라고 한다.
        이런 조인을 
            Cross Join
        이라고 부른다.
        
    조인의 종류 ]
        Cross Join
        ==> Cartesian Product 를 조회하는 조인
            일반적으로 사용하지 않는 조인
            
        Inner Join
        ==> Cartesian Product 내에서 걸러내서 하는 조인
        
        Outer Join
        ==> Cartesian Product 내에 없는 데이터를 조회하는 조인
        
        EQUI JOIN
        ==> 조인 조건을 동등비교연산으로 처리하는 조인
        
        NON EQUI JOIN
        ==> 조인 조건이 동등비교연산이 아닌 조인
        
        SELF JOIN
        ==> 조인을 할 때 같은 테이블을 두번이상 이용해서 하는 조인
        
    참고 ]
        조인할 때 WHERE절에 조인 조건 이외의 다른 일반조건을 기술할 수 있다.
        
*/

-------------------------------------------------------------------------------

CREATE TABLE ecolor (
    cno NUMBER(5) 
        CONSTRAINT ECOLOR_NO_PK PRIMARY KEY,
    ecname VARCHAR2(20 CHAR)
        CONSTRAINT ECOLOR_NAME_UK UNIQUE
        CONSTRAINT ECOLOR_NAME_NN NOT NULL,
    code CHAR(7)
        CONSTRAINT ECOLOR_CODE_UK UNIQUE
        CONSTRAINT ECOLOR_CODE_NN NOT NULL
);


CREATE TABLE kcolor (
    cno NUMBER(5) 
        CONSTRAINT KCOLOR_NO_PK PRIMARY KEY,
    kcname VARCHAR2(20 CHAR)
        CONSTRAINT KCOLOR_NAME_UK UNIQUE
        CONSTRAINT KCOLOR_NAME_NN NOT NULL,
    code CHAR(7)
        CONSTRAINT KCOLOR_CODE_UK UNIQUE
        CONSTRAINT KCOLOR_CODE_NN NOT NULL
);

INSERT INTO 
    ecolor
VALUES(
    10, 'RED', '#FF0000'
);

INSERT INTO 
    ecolor
VALUES(
    20, 'GREEN', '#00FF00'
);

INSERT INTO 
    ecolor
VALUES(
    30, 'BLUE', '#0000FF'
);


INSERT INTO 
    kcolor
VALUES(
    10, '빨강', '#FF0000'
);

INSERT INTO 
    kcolor
VALUES(
    20, '초록', '#00FF00'
);

INSERT INTO 
    kcolor
VALUES(
    30, '파랑', '#0000FF'
);

commit;

--------------------------------------------------------------------------------
SELECT
    *
FROM
    ecolor e, kcolor k
;

SELECT
    *
FROM
    ecolor e, kcolor k
WHERE
    e.cno = k.cno
;

SELECT
    e.cno 칼라번호, ecname 영문칼라이름, 
    kcname 한글칼라이름, k.code 칼라코드
FROM
    ecolor e, kcolor k
WHERE
    e.cno = k.cno -- 조인조건. INNER JOIN, EQUI JOIN
;

-- 사원들의 사원이름, 직급, 부서이름 을 조회하세요.
SELECT
    ename, job, e.deptno, d.deptno, dname
FROM
    emp e, dept d
;

SELECT
    ename, job, e.deptno, d.deptno, dname
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
;

-- 일반조건과 같이 사용할 수 있다.
-- 81년 입사한 사원의 사원이름, 직급, 입사년도, 부서위치를 조회하세요.
SELECT
    ename 사원이름, job 직급, TO_CHAR(hiredate, 'YYYY') 입사년도, loc 부서위치
FROM
    emp e, dept d
WHERE
    -- 조인조건
    e.deptno = d.deptno
    AND TO_CHAR(hiredate, 'YY') = '81'
;

-- NON EQUI JOIN - 조인조건에 사용하는 연산자가 대소비교를 하는 경우
-- 사원들의 사원이름, 직급, 급여, 급여등급 을 조회하세요.
SELECT
    ename, job, sal, losal, hisal, grade
FROM
    emp, salgrade
;

SELECT
    ename, job, sal, losal, hisal, grade
FROM
    emp, salgrade
WHERE
    -- 조인조건
    sal >= losal
    AND sal <= hisal
;

SELECT
    ename 사원이름, job 직급, sal 급여, grade 급여등급
FROM
    emp, salgrade
WHERE
    -- 조인조건
--    sal >= losal AND sal <= hisal
    sal BETWEEN losal AND hisal
;

-- 여러개의 조인을 동시에 적용해서 조회할 수 있다.
/*
    사원들의
        사원이름, 직급, 급여, 부서번호, 부서이름, 급여등급
    을 조회하세요.
*/
SELECT
    ename, job, sal, d.deptno, dname, grade, losal, hisal
FROM
    emp e, dept d, salgrade
WHERE
    -- 사원정보와 부서정보 조인
    e.deptno = d.deptno
    -- 위까지 결과와 급여등급정보 조인
    AND sal BETWEEN losal AND hisal
;

-- 30번 부서 사원들의 사원이름, 직급, 부서위치, 급여, 급여등급을 조회하세요.
SELECT
    ename 사원이름, job 직급, loc 부서위치, sal 급여, grade 급여등급
FROM
    emp e, dept d, salgrade
WHERE
    -- 급여등급과 사원정보 조인
    sal BETWEEN losal AND hisal
    -- 위 결과와 부서정보 조인
    AND e.deptno = d.deptno
    
    -- 일반조건
    AND e.deptno = 30
;

-- SELF JOIN
-- 사원들의 사원이름, 직급, 상사번호, 상사이름 을 조회하세요.

-- 서브질의로 처리하는 방법
SELECT
    ename 사원이름, job 직급, mgr 상사번호, 
    (
        SELECT
            ename
        FROM
            emp
        WHERE
            empno = e.mgr
    ) 상사이름
FROM
    emp e
;

-- 조인을 이용하는 방법
SELECT
    e.ename 사원이름, e.job 직급, e.mgr 상사번호, s.empno, s.ename 상사이름
FROM
    emp e, -- 사원정보테이블
    emp s -- 상사정보테이블
WHERE
    e.mgr = s.empno
;

-- 여기까지가 모두 INNER JOIN
--------------------------------------------------------------------------------

-- OUTER JOIN : Cartesian Product 내에 없는 데이터를 조인하는 방법
-- 형식 ] null 로 표현되어야 할 테이블 컬럼에 "(+)" 를 붙여준다.
SELECT
    e.ename 사원이름, e.job 직급, e.mgr 상사번호, s.empno, NVL(s.ename, '상사없음') 상사이름
FROM
    emp e, -- 사원정보테이블
    emp s -- 상사정보테이블
WHERE
    e.mgr = s.empno(+)
;

SELECT
    e.ename 사원이름, e.job 직급, e.mgr 상사번호, s.empno, NVL(s.ename, '상사없음') 상사이름
FROM
    emp e, -- 사원정보테이블
    emp s -- 상사정보테이블
WHERE
    e.mgr(+) = s.empno
; -- 사원들의 정보와 상사가 아닌 사원도 조회

/*
    사원들의
        사원이름, 직급, 입사년도, 부서번호, 부서이름, 급여, 급여등급, 
        상사이름, 상사직급, 상사급여
    을 조회하세요. 
    단, 82년 입사한 사원만 조회하세요.
*/

SELECT
    e.ename 사원이름, e.job 직급, TO_CHAR(e.hiredate, 'YYYY') 입사년도, 
    e.deptno 부서번호, dname 부서이름, e.sal 급여, grade 급여등급, 
    s.ename 상사이름, s.job 상사직급, s.sal 상사급여
FROM
    emp e, -- 사원정보
    dept d, salgrade, 
    emp s -- 상사정보
WHERE
    e.mgr = s.empno(+)
    AND e.sal BETWEEN losal AND hisal
    AND e.deptno = d.deptno
    -- 일반조건
    AND TO_CHAR(e.hiredate, 'YYYY') = '1982'
;








