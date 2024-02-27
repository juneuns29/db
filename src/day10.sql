-- day10

/*
    DML 명령
        C   INSERT  : 데이터 추가 명령
        R   SELECT  : 데이터 조회 명령
        U   UPDATE  : 데이터 수정 명령
        D   DELETE  : 데이터 삭제 명령
        
    DDL 명령
        
        CREATE      : 개체를 생성하는 명령
        ALTER       : 개체를 수정하는 명령
        DROP        : 개체를 삭제하는 명령
        TRUNCATE    : 테이블 데이터를 잘라내는 명령
        
    DCL(Data Coltrol Language : 데이터 제어 언어)
        
        TCL(Transaction Control Language : 트랜젝션 제어 언어)
        ==> 
            트랜젝션
            : DBMS가 처리할 명령의 단위
            
                예를 들면 CREATE TABLE xxxx(....); 라는 명령을 기술하고 엔터키를 누르면
                이 명령이 실행되는데(==> 테이블이 만들어진다.)
                이 말을 다르게 표현하면 "트랜젝션이 실행(처리)되었다." 라고 표현한다.
                
                위 예 처럼 대부분의 명령은 엔터키를 누르는 순간 명령이 실행되고
                그것은 다시 말해서 트랜젝션이 처리되는 것이므로
                따라서 오라클은 명령 한 개가 곧 하나의 트랜젝션이 된다.
                
                그런데 DML 명령 만큼은 트랜젝션의 단위가 달라진다.
                    참고 ] DML 명령 : INSERT, UPDATE, DELETE
                
                ==> DML 명령은 명령을 실행하면 바로 데이터베이스에 적용시키는 것이 아니고
                    버퍼 장소(임시 기억장소)에 그 명령을 모아만 놓는다.
                    결국 트랜젝션이 처리되지 않는 것이 된다.
                    
                따라서 DML 명령은 강제로 트랜젝션을 처리하는 명령을 실행해야 한다.
                이때 트랜젝션은 한번만 처리된다.
                
                이유 ]
                    DML 명령은 데이터를 변경하는 명령이다.
                    데이터베이스에서 가장 중요한 개념은 "데이터의 무결성"이다.
                    이런 곳에서 DML 명령이 매번 바로바로 트랜젝션을 처리하게 되면
                    데이터의 무결성이 사라질 수 있다.
                    이런 문제를 해결하기 위해서 제시한 방법이 "트랜젝션" 이다.
            
            ***
            버퍼에 모아놓은 명령들을 트랜젝션 처리하는 방법
                
                자동 트랜젝션 처리
                    1. SQLPLUS를 정상적으로 종료하는 순간 트랜젝션 처리가 일어난다.
                        
                        sql> exit 엔터 ==> 순간 자동으로 트랜젝션 처리가 된다.
                        
                    2. DDL 명령이나 DCL 명령을 실행하는 순간 트랜젝션 처리가 된다.
                    
                수동 트랜젝션 처리
                    
                    1. commit 명령을 실행하는 순간 트랜젝션 처리가 된다.
            
            ***
            버퍼에 모아놓은 명령들이 트랜젝션 처리가 되지 않는 경우
            ==> 명령들이 데이터베이스에 적용되지 않고 버려지는 경우
                
                자동으로 처리가 되지 않는 경우
                    1. 정전(천재지변) 등에 의해서 시스템이 셧다운 되는 경우
                    2. sqlplus  에서 비정상적으로 종료하는 경우
                    
                수동으로 처리가 되지 않게 버려지는 경우
                    
                    1. rollback 명령을 실행시키는 순간
                    
        ***
        ==> 결론적으로 DML 명령으로 
            데이터를 조작하는 작업이 완벽하다고 판단이 되면
                COMMIT 이라는 명령을 실행시켜서 트랜젝션을 처리하고(데이터베이스에 적용시키고)
            만약 작업이 완벽하지 않다면
                ROLLBACK  이라는 명령으로 이전의 작업들을 취소하고
                마지막 COMMIT 시점으로 되돌려서 다시 작업을 하면 된다.
            
        ROLLBACK 시점 만들기
        ==> DML 명령을 실행할 때 특정 위치에 책갈피(ROLLBACK 할 수 있는 시점)를 만들어 놓을 수 있다.
            
            이렇게 하면 그 시점을 이용해서 ROLLBACK 할 수 있는 지점을 지정할 수 있다.
            
            형식  ]
                SAVEPOINT 이름;
                
            사용방법 ]
                
                ROLLBACK TO 이름;
                
                예 1 ]
                    
                    1) DML
                    2) DML
                    3) DML
                    SAVEPOINT A;
                    4) DML
                    5) DML
                    6) DML
                    SAVEPOINT B;
                    7) DML
                    8) DML
                    9) DML
                    
                    ROLLBACK TO B; ==> 7, 8, 9 작업 취소
                    ROLLBACK;       ==> 1 ~ 9 모든 작업 취소, SAVEPOINT와 모든 DML 명령이 취소 된다.
                    ROLLBACK TO A; ==> 4 ~ 9 작업 취소, 마지막  COMMIT 상태로는 되돌릴 수 있는 상태
                    
                예 2 ]    
                    SAVEPOINT A;
                    1) DML
                    2) DML
                    CREATE TABLE ....();
                    3) DML
                    
                    인 경우
                    ROLLBACK TO A; 
                    ==> 에러발생 : CREATE 명령을 실행시키는 순간 
                                    이전에 작업했던 내용은 모두 데이터베이스에 일괄 적용되고
                                    SAVEPOINT 와 실행했던 명령들은 모두 지워지게 된다.
                                    
                    ROLLBACK;
                    ==> CREATE 명령 직후의 시점으로 되돌아간다. 3번만 취소된다.
                        <== DDL  명령은 자동 커밋이 되기 때문에...
    
    참고 ]
        계정 만들기
            형식 ]
                CREATE USER 계정이름 IDENTIFIED BY 비밀번호;
                ==> 비밀번호로 계정이름의 사용자를 만든다.
                CREATE USER 계정이름 IDENTIFIED BY 비밀번호 ACCOUNT UNLOCK;
                ==> 사용자를 만들고 해당계정을 잠금해제한다.
                
                
                -- 계정생성
                CREATE USER jennie IDENTIFIED BY 12345 ACCOUNT UNLOCK;
                --테이블 스페이스 지정
                GRANT UNLIMITED TABLESPACE TO jennie;
                -- 기본 테이블스페이스 설정
                ALTER USER jennie DEFAULT TABLESPACE USERS;
                -- 임시 테이블스페이스 설정
                ALTER USER jennie TEMPORARY TABLESPACE TEMP;
                
                -- 권한부여
                GRANT CONNECT, RESOURCE TO jennie;
    
    
        권한 명령 : 관리자 계정에서 작업해야 한다.
        ==> 
             GRANT  : 권한을 부여하는 명령
                
                형식 ]
                    
                    GRANT 권한이름, 권한이름, ... TO 계정이름;
             
             REVOKE : 부여했던 권한을 회수하는 명령
                
                형식 ]
                    
                    REVOKE 권한이름 FROM 계정이름;
                    
            참고 ]
                현재 접속계정 알아보기
                    명령 ]
                        SHOW USER;
                        
            참고 ]
                사용자계정을 만들게 되면 그 계정은 아무 권한도 부여받지 않은 상태로 만들어지게 된다.
                그런데 데이터베이스에 접속할 수 있는 것도 권한에 해당한다.
                그 권한의 이름이 "CREATE SESSION" 이다.
                이 권한은 접속할 수 있는 권한만 해당한다.
                
            부여방법 ]
                GRANT CREATE SESSION TO jennie;
                
    ----------------------------------------------------------------------------
    ROLE을 이용한 권한 부여
        
        ROLE
        ==> 관련된 권한을 묶어놓은 객체(권한 세트)
            
            따라서 롤을 이용한 권한 부여는
            여러개의 권한을 한번에부여하는 방법이다.
            
            1. 이미 만들어진 롤을 이용하는 방법
                
                1) CONNECT
                ==> 주로 CREATE 명령과 관련된 권한을 묶어 놓은 롤
                
                2) RESOURCE
                ==> 사용자 객체 생성에 관련된 권한을 묶어 놓은 롤
                
                3) DBA
                ==> 관리자 계정에서 처리할 수 있는 관리자 권한을 묶어놓은 롤
                
                부여방법 ]
                    
                     GRANT 롤이름, 롤이름, ... TO 계정이름;
*/

-- 관리자 계정으로 실행
CREATE USER jennie IDENTIFIED BY 12345 ACCOUNT UNLOCK;
GRANT UNLIMITED TABLESPACE TO jennie;
ALTER USER jennie DEFAULT TABLESPACE USERS;
ALTER USER jennie TEMPORARY TABLESPACE TEMP;

SHOW USER;

GRANT CREATE SESSION TO jennie;

-- 테이블 생성 권한 부여
GRANT CREATE TABLE TO jennie;

-- 세션과 테이블 생성 권한 회수
REVOKE CREATE SESSION FROM jennie;
REVOKE CREATE TABLE FROM jennie;

-- jennie 계정에게 CONNECT, RESOURCE 롤을 이용해서 권한을 부여
GRANT CONNECT, RESOURCE TO jennie;




























