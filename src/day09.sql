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






