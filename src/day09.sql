-- avatar 테이블
DROP TABLE AVATAR;
CREATE TABLE avatar(
    ano NUMBER(2)
        CONSTRAINT AVT_NO_PK PRIMARY KEY,
    filename VARCHAR2(300 CHAR)
        CONSTRAINT AVT_FNAME_UK UNIQUE
        CONSTRAINT AVT_FNAME_NN NOT NULL,
    dir VARCHAR2(300 CHAR) DEFAULT '/img/avatar/'
        CONSTRAINT AVT_DIR_NN NOT NULL,
    len NUMBER,
    gen CHAR(1) 
        CONSTRAINT AVT_GEN_CK CHECK(gen IN('F', 'M'))
        CONSTRAINT AVT_GEN_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT AVT_SHOW_CK CHECK(isshow IN('Y', 'N'))
        CONSTRAINT AVT_SHOW_NN NOT NULL
);

/*
-- 컬럼 변경하기
ALTER TABLE avatar
MODIFY ano NUMBER(2) DEFAULT 10; -- 기본키이므로 기본값이 있으면 안된다.

-- 테이블 이름 바꾸기
ALTER TABLE avt
RENAME TO avatar;
*/

-- 데이터 추가
INSERT INTO 
    avatar(ano, filename, gen)
VALUES(
    11, 'img_avatar1.png', 'M'
);

INSERT INTO 
    avatar(ano, filename, gen)
VALUES(
    12, 'img_avatar2.png', 'M'
);

INSERT INTO 
    avatar(ano, filename, gen)
VALUES(
    13, 'img_avatar3.png', 'M'
);

INSERT INTO 
    avatar(ano, filename, gen)
VALUES(
    21, 'img_avatar4.png', 'F'
);

INSERT INTO 
    avatar(ano, filename, gen)
VALUES(
    22, 'img_avatar5.png', 'F'
);

INSERT INTO 
    avatar(ano, filename, gen)
VALUES(
    23, 'img_avatar6.png', 'F'
);

-- 회원테이블 아바타 제약조건 추가
ALTER TABLE member
ADD CONSTRAINT
    MEMB_AVT_FK FOREIGN KEY(avatar) REFERENCES avatar(ano)
;

--------------------------------------------------------------------------------
-- 방명록
CREATE TABLE gBoard(
    gno NUMBER(4)
        CONSTRAINT GBRD_NO_PK PRIMARY KEY,
    writer NUMBER(4)
        CONSTRAINT GBRD_MNO_FK REFERENCES member(mno)
        CONSTRAINT GBRD_MNO_UK UNIQUE
        CONSTRAINT GBRD_MNO_NN NOT NULL,
    wdate DATE DEFAULT SYSDATE
        CONSTRAINT GBRD_DATE_NN NOT NULL,
    body VARCHAR2(300 CHAR)
        CONSTRAINT GBRD_BODY_NN NOT NULL
);

-- INSERT GBOARD
INSERT INTO
    GBOARD(gno, writer, body)
VALUES(
    1001, 1001, '사업번창하세요!'
);

INSERT INTO
    GBOARD(gno, writer, body)
VALUES(
    (SELECT NVL(MAX(gno) + 1, 1001) FROM gboard), 
    1000, '묻지마사업 오픈합니다. 찾아주셔서 감사합니다.'
);
commit;

/*
    방명록에 게시된 글들의
        글번호, 회원아이디, 작성일, 아바타파일이름, 성별, 본문
    을 조회하세요.
*/
SELECT
    gno 글번호, id 회원아이디, wdate 작성일, 
    filename 아바타파일이름, m.gen 성별, body 본문
FROM
    member m, avatar a, gboard g
WHERE
    avatar = ano
    AND mno = writer
ORDER BY
    gno
;

