/*
    인덱스(Index)
    ==> 검색 속도를 빠르게 하기 위해서 B-Tree 기법으로
        색인을 만들어서 조회 속도를 빠르게 향상시키도록 하는 것.
        
        참고 ]
            인덱스를 만들면 안되는 경우
                1. 데이터양이  적은 경우는 오히려 속도가 떨어진다.
                    시스템에 따라 달라지지만
                    최소 10만단위 이상의 데이터가 있는 경우 속도향상의 효과가 발생.
                    
                2. 데이터의 입출력이 빈번한 경우 오히려 속도가 떨어진다.
                    <== 데이터가 입력될때마다
                        계속해서 인덱스를 수정을 해야하므로 오히려 속도가 떨어진다.
            
            
            인덱스를 만들면 효과적인 경우
                
                1. JOIN등에 많이 사용되는 컬럼이 존재하는 경우
                2. NULL 데이터가 많이 존재하는 경우
                3. WHERE 조건절에 많이 사용되는 컬럼이 있는 경우
                
            참고]
                오라클의 경우
                기본키와 유일키 제약조건을 추가하면
                자동적으로 인덱스가 생성된다.
                
        인덱스 만들기
            
            형식 1 ]
            ==> 일반 인덱스 만드는 형식(NON UNIQUE 인덱스)
                
                CREATE INDEX 인덱스이름
                ON
                    테이블이름(컬럼이름);
                    
                예 ]
                    CREAE INDEX name_idx ON emp(ename);
                    ==> 사원의 이름을 이용해서 색인을 만들어주세요.
                        이름으로 검색하는 경우 속도가 빨라진다.
                        
                참고 ]
                    일반인덱스는 데이터가 중복되어도 상관이 없다.
                    
            
            형식 2 ]
            ==> UNIQUE INDEX 만드는 방법
                인덱스에 사용할 데이터가 반드시 유일하다는 보장이 있어야 한다.
                
                CREATE UNIQUE INDEX 인덱스이름
                ON
                    테이블이름(컬럼이름);
                    
                주의 ]
                    지정한 컬럼은 반드시 속성값이 유일하다는 보장이 있어야 한다.
                    
                참고 ]
                    일반 인덱스보다 검색속도가 많이 빠르다.
                    <== 이진검색을 사용하기 때문이다.
                    
            형식 3 ]
            ==> 결합인덱스
                여러개의 컬럼을 이용해서 하나의 인덱스를 만드는 방법
                이때 전제조건으로 여러개의 컬럼을 결합한 결과는 반드시 유일해야 한다.
                
                형식 ]
                    CREATE UNIQUE INDEX 인덱스이름
                    ON
                        테이블이름(컬럼이름1, 컬럼이름2, ..);
                        
                ==> 하나의 컬럼만 가지고는 유니크 인덱스를 만들지 못하는 경우
                    여러개의 컬럼을 결합해서 유니크 인덱스를 만들어서 사용하는 방법
                
                참고 ]
                ==> 복합키, 슈퍼키
                    : 테이블에서 기본키는 한개만 가질 수 있다.
                        그런데 기본키는 테이블내의 데이터를 특정할 수 있는 기능으로
                        거의 기본적으로 추가된다.
                        그런데 하나의 컬럼의 속성값으로 기본키를 지정할 수 없는 경우에는
                        여러개의 컬럼을 결합해서 기본키를 부여할 수 있다.
                        이때 이 제약조건은 기본키 제약조건에 해당하고
                        사용하는 컬럼이 여러개가 된다.
                        형식 ]
                            CREATE TABLE  테이블이름(
                                컬럼이름1 타입(길이),
                                컬럼이름2 타입(길이),
                                컬럼이름2 타입(길이),
                                ...
                                
                                CONSTRAINT 제약조건이름 PRIMARY KEY(컬럼이름1, 컬럼이름2,.. ),
                                ...
                            );
                            ==> 각 컬럼의 속성값은 중복되어도 상관없지만
                                복합키로 지정된 컬럼들의 조합은 중복되면 안된다.
                                
            형식 4 ]
            ==> 비트 인덱스
                : 주로 컬럼의 데이터의 가지수(도메인)가 결정이 되어있는 경우
                    많이 사용되는 인덱스
                    예 ]
                        성별, 공개여부, 부서번호, 혈액형, 학년
                        
                ==> 내부적으로 데이터를 이용해서 인덱스를 만들어서 사용하는 방법
                
                형식 ]
                    CREATE BITMAP INDEX 인덱스이름
                    ON  
                        테이블이름(컬럼이름);
            
*/

