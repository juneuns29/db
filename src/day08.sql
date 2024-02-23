-- day08

/*
    DDL(Data Definition Language) 명령
    ==> 개체의 생성과 수정에 관련된 명령들...
        
        테이블, 사용자, 뷰, ... 등이 개체에 해당하고
        데이터베이스에 등록이 되는 것들이다.
        개체들은 이름을 가지고 그 이름으로 불러서 사용할 수 있는 것들이다.
        
    참고 ]
        테이블 설계
            오라클은 정규화된 데이터를 기억하도록 하는 데이터베이스의 일종이다.
            정규화 데이터란?
                규칙이 정해진 데이터를 의미한다.
            오라클은 어떤 형태의 데이터를 기억할 지를 미리 정해놓고
            그 데이터의 형태에 한해서만 기억하도록 하는 데이터베이스이다.
            
            따라서 테이블을 만들때는 여러가지 규칙(정규화 규칙)을 가지고
            테이블에 들어갈 데이터의 형태를 결정해야 한다.
            
        테이블 설계 과정
            
            개념적 설계
            ==> 추상적으로 개념적으로만 정리해 놓는 설계
                ==> ER MODEL DIAGRAM
                
            논리적 설계
            ==> 데이터의 형태와 개체간의 관계까지 정의되는 설계
                
                ==> ERD
                
            물리적 설계
            ==> 실제 저장공간에 기록될 수 있도록 하는 설계
                
                ==> 테이블명세서, DDL 질의명령
                
        ------------------------------------------------------------------------
        참고 ]
            정규화
            ==> 테이블 설계시 입력될 데이터의 규격을 정하는 작업들...
            
                제1정규화
                ==> 모든 속성은 속성값이 원자값을 가져야 한다.
                
                제2정규화
                ==> 기본키 이외의 속성은 기본키에 대해서 완전함수 종속이어야 한다.
                    
                제3정규화
                ==> 기본키이외의 속성중 부분함수(이행적 함수) 종속을 피해야 한다.
                
            ----------------------------------------------
                BCNF정규화
                제4정규화
                제5정규화
*/

/*
    회원의 정보를 기록할 테이블(Member)를 설계해보자.
        1. 개념적 설계   ==> ER Model Diagram
        2. 논리적 설계   ==> ERD
        3. 물리적 설계   ==> 테이블명세서, DDL 명령 SQL
        
    ----------------------------------------------------------------------------
    무결성 제약조건
    ==> 데이터베이스는 프로그램들의 전산작업에서 필요한 데이터를 제공해주는
        보조 프로그램이다.
        따라서 데이터베이스가 가진 데이터는 언제나 완벽한 데이터여야 한다.
        하지만 데이터를 입력하는 것은 사람의 몫이고
        그래서 완벽한 데이터를 보장할 수 없게 된다.
        
        각각의 테이블에 입력되서는 안될 데이터나 
        누락되면 안되는 데이터등을 미리 결정해 놓으면 
        입력하는 과정에서 잘못된 데이터가 입력되는 것을
        방지할 수 있게 될 것이다.
        
        이 기능은 반드시 필요한 기능은 아니나
        실수를 미연에 방지할 수 있도록 조치해놓는 것이 유리할 것이다.
        
        종류 ]
            PRIMARY KEY
            ==> 한행을 특정해서 조회할 수 있는 제약조건
                따라서 NULL이 입력되면 안되고 다른 행들의 데이터와 구분되는
                유일한 속성값을 가져야 한다.
                
            FOREIGN KEY
            ==> 분리된 테이블에 입력된 데이터를 사용하는 제약조건
                참조하는 테이블에 입력되지 않는 데이터가 입력되는 것을 방지하는
                기능을 가지고 있는 제약조건
            
            UNIQUE
            ==> 속성의 속성값이 다른 레코드(행)의 속성값과는 구분되는 유일한 값으로
                입력이 되어야 하는 제약조건
                즉, 이전에 입력된 속성값이 입력되면 그 행의 데이터 입력을 못하도록 막는 기능의 제약조건
                대신 NULL은 입력할 수 있다.
            
            NOT NULL
            ==> 이 제약조건이 지정된 컬럼의 데이터는 반드시 입력해줘야 하는 제약조건
                NULL 값이 입력되는 것을 방지하는 제약조건
            
            CHECK
            ==> 입력되는 데이터가 지정한 조건에 맞는 데이터만 입력을 허용하는 제약조건
                입력조건에 맞지 않은 데이터가 입력이 되면 그 행은 입력 못하도록 막는 제약조건
                
        ***
        위의 제약조건중 한개라도 위배되는 데이터가 입력되면
        입력되는 그 행은 아예 입력이 안된다.

참고 ]
    제약조건 추가하는 방법은 DDL 명령 형식 후에 다시 이어서 하자.
        
------------------------------------------------------------------------------------------------------
    
    DDL(Data Definition Language) : 데이터 정의 언어
    
    1. CREATE
    ==>  개체를 만드는 명령
        
        형식 ]
            CREATE 개체형태 개체이름(
            
            );
            
            테이블 형식 1 ]
                
                CREATE TABLE 테이블이름(
                    컬럼이름 데이터타입(길이) [ DEFAULT 데이터 ],
                    ...
                );
            
            *****
            테이블 형식 2 ] - 컬럼정의 하면서 제약조건 추가하는 방법
                CREATE TABLE 테이블이름(
                    컬럼이름 데이터타입(길이) [ DEFAULT 데이터 ]
                        CONSTRAINT 제약조건이름 제약조건1
                        CONSTRAINT 제약조건이름 제약조건2
                        ...                 ,
                    컬럼이름 데이터타입(길이) [ DEFAULT 데이터 ]
                        CONSTRAINT 제약조건이름 제약조건1
                        CONSTRAINT 제약조건이름 제약조건2
                    ...
                );
                
            테이블 형식 3 ] - 컬럼정의 모두 한 후에 제약조건을 추가하는 방법
                
                CREATE TABLE 테이블이름(
                    컬럼이름 데이터타입(길이) [ DEFAULT 데이터 ] [ NOT NULL ],
                    컬럼이름 데이터타입(길이) [ DEFAULT 데이터 ] [ NOT NULL ],
                    ....
                    CONSTRAINT 제약조건이름 컬럼이름 제약조건,
                    CONSTRAINT 제약조건이름 컬럼이름 제약조건,
                    ...
                );
        
        참고 ]
            제약조건 추가형식 ]
                
                PK
                ==> 
                    CONSTRAINT 제약조건이름 PRIMARY KEY[ (컬럼이름) ]
                FK
                ==> 
                    CONSTRAINT 제약조건이름 REFERENCES 참조테이블이름(컬럼이름) ==> 컬럼에서 추가하는 경우
                    CONSTRAINT 제약조건이름 FOREIGN KEY(컬럼이름) REFERENCES 참조테이블이름(컬럼이름) ==> CREATE 명령 아랫부분에 추가하는 경우
                
                UK
                ==>
                    CONSTRAINT 제약조건이름 UNIQUE    -- 형식2
                    CONSTRAINT 제약조건이름 UNIQUE(컬럼이름) -- 형식3
                
                NN
                ==>
                    CONSTRAINT 제약조건이름 NOT NULL  -- 형식2
                    
                CK
                ==>
                    CONSTRAINT 제약조건이름 CHECK (컬럼이름 IN (데이터1, 데이터2, ...))
                    
            참고 ]
                제약조건이름 작성 규칙
                    
                    테이블이름_컬럼이름_제약조건타입
                    예 ]
                        CONSTRAINT EMP_NO_PK PRIMARY KEY
                        
            참고 ]
                제약조건 추가시 이름을 지정하지 않으면
                오라클이 자동으로 생성해서 붙여주게 된다.
                문제는 이 이름으로 위배된 제약조건을 확인하기가 어려워진다는 점이다.
                데이터 입력시 제약조건이 위배됬을 때 이름으로 위배된 제약조건을 
                확인이 가능하다면 수정도 빠르게 할 수 있다.

    2. ALTER
    
    3. DROP
    
    4. TRUNCATE




            
*/

