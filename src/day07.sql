-- day07

/*
    ANSI JOIN
    ==> 
        질의 명령은 DBMS 회사들 만다 약간씩 그 문법이 달라진다.
        그러다보니 불펴한 것이 생겼고 그 불편함을 해결하고자
        미국 표준화 협회에서 표준 질의명령 문법을 지정해 놓았다.
        이것이 ANSI 형이라고 부르는 문법이다.
        
        조인역시 데이터베이스 회사들 마다 모두 달라질 수 있는데
        이것을 공통으로 사용할 수 있도록 문법을 만들어서 
        각 데이터베이스 마다 모두 사용할 수 있도록 해놓았다.
        이 조인형식을 ANSI JOIN 이라고 한다.
        
        1. CROSS JOIN
        ==> Cartesian Product 를 만들어내는 조인
        
            형식 ]
                SELECT
                    컬럼이름들...
                FROM
                    테이블이름1
                CROSS JOIN
                    테이블이름2
                ;
                
                SELECT
                    컬럼이름들...
                FROM
                    테이블이름1 CROSS JOIN 테이블이름2
                ;
                
        2. INNER JOIN
            ==> EQUI JOIN, NON EQUI JOIN, SELF JOIN 을 처리할 수 있는 조인으로
                CROSS JOIN의 결과물 내에서 정확한 필요한 데이터를 꺼내오는 조인
                
            형식 ]
                SELECT
                    컬럼이름들...
                FROM
                    테이블이름1
                [ INNER ] JOIN
                    테이블이름2
                ON
                    조인조건
                [
                [ INNER ] JOIN
                    테이블이름2
                ON
                    조인조건
                ]
                WHERE
                    일반조건
                ;
                
        3. OUTER JOIN
            ==> LEFT OUTTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN
            
             형식 ]
                SELECT
                    컬럼이름들
                FROM
                    테이블이름1
                LEFT || RIGHT || FULL OUTER JOIN
                    테이블이름2
                ON
                    조인조건
                [ WHERE
                    일반조건 ]
                ;
                
        4. NATURAL JOIN
            ==> 자동 조인
                반드시 조인 조건식(ON 절)에 사용되는 컬럼이름이 동일하고
                반드시 동일한 이름의 컬럼이 한개인 경우에만 사용할 수 있는 조인
                
            형식 ]
                SELECT
                    컬럼이름들...
                FROM
                    테이블이름1
                NATURAL JOIN
                    테이블이름2
                ;
        5. USING JOIN
            ==> 반드시 조인조건식에 사용하는 컬럼이름이 동일한 경우 그리고
                같은 이름의 컬럼이 한 개 이상 있는 경우에 사용할 수 있는 조인
                
            형식 ]
                SELECT
                    컬럼이름들...
                FROM
                    테이블1
                JOIN
                    테이블2
                USING
                    (조인에 사용할 컬럼이름)
                ;
*/

-- CROSS JOIN
SELECT
    *
FROM
    emp e
CROSS JOIN
    dept d
;

-- 사원들의 사원이름, 직급, 부서이름 을 조회하세요.
SELECT
    ename 사원이름, job 직급, dname 부서이름
FROM
    emp e
INNER JOIN
    dept d
ON
    e.deptno = d.deptno
;

-- 10번 부서 사원들의 사원이름, 직급, 급여, 부서이름, 급여등급 을 조회하세요.
SELECT
    ename 사원이름, job 직급, sal 급여, dname 부서이름, grade 급여등급
FROM
    emp e
INNER JOIN
    salgrade
ON
    sal BETWEEN losal AND hisal
JOIN
    dept d
ON
    e.deptno = d.deptno
WHERE
    e.deptno = 10
;

-- 부서별 최소급여자의 사원이름, 직급, 부서이름, 급여등급, 부서평균급여, 부서원수 를 조회하세요.
-- 사원정보테이블, 부서정보테이블, 급여등급테이블, 부서집계테이블
SELECT
    ename 사원이름, job 직급, dname 부서이름, 
    grade 급여등급, TRUNC(avg, 2) 부서평균급여, cnt 부서원수
FROM
    emp e
JOIN
    (
        SELECT
            deptno dno, MIN(sal) min, AVG(sal) avg, COUNT(*) cnt
        FROM
            emp
        GROUP BY
            deptno
    )
ON
    deptno = dno
