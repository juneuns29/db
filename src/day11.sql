/*
    VIEW 만드는 형식 2 ]
        
        CREATE OR REPLACE VIEW 뷰이름
        AS
            질의명령
        ;
        ==> 생성할 뷰가 없으면 새로 만들고 이미 있으면 수정을 한다.
        
    형식 3 ]
        
        CREATE OR REPLACE VIEW 뷰이름
         AS
            질의명령
        WITH CHECK OPTION;
        ==>
            DML 명령으로 데이터를 수정하게되면
            변경된 데이터는 뷰에서 사용한 테이블의 데이터를 수정하게 된다.
            그려면 뷰 입장에서 보면 원제 조회되었던 데이터를 사용할 수 없게 될 수 있다.
            
    
            
--------------------------------------------------------------------------------------------
    
    뷰는 조회질의명령의 결과로 만들어지므로
    조회할 테이블이 존재해야 원칙적으로는 만들 수 있다.
    하지만 작업진행상 뷰를 먼저 제작해야 하는 경우도 생길 수 있다.
    이런경우 사용할 수 있는 뷰 제작 형식이 있다.
    
    형식 ]
        CREATE OR REPLACE FORCE VIEW 뷰이름
        AS
            질의명령
        ;
    ==>
        이때 제작된 뷰는 조회할 테이블이 아직 존재하지 않기 때문에
        사용할 수는 없고 테이블이 만들어져야 사용가능해진다.
*/

-- 10번부서 사원들의 
-- 사원번호, 사원이름, 직급, 급여, 부서이름, 부서위치 
-- 를 조회할 수 있는 뷰(d10info)를 제작하세요.
CREATE OR REPLACE VIEW d10info
AS
    SELECT
        empno, ename, job, sal, dname, loc
    FROM
        emp e, dept d
    WHERE
        e.deptno = d.deptno
        AND e.deptno = 10
;

-- 전체조회
SELECT
    empno, ename, job, sal, dname, loc
FROM
    d10info
;

-- 7782번 사원의 급여를 d10info뷰를 이용해서 2500으로 수정하세요.
UPDATE
    d10info
SET
    sal = 2500
WHERE
    empno = 7782
;
-- ==> 복합뷰의 내용은 수정할 수 없다.

-- d10info라는 이름으로 emp테이블의 10번 부서 사원들의 
-- 사원번호, 사원이름, 직급, 급여, 부서번호
-- 를 조회하는 뷰를 제작하세요.
CREATE OR REPLACE VIEW d10info
AS
    SELECT
        empno eno, ename name, job, sal money, deptno dno
    FROM
        emp
    WHERE
        deptno = 10
;

-- 뷰 전체조회
SELECT * FROM d10info;

-- 7782 번 사원의 급여를 2500으로 수정하세요.
UPDATE
    d10info
SET
    money = 2500
WHERE
    eno = 7782
;

-- 결과조회
SELECT
    *
FROM
    d10info
;

-- 7782번 사원의 부서번호를 20번으로 수정하세요.
UPDATE
    d10info
SET
    dno = 20
-- WHERE eno = 7782
;

-- 결과조회
SELECT * FROM d10info;

ROLLBACK;

-- 부서번호는 수정할 수 없도록 d10info 뷰를 다시 제작
CREATE OR REPLACE VIEW d10info
AS
    SELECT
        empno eno, ename name, job, sal money, deptno dno
    FROM
        emp
    WHERE
        deptno = 10
WITH CHECK OPTION;

-- 7782번 사원의 부서번호 20번으로 수정
UPDATE
    d10info
SET
    dno = 20
WHERE
    eno = 7782
;

SELECT * FROM d10info;

rollback;

-- emp 테이블의 모든 데이터를 잘라내자.
TRUNCATE TABLE emp; -- DDL 소속 명령
SELECT * FROM emp;

-- scott 계정이 가지고 있는 emp 테이블의 데이터를 복사해서
-- jennie계정의 emp 테이블에 입력하세요.
INSERT INTO emp
    SELECT
        *
    FROM
        scott.emp
;
commit;

SELECT * FROM emp;

/*
    jennie 계정에 Member, Avatar 테이블을 만들예정이다.
    두 테이블을 이용해서 
        회원번호, 이름, 아이디, 메일, 아바타저장이름, 성별
    을 조회하는 membView를 만드세요.
*/

CREATE OR REPLACE FORCE VIEW membView
AS
    SELECT
        mno, name, id, mail, savename sname, m.gen
    FROM
        member m, avatar a
    WHERE
        avatar = ano
;