-- SALGRADE 테이블에 기본키 제약조건과 UNIQUE 인덱스를 추가하세요.
-- 기본키 제약조건
ALTER TABLE salgrade
ADD CONSTRAINT SALGRADE_GRADE_PK PRIMARY KEY(grade);

-- INDEX 추가
CREATE UNIQUE INDEX hisalidx
ON 
    salgrade(hisal);
    
CREATE UNIQUE INDEX losalidx
ON 
    salgrade(losal);

-- emp테이블의 deptno에 참조키 제약조건 추가

-- dept 기본키 제약조건 추가
ALTER TABLE dept
ADD CONSTRAINT DEPT_DNO_PK PRIMARY KEY(deptno);

-- emp.deptno에 체크제약조건 추가
ALTER TABLE emp
ADD CONSTRAINT EMP_DNO_CK CHECK(deptno IN (10, 20, 30, 40));

ALTER TABLE emp
ADD CONSTRAINT EMP_DNO_FK FOREIGN KEY(deptno) REFERENCES dept(deptno);

-- 비트맵인덱스 추가
-- 사원정보테이블에 직급과 부서번호를 이용해서 비트맵 인덱스를 각각 추가하세요.
/*
CREATE BITMAP INDEX jobBidx
ON
    emp(job);
    
CREATE BITMAP INDEX dnoBidx
ON
    emp(deptno);
*/

-- 결합인덱스 추가
-- 부서정보테이블의 부서이름과 부서위치를 이용해서 결합인덱스를 추가하세요.
CREATE UNIQUE INDEX dinfoidx
ON
    dept(dname, loc);

--------------------------------------------------------------------------------
/*
    트리거(Trigger)
    ==> DML 질의명령을 실행하면
        자동적으로 해당 명령 외에 다른 명령이 실행되도록 하는 프로그램의 일종
        
        예 ]
            회원정보는 회원이 탈퇴하는 순간 일반적으로 벡업테이블에 해당 회원의 정보를
            이동 시켜놓는다.
            이 작업은
                DELETE 명령이 실행되면
                벡업테이블에 해당 정보를 INSERT 하는 작업이 실행되고
                그 후에 회원정보테이블에서 해당 회원의 정보를 삭제하는 DELETE 명령이 실행된다.
                
        형식 ]
            CREATE OR REPLACE TRIGGER 트리거이름
                BEFORE[ 또는 AFTER ] INSERT[ 또는  UPDATE 또는 DELETE ]
                -- BEFORE[ 또느 AFTER ] : 이후에 기술될 DML 명령이 실행되기 전또는 후에  
                                            트리거의 내용을 실행할지를 결정하는 부분
                --INSERT[ 또는  UPDATE 또는 DELETE ] : 이후의 ON 절에 기술된 테이블에 실행될
                                                        DML 명령을 정하는 부분
            ON
                테이블이름
            [ FOR EACH ROW ]
            ==> 생략하면 DML명령의 갯수에 따라서 트리거를 실행한다.
                ==> DML명령이 한개면 수정되는 데이터의 행수와 상관없이 트리거를 한번만 실행
                
                기술하면 DML명령의 결과로 수정된 행 수만큼 트리거가 실행된다.
            [ WHEN
                조건식
            ] ==> 트리거가 발생하는 조건을 기술하는 부분
                예 ]
                    WHEN
                        deptno = 10
                    ==> 부서번호가 10번인 사원들의 정보가 수정되면 트리거를 실행하세요.
            BEGIN
                트리거에서 처리할 질의명령
            END;
            /
            
        참고 ]
            트리거가 발생하면 자동적으로 두개의 변수가 만들어지게 된다.
            
            :OLD    - 이전 데이터를 기억하는 변수
            :NEW    - 이후 데이터를 기억하는 변수
            
            ==> UPDATE 명령을 실행하면
                    :OLD와 :NEW 변수가 만들어지지만
                    
                INSERT 명령의 경우는
                    :NEW 변수만 사용가능
                
                DELETE 명령의 경우는
                    :OLD 변수만 사용가능
                    
        참고 ]
            트리거내에서는 COMMIT, ROLLBACK 을 사용할 수 없다.
        
*/

-- BEMP 테이블을 EMP테이블의 내용을 구조만 복사해서 만들어보자. 그리고 퇴사일 컬럼도 추가해보자.
CREATE TABLE bemp
AS
    SELECT
        e.*, SYSDATE firedate
    FROM
        emp e
    WHERE
        1 = 2
;