JOIN
    dept d
ON
    d.deptno = dno
JOIN
    salgrade
ON
    sal BETWEEN losal AND hisal -- NON EQUI JOIN
WHERE
    sal = min
;

-- OUTER JOIN
-- 사원들의 사원이름, 직급, 상사이름 을 조회하세요.
SELECT
    e.ename 사원이름, e.job 직급, s.ename 상사이름
FROM
    emp e 
FULL OUTER JOIN -- 상사가 없는 사원, 상사가 아닌 사원도 동시에 조회
    emp s
ON
    e.mgr = s.empno
;

SELECT
    e.ename, s.ename
FROM
    emp e, emp s
WHERE
    e.mgr(+) = s.empno(+)-- 오라클조인에 full outer join은 없다.
;

-- 상사가 아닌 사원들의 사원이름, 직급, 급여를 조회하세요.

-- 상사들의 사원번호
SELECT
    DISTINCT mgr
FROM
    emp
WHERE
    mgr IS NOT NULL
;

SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    empno NOT IN    (
                        SELECT
                            DISTINCT mgr
                        FROM
                            emp
                        WHERE
                            mgr IS NOT NULL
                    )
;


-- NATURAL JOIN
-- 사원들의 사원이름, 직급, 급여, 부서번호, 부서이름, 부서위치를 조회하세요.
SELECT
    ename 사원이름, job 직급, sal 급여, 
    deptno 부서번호, dname 부서이름, loc 부서위치
FROM
    emp
NATURAL JOIN
    dept
;

-- USING JOIN
SELECT
    ename 사원이름, job 직급, sal 급여, 
    deptno 부서번호, dname 부서이름, loc 부서위치
FROM
    emp
JOIN
    dept
USING(deptno)
;

--------------------------------------------------------------------------------
/*
    데이터베이스 명령의 종류
        
        1. DDL(Data Definition Language) : 데이터 정의 언어
            CREATE, ALTER, DROP, TRUNCATE
        
        2. DML(Data Manipulation Language)  : 데이터 조작 언어
            ==> 우리가 사용했던 SELECT 명령은 DML 소속의 명령이다.
                    의미      명령어 
            C   - CREATE    - INSERT
            R   - READ      - SELECT
            U   - UPDATE    - UPDATE
            D   - DELETE    - DELETE
            
        3. DCL(Data Control Language)   : 데이터 제어 언어
            
            권한과 트랜젝션에 관련된 명령들...
            
            TCL 명령(TRANSACTION CONTROL LANGUAGE)
            ==> 트랜젝션(처리해야할 작업의 단위)을 제어하는 언어
                명령 ]
                    COMMIT, ROLLBACK, SAVEPOINT, ....
                    
            권한에 관련된 명령들
                GRANT   : 권한을 부여하는 명령
                REVOKE  : 부여된 권한을 회수하는 명령

--------------------------------------------------------------------------------
    
    DML 명령
        1. SELECT : 데이터 조회 명령
        
        2. INSERT : 테이블에 데이터를 추가해주는 명령
            참고 ]
                데이터를 입력하는 명령은 
                한번에 한개의 테이블에 한행의 데이터만 추가할 수 있다.
                
            형식 1 ]
                INSERT INTO
                    테이블이름
                VALUES(
                    컬럼이름1, 컬럼이름2, ...
                    (반드시 테이블에 정의되어있는 컬럼 순서대로 데이터를 맞춰서 입력해야 한다.)
                );
                
            형식 2 ]
                INSERT INTO
                    테이블이름(컬럼이름1, 컬럼이름2, ... )
                VALUES(
                    데이터1, 데이터2, ...
                    ==> 컬럼이름이 나열된 순서대로 컬럼데이터를 입력해줘야 한다.
                );
            
            참고 ]
                데이터베이스의 데이터 입력은
                행단위로 입력이 되고
                특정 컬럼에서 에러가 발생하면
                그 컬럼만 입력을 못하는 것이 아니고
                그 행 전체 입력이 안되는 형식으로 처리한다.
                
            참고 ]
                입력할 때 컬럼의 갯수와 데이터의 갯수는 반드시 일치해야 한다.
                순서도 일치시켜야 한다.
                
        3. UPDATE : 입력되어있는 데이터를 수정하는 명령
            
            형식 ]
                UPDATE
                    테이블이름
                SET
                    컬럼이름 = 데이터,
                    컬럼이름 = 데이터,
                    ....
                [ WHERE
                      조건식  ]
                ;
                
                참고 ]
                    WHERE 조건식에 맞는 데이터를 모두 선택해서
                    SET 절의 내용으로 변경하게 된다.
                    
                *****
                주의 ]
                    WHERE 조건절을 기술하지 않으면
                    테이블 내의 모든 데이터를 수정하게 되므로
                    항상 주의 해야 한다.
                    
        4. DELETE 명령
            ==> 입력된 데이터 행을 제거하는 명령
            
            형식 ]
                
                DELETE FROM
                    테이블이름
                [ WHERE
                    조건식 ]
                ;
            
            
            *****
            주의 ]
                WHERE 조건절을 기술하지 않으면 모든 데이터 행을 제거하게 되므로
                반드시 조건절을 기술하도록 한다.

*/

