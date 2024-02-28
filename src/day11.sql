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
            
    형식 4 ]
        ==> 뷰를 통해서 데이터를 수정할 수 없도록 막아서 뷰를 만드는 형식
        
        CREATE OR REPLACE VIEW 뷰이름
        AS
            질의명령
        WITH READ ONLY;
    
            
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
        
------------------------------------------------------------------------------------------------
    뷰 삭제하기
        
        형식 ]
            
            DROP VIEW  뷰이름;
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
WHERE 
    eno = 7782
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

-- D10INFO의 7782사원의 급여를 2500으로 수정
UPDATE
    d10info
SET
    money = 2500
WHERE
    eno = 7782
;

rollback;

-- d20info라는 이름으로 20번 부서의 사원들의
-- 사원번호, 사원이름, 직급, 급여 를 조회하는 뷰를 만드세요.
-- 단, 이 뷰를 통해서 데이터를 수정할 수 없도록 하세요.
CREATE OR REPLACE VIEW d20info
AS
    SELECT
        empno eno, ename name, job, sal money
    FROM
        emp
    WHERE
        deptno = 20
WITH READ ONLY
;

-- 7782번 사원의 급여를 10000로 수정하세요.
UPDATE
    d20info
SET
    money = 10000
WHERE
    eno = 7369
;

--------------------------------------------------------------------------------
/*
    시퀀스(Sequence)
    ==> 테이블을 만들면 각각의 행을 구분할 수 있는 기본키(PK, Primary Key)를 
        거의 필수적으로 만들게 된다.
        이때 가장 쉽고 편하게 사용하는 것이 번호를 이용해서 기본키를 사용하게된다.
        그러면 이 번호는 다른 행들과 구분되는 유일한 값이어야 하고
        null 이 입력되면 안된다.
        
        따라서 이 일련번호를 입력할 때
        쉬운방법으로는 서브질의를 이용해서 숫자를 만들어서 입력하는 방법이 있는데
        이 방법은 DBMS가 메인질의명령을 실행할때 번호를 만드는 질의명령을 한번더 실행하게된다.
        따라서 처리작업에 약간 더 시간이 소모된다.
        
        이런 불편함을 해결해주는 것이 시퀀스이다.
        
        시퀀스는 자동적으로 일련번호를 만들어주는 도구로
        데이터베이스에 등록되는 개체이다.
        
        사용방법 ]
            1. 시퀀스를 만든다.
            2. 일련번호가 필요한 시점에 번호를 알려달라고 요청한다.
                ==> INSERT 명령이 실행될 때 요청해서 사용하면 된다.
                
        시퀀스 제작 형식 ]
            
            CREATE SEQUENCE 시퀀스이름
                START WITH 번호
                ==> 발생시킬 일련번호의 시작값을 지정
                
                INCREMENT BY 숫자
                ==> 발생시킬 일련번호의 증가값을 지정
                    기술하지 않으면 1로 처리된다.
                    
                MAXVALUE 숫자 [ 또는 NOMAXVALUE ]
                MINVALUE 숫자 [ 또는 NOMINVALUE ]
                ==> 발생시킬 일련버호의 최대값, 최소값을 지정
                    생략하면 NOMAXVALUE, NOMINVALE로 설정된다.
                    
                CYCLE [ 또는 NOCYCLE ]
                ==> 발생된 일련번호가 최대값에 도달한 후
                    처음부터 다시 시작할지 여부를 지정
                    
                CACHE 숫자 [ 또는 NOCACHE ] 
                ==> 일련번호를 임시메모리를 사용해서 꺼내올지 여부를 지정
                    기본값은 임시메모리에 10개를 만들어놓고 거기서 꺼내오게 된다.
                    
        참고 ]
            사용방법
                시퀀스이름.CURRVAL   : NEXTVAL로 마지막 생성한 번호를 기억
                시퀀스이름.NEXTVAL   : 실행시킬때마다 다음번호를 생성
    
    
    참고 ]
        시퀀스는 특정테이블에 종속적이지 않다.
        따라서 하나의 시퀀스는 여러개의 테이블에서 사용될 수 있다.
        이러다보니 일련번호를 만들때 한 테이블내에서는 중간에 누락된 번호가 존재할 수 있다.
        그리고 INSERT 명령 실행중 시퀀스로 번호를 생성해서 입력할 때
        입력 내용이 잘못되서 입력이 안되는 경우 
        이때 생성한 일련번호는 다시 사용할 수 없게된다.
        
    시퀀스 수정 ]
        
        형식 ]
            ALTER SEQUENCE 시퀀스이름
                INCREMENT BY 숫자
                MAXVALUE 숫자
                MINVALUE 숫자
                CYCLE
                CACHE
            ;
            
            ==> 시퀀스를 수정하는 경우는 시작번호는 수정할 수 없다.
                이미 발생된 번호가 있기 때문에
                시작 번호는 이전에 만들어 놓은 번호가 시작번호가 된다.
                
        시퀀스 삭제 ]
            
            형식 ]
                DROP SEQUENCE 시퀀스이름;

--------------------------------------------------------------------------------









--------------------------------------------------------------------------------
    계층형 질의명령
    ==> 예제의 EMP 테이블에는 KING 사장으로 시작해서 
        사원들이 피라미드 구조로 근무하고 있다.
        그 구조대로 조회할 수 있는 질의명령 형식을 이야기한다.
        
        형식 ]
            
            SELECT
                컬럼이름들, LEVEL 계층레벨
            FROM
                테이블이름
            START WITH  
                계층의 시작을 기술하는 부분
            CONNECT BY
                계층의 관계 조건을 기술하는 부분
            ORDER SIBLINGS BY
                계층구조의 정렬 기준 컬럼 기술
            ;
        

                
*/