-- emp 테이블을 데이터까지 복사해서 temp 테이블을 만드세요.
CREATE TABLE temp
AS
    SELECT
        *
    FROM
        emp
;

-- BEMP와 TEMP 테이블에 기본키제약조건 추가
ALTER TABLE bemp
ADD CONSTRAINT BMP_NO_PK PRIMARY KEY(empno);

ALTER TABLE temp
ADD CONSTRAINT BTMP_NO_PK PRIMARY KEY(empno);

-- 회원번호를 알려주면 해당회원의 정보를 bemp 테이블에 저장하는 질의명령
INSERT INTO
    BEMP
SELECT
    EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, 
    TO_DATE(TO_CHAR(sysdate + 1, 'YYYY/MM/DD'))
FROM
    TEMP
WHERE
    empno = 7839
;

INSERT INTO 
    bemp
VALUES(
    :OLD.empno, :OLD.ename, :OLD.JOB, :OLD.MGR, :OLD.HIREDATE, 
    :OLD.SAL, :OLD.COMM, :OLD.DEPTNO, TO_DATE(TO_CHAR(sysdate + 1, 'YYYY/MM/DD'))
);

truncate table BEMP;

-- temp 테이블의 사원이 퇴사하면 bemp 테이블에 사원의 정보를 벡업하는 트리거를 제작하세요.
---------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER backupEmp
    BEFORE DELETE
ON 
    temp
FOR EACH ROW
BEGIN
    INSERT INTO 
        bemp
    VALUES(
        :OLD.empno, :OLD.ename, :OLD.JOB, :OLD.MGR, :OLD.HIREDATE, 
        :OLD.SAL, :OLD.COMM, :OLD.DEPTNO, TO_DATE(TO_CHAR(sysdate + 1, 'YYYY/MM/DD'))
    );
    
    DBMS_OUTPUT.PUT_LINE(:OLD.ENAME || ' 사원이 퇴사했습니다.');
END;
/
---------------------------------------------------------------------------------------
-- SMITH 사원을 퇴사 처리하세요.

TRUNCATE TABLE bemp;
DELETE FROM 
    temp
WHERE
    empno = 7369
;

INSERT INTO temp
    SELECT
        *
    FROM
        emp
    WHERE
        empno = 7369
;


set SERVEROUTPUT on;

commit;

DELETE FROM 
    temp
WHERE
    empno = 7369
;

COMMIT;
rollback;

--------------------------------------------------------------------------------

-- 사원이 입사하면 사원의 누적 지급 급여를 기억할 테이블에
-- 해당 사원이 정보가 추가되도록 
-- 트리거를 작성하고 실행하세요.

-- 사원들의 누적 급여 테이블
CREATE TABLE sumsal(
    eno NUMBER(7,2)
        CONSTRAINT SSAL_NO_PK PRIMARY KEY,
    hap NUMBER(9,2) DEFAULT 0 -- 누적급여 초기값
        CONSTRAINT SSAL_HAP_NN NOT NULL,
    udate DATE DEFAULT sysdate
        CONSTRAINT SSAL_DATE_NN NOT NULL
);

-- 트리거 생성
CREATE OR REPLACE TRIGGER salUp
    AFTER INSERT
ON 
    temp
FOR EACH ROW
BEGIN
    INSERT INTO
        sumsal(eno)
    VALUES(
        :NEW.empno
    );
    
    DBMS_OUTPUT.PUT_LINE(:NEW.ENAME || ' 사원이 입사했습니다.');
END;
/

/*
    CHOPPA 사원을
        사원번호: 8000
        이름 : CHOPPA
        직급 : DOCTOR
        상사번호 : 7839
        입사일 : 오늘 0시0분0초
        급여 : 1000
        커미션 : 없음
        부서번호 : 40
    으로 추가하세요.

*/

INSERT INTO
    temp
VALUES(
    8000, 'CHOPPA', 'DOCTOR', 7839, 
    TO_DATE(TO_CHAR(sysdate, 'yyyy/mm/dd')),
    1000, NULL, 40
);

INSERT INTO
    temp
VALUES(
    8001, 'BOA HANKOK', 'DUMOK', 8000, 
    TO_DATE(TO_CHAR(sysdate, 'yyyy/mm/dd')),
    1500, 1000, 40
);

--------------------------------------------------------------------------------

/*
    jennie 계정에 복사된
    
        EMP, DEPT, SALGRADE
    테이블들의 제약조건을 추가하세요.
    
*/

ALTER TABLE member
RENAME CONSTRAINT SYS_C007086 TO MB_NAME_NN;