-- 연습용 테이블 준비
CREATE TABLE tmp
AS
    SELECT
        *
    FROM
        emp
    WHERE
        1 = 2
;

INSERT INTO
    tmp
    -- 테이블이름만 기술한 경우에는 테이블의 모든 컬럼 데이터를 입력해줘야 한다.
VALUES(
    1001, 'jennie', '사장', 1000, 
    TO_DATE('2024/02/22'), 5000, null, 40
    -- 데이터가 아직 준비 안된 경우라도 추가할 때 반드시 null로 입력해줘야 한다.
);

INSERT INTO
    tmp
VALUES(
    1000, 'euns', '센세', NULL, TO_DATE('2024/02/21'), NULL, NULL, 40
);

-- 형식 2
INSERT INTO
    tmp(empno, ename, hiredate, sal, deptno)
VALUES(
    1002, 'SMITH', TO_DATE('2024/02/22'), 8000, 20
    -- 나열된 컬럼이름순으로 컬럼데이터를 입력해야하고
    -- 나열되지 않은 컬럼의 데이터는 NULL로 채워지게 된다.
);

INSERT INTO 
    tmp(ename)
VALUES(
    2000 --  이 경우는 TO_CHAR() 함수가 자동 호출되서 형변환이 되서 입력된다.
);

-- TMP 테이블의 커미션을 500으로 수정하세요.
UPDATE
    tmp
SET
    comm = 500
;

COMMIT;

UPDATE
    tmp
SET
    sal = 4500
WHERE
    empno = 1002
;

UPDATE
    tmp
SET
    sal = 5500,
    mgr = 1001
WHERE
    empno = (
                SELECT
                    empno
                FROM
                    TMP
                WHERE
                    ename = 'SMITH'
            ) --  서브질의를 사용할 수 있다.
;

-- 1000 사원의 급여는 jennie사원의 10% 인상된 급여로 커미션은 기존 커미션의 10배 로 수정하세요.
-- 서브질의를 이용해서 처리하세요.

--  급여와 커미션
SELECT
    (
        SELECT
            sal * 1.1
        FROM
            tmp
        WHERE
            empno = 1001
    ),
    COMM * 10
FROM
    tmp
WHERE
    empno = 1000
;

-- 서브질의의 결과를 이용해서 데이터를 수정할 수 있다.
UPDATE
    tmp
SET
    (sal, comm) = (
                    SELECT
                        (
                            SELECT
                                sal * 1.1
                            FROM
                                tmp
                            WHERE
                                empno = 1001
                        ),
                        COMM * 10
                    FROM
                        tmp
                    WHERE
                        empno = 1000
                )
WHERE
    empno = 1000
;

COMMIT;

-- DELETE
DELETE FROM
    tmp
;

ROLLBACK;

/*
    INSERT 명령에도 서브질의를 사용할 수 있다.
    
        형식 ]
            INSERT INTO 테이블이름
                SELECT
                    컬럼이름들...
                FROM
                    테이블이름
                WHERE
                    조건식   
            ;
*/
-- emp 테이블의 SCOTT의 정보를 tmp 테이블에 입력하세요.
INSERT INTO 
    tmp
SELECT
    *
FROM
    emp
WHERE
    ename = 'SCOTT'
;

-- tmp 테이블의 1000 사원의 직급을 '선생님'으로 변경하세요.
UPDATE
    tmp
SET
    job = '선생님'
WHERE
    empno = 1000
;

commit;





