--------------------------------------------------------------------------------
/*
    테이블 수정하기
    ==> 
        테이블이름 수정 ]
            ALTER TABLE 테이블이름
            RENAME TO 바뀔테이블이름;
        
        컬럼추가하기 ]
            ALTER TABLE 테이블이름
            ADD ( 컬럼이름 데이터타입(길이) 제약조건...);
        
        컬럼이름 변경 ]
            ALTER TABLE 테이블이름
            RENAME COLUMN 현재이름 TO 바뀔이름;
            
        컬럼 길이 변경 ]
            ALTER TABLE 테이블이름
            MODIFY 컬럼이름 데이터타입(길이)
                CONSTRAINT 제약조건이름 NOT NULL;
            
        컬럼 삭제하기
            ALTER TABLE 테이블이름
            DROP COLUMN 컬럼이름;
            
        제약조건 추가
            ALTER TABLE 테이블이름
            ADD CONSTRAINT 제약조건이름 제약조건(컬럼이름) 나머지구문;
            
        제약조건 이름변경
            ALTER TABLE 테이블이름
            RENAME CONSTRAINT 지금이름 TO 바뀔이름;
    ----------------------------------------------------------------------------
    테이블 삭제
    ==> 테이블 안의 모든 데이터도 같이 삭제된다.
        
        형식 1 ]
            DROP TABLE 테이블이름;
            
        형식 2 ]
            DROP TABLE 테이블이름 PURGE;
            ==> 휴지통으로 이동시키지 말고 즉시 삭제
            
        참고 ]
            DML 명령은 원칙적으로 복구가 가능하다.
            
            DDL 명령은 원칙적으로 복구가 불가능하다.
            
            오라클 10G 부터 휴지통 개념을 이용해서
            삭제된 테이블을 휴지통에 보관하도록 해 놓았다.
            
        휴지통 관리 ]
            
            1. 휴지통의 모든 테이블 삭제
                
                PURGE RECYCLEBIN;
                
            2. 휴지통에 있는 특정 테이블만 완적 삭제
                
                PUBGE TABLE 테이블이름;
                
            3. 휴지통 내용 확인
            
                SHOW RECYCLEBIN;
            
            *** 
            4. 휴지통에 버린 테이블 복구하기
            
                FLASHBACK TABLE 테이블이름 TO BEFORE DROP;
                
    ----------------------------------------------------------------------------
        TRUNCATE
        ==> DDL 소속 명령으로 DELETE  명령처럼
            테이블 내의 데이터를 모두 삭제 하는 명령
            
            형식 ]
                
                TRUNCATE TABLE 테이블이름;
                
            참고 ]
                이 명령은 DDL 소속 명령이므로
                복구가 불가능하다.
        
*/

CREATE TABLE ABC(
   NO NUMBER(4) 
);

DROP TABLE ABC;

SHOW RECYCLEBIN;

FLASHBACK TABLE ABC TO BEFORE DROP;

-- ABC 테이블을 휴지통으로 이동시키지 않고 즉시 삭제
DROP TABLE abc PURGE;

-- 휴지통 확인
SHOW RECYCLEBIN;

--- TRUNCATE

CREATE TABLE MEMB
AS
    SELECT
        *
    FROM
        member
;

/*
    기존테이블을 복사해서 새로운 테이블을 만드는 방법
    
        형식 ]
            CREATE TABLE 새테이블이름
            AS
                SELECT
                    컬럼이름들...
                FROM
                    테이블이름
                [ WHERE
                    조건식
                ]
            ;
        ==> 서브질의의 결과를 이용해서 새로운 테이블을 만든다.
            이때 제약조건은 복사되지 않는다.
            하지만 NULL 데이터에 관련된 속성은 복사된다.
            이때 NOT NULL 제약조건이 부여되어있으면
            오라클이 정한 이름으로 NOT NULL 제약조건은 추가된다.
            
*/

TRUNCATE TABLE MEMB;

SHOW RECYCLEBIN;

--------------------------------------------------------------------------------
/*
제약조건 추가하기
    
    1. 테이블을 정의 하면서 컬럼에서 정의 하는 방법
        
        CREATE TABLE 테이블이름(
            컬럼이름1 데이터타입(길이)
                CONSTRAINT 제약조건이름 PRIMARY KEY,
            컬럼이름2 데이터타입(길이)  [ DEFAULT 데이터 ]
                CONSTRAINT 제약조건이름 REFERENCES 참조할테이블이름(참조컬럼이름)
                CONSTRAINT 제약조건이름 UNIQUE
                CONSTRAINT 제약조건이름 CHECK(컬럼이름2 IN (데이터1, 데이터2, ...))
                CONSTRAINT 제약조건이름 NOT NULL,
            ...
        );
        
        -- 무명제약조건으로 추가하는 방법..
        CREATE TABLE 테이블이름(
            컬럼이름1 데이터타입(길이) PRIMARY KEY,
            컬럼이름2 데이터타입(길이) UNIQUE CHECK(컬럼이름2 IN(데이터1, 데이터2)) NOT NULL,
            컬럼이름3 데이터타입(길이) REFERENCES 참조테이블이름(참조컬럼이름),
            
        );
        
    2. 테이블 정의 할 때 컬럼 정의가 끝난 후에 정의하는 방법
        
         CREATE TABLE  테이블이름(
             컬럼이름1  데이터타입(길이),
             컬럼이름2 데이터타입(길이),
             ....
             CONSTRAINT 제약조건이름 PRIMARY KEY(컬럼이름1),
             CONSTRAINT 제약조건이름 FOREIGN KEY(컬럼이름2) REFERENCES 참조테이블이름(참조컬럼이름),
             CONSTRAINT 제약조건이름 UNIQUE(컬럼이름2),
             CONSTRAINT 제약조건이름 CHECK(컬럼이름2 IN ( 데이터1, 데이터2, ...)),
             ...
         );
         
*/
--------------------------------------------------------------------------------