-- 1부터 1씩 증가하는 시퀀스 ONE2ONE을 만들어보자. 최대값은 100으로 한다.
CREATE SEQUENCE one2one
    MAXVALUE 100
;

SELECT one2one.CURRVAL 현재번호, one2one.NEXTVAL n1, one2one.NEXTVAL n2 FROM dual;

SELECT ONE2ONE.CURRVAL 현재번호 FROM dual;

DROP TABLE TMP;
CREATE TABLE TMP(
    NO NUMBER(3)
        CONSTRAINT TMP_NO_PK PRIMARY KEY,
    name VARCHAR2(20 CHAR),
    id VARCHAR2(20 CHAR)
        CONSTRAINT TMP_ID_UK UNIQUE
        CONSTRAINT TMP_ID_NN NOT NULL
);

-- ONE2ONE 시퀀스를 이용해서 데이터를 입력해보자.
INSERT INTO
    tmp(NO, ID)
VALUES(
    one2one.NEXTVAL, 'JENNIE'
);

INSERT INTO
    tmp(NO)
VALUES(
    one2one.NEXTVAL
);


INSERT INTO
    tmp(NO, ID)
VALUES(
    one2one.NEXTVAL, 'CHOPPA'
);

--조회
SELECT
    *
FROM
    tmp
;

-- EMP테이블의 계층구조를 조회하세요.
SELECT
    empno 사원번호, ename 사원이름, job 직급, mgr 상사번호, LEVEL 계층레벨
FROM
    emp
START WITH
    mgr IS NULL
CONNECT BY
    prior empno = mgr
ORDER SIBLINGS BY
    ename
;

SELECT
    LEVEL || ' ' || 
    CONCAT(
        LPAD('-', (LEVEL - 1) * 5, '-'),
        ename
    ) || ' : ' || 
    job 사원정보
FROM
    emp
START WITH
    mgr IS NULL
CONNECT BY
    prior empno = mgr
;

--------------------------------------------------------------------------------
CREATE TABLE member
AS
    SELECT
        *
    FROM
        scott.member
;

-- 회원번호 시퀀스 생성
CREATE SEQUENCE mnoSeq
    START WITH 1002
    MAXVALUE 9999
    NOCYCLE
;

-- 회원 '쵸파', '리사', '로제', '지수'를 추가하세요.
INSERT INTO 
    member(mno, name, id, pw, mail, tel, gen, avatar, joindate, isshow)
VALUES
    (mnoseq.NEXTVAL, '쵸파', 'CHOPPA', 12345, 
        'choppa@human.com', '010-5858-5858', 'M', 11, sysdate, 'Y')
;
        
INSERT INTO 
    member(mno, name, id, pw, mail, tel, gen, avatar, joindate, isshow)
VALUES
    (mnoseq.NEXTVAL, '리사', 'LISA', 12345, 
        'lisa@human.com', '010-2424-2424', 'F', 22, sysdate, 'Y')
;
        
INSERT INTO 
    member(mno, name, id, pw, mail, tel, gen, avatar, joindate, isshow)
VALUES
    (mnoseq.NEXTVAL, '로제', 'ROSE', 12345, 
        'rose@human.com', '010-5454-5454', 'F', 22, sysdate, 'Y')
;
        
INSERT INTO 
    member(mno, name, id, pw, mail, tel, gen, avatar, joindate, isshow)
VALUES
    (mnoseq.NEXTVAL, '지수', 'JISOO', 12345, 
        'jisoo@human.com', '010-2626-2626', 'F', 23, sysdate, 'Y')
;