-- 회원정보테이블
CREATE TABLE member(
    mno NUMBER(4) 
        CONSTRAINT MEMB_NO_PK PRIMARY KEY,
    name VARCHAR2(15 CHAR)
        CONSTRAINT MEMB_NAME_NN NOT NULL,
    id VARCHAR2(10 CHAR)
        CONSTRAINT MEMB_ID_UK UNIQUE
        CONSTRAINT MEMB_ID_NN NOT NULL,
    pw VARCHAR2(12 CHAR)
        CONSTRAINT MEMB_PW_NN NOT NULL,
    mail VARCHAR2(30 CHAR)
        CONSTRAINT MEMB_MAIL_UK UNIQUE
        CONSTRAINT MEMB_MAIL_NN NOT NULL,
    tel VARCHAR2(13 CHAR)
        CONSTRAINT MEMB_TEL_UK UNIQUE
        CONSTRAINT MEMB_TEL_NN NOT NULL,
    joinDate DATE DEFAULT SYSDATE
        CONSTRAINT MEMB_DATE_NN NOT NULL,
    gen CHAR(1) 
        CONSTRAINT MEMB_GEN_CK CHECK(gen IN ('F', 'M'))
        CONSTRAINT MEMB_GEN_NN NOT NULL,
    avatar NUMBER(2)
        CONSTRAINT MEMB_AVT_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT MEMB_SHOW_CK CHECK (isshow IN ('Y', 'N'))
        CONSTRAINT MEMB_SHOW_NN NOT NULL
);

-- 회원추가
INSERT INTO
    member(mno, name, id, pw, mail, tel, gen, avatar)
VALUES(
    (SELECT NVL(MAX(mno) + 1, 1001) FROM member),
    '김제니', 'jennie', '12345', 'jennie@human.com', '010-1212-1212', 'F', 15
);

INSERT INTO
    member(mno, name, id, pw, mail, tel, gen, avatar, joindate)
VALUES(
    1000,
    '전은석', 'euns', '12345', 
    'euns@human.com', '010-0000-0000', 'M', 12,
    sysdate
);

commit;

CREATE TABLE board(
    
);



















