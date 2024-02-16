/*
    NULL 데이터 비교
    ==> NULL 데이터는 모든 연산에서 제외가 된다.
        따라서 조건식에서 동등 비교연산자로 비교를 하면
        연산이 안되므로
        비교를 할려면 별도의 처리가 필요하다.
        
        형식 ]
            동등비교 ]
                필드이름(또는 데이터) IS NULL
            
            부정비교 ]
                필드이름(또는 데이터) IS NOT NULL
*/

-- 사장님의 사원번호, 사장이름, 입사일, 급여 를 조회하세요.
SELECT
    empno 사원번호, ename 사장이름, hiredate 입사일, sal 급여
FROM
    emp
WHERE
--    mgr = NULL -- NULL데이터는 모든 연산에서 제외가 되므로 비교연산자로 비교할 수 없다.
    mgr IS NULL
;

/*
    집합연산자
    ==> 두개 이상의 SELECT 질의명령을 이용해서
        그 결과의 집합을 얻어내는 방법
        
        종류 ]
            
            UNION
            ==> 합집합의 개념
                두가지 질의명령의 결과를 하나로 합쳐서 조회하는 것.
                단, 중복데이터는 한번만 조회
                
            UNION ALL
            ==> 합집합의 개념
                중복데이터를 집합의 갯수만큼 조회
                
            INTERSECT
            ==> 교집합의 개념
                조회질의명령의 결과 중에서 모두 포함된 데이터만 조회
                
            MINUS
            ==> 차집합의 개념
                앞의 질의명령의 결과에서 뒤의 질의명령의 결과를 제외한 결과를 조회
                
        참고 ]
            공통적인 특징
                1. 두 질의 명령에서 나온 결과는 같은 컬럼의 갯수를 가져야 한다.
                    
                    예 ]
                        SELECT
                            job, empno
                        FROM
                            emp
                        UNION
                        SELECT
                            ename, deptno
                        FROM
                            emp
                        ;
                
                2. 두 질의 명령에서 나온 결과는 같은 형태의 필드여야 한다.
                    이때 크기는 따지지 않는다.
                    
                    예 ]
                        SELECT
                            ename, sal
                        FROM
                            emp
                        UNION
                        SELECT
                            ename, job
                        FROM
                            emp
                        ;
*/

SELECT
    job, empno
FROM
    emp
UNION
SELECT
    ename, sal
FROM
    emp
;

SELECT
    ename, sal
FROM
    emp
UNION
SELECT
    comm || '', job -- 데이터 형태가 일치하지 않으므로 에러 발생
FROM
    emp
;

-- 실습준비
CREATE TABLE semp1
AS
    SELECT
        ename, job, sal, hiredate, deptno
    FROM
        emp
    WHERE
        job = 'MANAGER'
;

-- 사원이름이 다섯글자인 사원들만 테이블로 다시 만들기
CREATE TABLE semp2
AS
    SELECT
        ename, job, sal, hiredate, deptno
    FROM
        emp
    WHERE
        ename LIKE '_____'
;

-- 급여가 1500 보다큰 사원들의 테이블
CREATE TABLE semp3
AS
    SELECT
        ename, job, sal, hiredate, deptno
    FROM
        emp
    WHERE
        sal > 1500
;

-----------------------------------------------------------------------

-- semp2테이블과 semp3 테이블의 내용을 합쳐서 조회하세요.
-- ==> 사원이름이 다섯글자인 사람들의 정보와
--      급여가 1500보다 큰 사원들의 정보를 합쳐서 조회하세요.
SELECT
    *
FROM
    semp2
UNION
SELECT
    *
FROM
    semp3
;

-- 중복 데이터도 그대로 조회
SELECT
    *
FROM
    semp2
UNION ALL
SELECT
    *
FROM
    semp3
;

-- SEMP2테이블과 SEMP3테이블에 모두 포함된 사원을 조회하세요.
-- 이름글자수가 5글자이고 급여도 1500이 넘는 사원을 조회하세요.

SELECT
    *
FROM
    semp2
INTERSECT
SELECT
    *
FROM
    semp3
;

-- 이름글자수가 5글자인 사원중 급여가 1500 이하인 사원들만 조회하세요.
SELECT
    *
FROM
    semp2
MINUS
SELECT
    *
FROM
    semp3
;

/*
    참고 ]
        집합연산의 결과도 정렬할 수 있다.
        정렬방식은 일반질의명령과 똑같이 ORDER BY 절에서 정의하면 된다.
        집합연산의 결과를 이용해서 정렬을 하기때문에
        맨 마지막에 정의하는 것이 원칙이다.
*/

SELECT
    ename name, sal money, hiredate hdate
FROM
    semp2
UNION ALL
SELECT
    ename, sal, hiredate
FROM
    semp3
ORDER BY
    name DESC, money 
    -- 이름순으로 내림차순정렬하고 
    -- 이름이 같으면 급여를 이용해서 오름차순정렬
;

SELECT
    ename name, sal money, hiredate hdate
FROM
    emp
WHERE
    LENGTH(ename) = 5
ORDER BY
    name, sal desc
;

--------------------------------------------------------------------------------
/*
    함수(FUNCTION)
    ==> 데이터를 가공하기 위해서 오라클이 제공하는 기능
        
        참고 ]
            DBMS는 데이터베이스 벤더 마다 다르다.
            특히 함수는 더 다르다.
            
        종류 ]
            1. 단일행 함수
            ==> 한행 꺼내올 때 마다 실행될 수 있는 함수
                ( ==> 데이터 한개만 있어도 처리할 수 있는 함수)
                따라서 단일행 함수는 처리 결과가 데이터의 갯수와 동일하다.
                
            2. 그룹 함수
            ==> 여러행을 모아서 그룹화 해서 처리하는 함수
                따라서 단일행 내에서는 처리가 안되는 함수
            
            *****
            참고 ]
                단일행함수와 그룹함수는 절대로 같이 사용할 수 없다.
 ----------------------------------------------------------------------------               
    참고 ]
        DUAL 테이블
            단일행 함수는 데이터의 갯수만큼 실행한다.
            데이터가 많이 존재하는 테이블에서 테스트를 하면
            결과가 데이터의 갯수만큼 조회가 된다.
            이것은 일반 연산도 마찬가지다.
            이런 불편함을 줄이기 위해서 오라클이 제공해주는 
            임시테이블(의사테이블)이 DUAL 테이블이다.
            
            이 테이블은 한행으로만 구성되어있다.
            따라서 단일행 함수의 실행결과도 한행으로 조회가 된다.
 ----------------------------------------------------------------------------
        
        1. 단일행 함수
            
            오라클에서 자주 사용하는 데이터의 형태는 세가지가 있다.
            
            NUMBER              : 숫자
            CHAR || VARCHAR2    : 문자
                CHAR        : 고정길이형 문자타입
                VARCHAR2    : 가변길이형 문자타입
            
            DATE                : 날짜 & 시간
           
           
            형변환 함수 ]
            
                    TO_CHAR()       TO_CHAR()
                    ------->        <------
            숫자              문자          날짜
                    <--------       ------->
                    TO_NUMBER()     TO_DATE()
                    
                    <---------------------->
                                X
            
            1) 숫자 함수
            ==> 데이터가 숫자인 경우에만 사용할 수 있는 함수
                
                ABS()       : 절대값 반환해주는 함수
                        
                                ABS(숫자데이터 또는 연산식)
                
                FLOOR()     : 소수점 이하를 버리는 함수(정수 만들어주는 함수)
                                FLOOR(숫자데이터 또는 연산식)
                                
                ROUND()     : 지정한 자리수에서 반올림해주는 함수
                                ROUND(숫자데이터[, 보여질자릿수])
                                -- 자릿수를 음수로 지정하면 
                                    소수점이상 해당 자릿수에서 반올림
                                    
                TRUNC()     : FLOOR() 함수와 마찬가지로 버림하는 함수
                                차이점이 버리는 자릿수를 지정해 줄 수 있다.
                                
                                TRUNC(숫자데이터[, 자릿수])
                                
                MOD()       : 나머지 구하는 함수
                                
                                MOD(숫자1, 숫자2)
                                ==> 숫자1을 숫자2로 나눈 나머지를 반환
                                
        참고 ]
            모든 함수는 SELECT절에도 사용가능하고
            WHERE절(조건절)에도 사용가능 하다.
            
            2) 날짜 함수
            
            3) 문자 함수
                
                LOWER()     - 소문자로 반환해주는 함수
                UPPER()     - 대문자로 반환해주는 함수
                INITCAP()   - 첫글자는 대문자 나머지는 소문자로 반환해주는 함수
                
                LENGTH() / LENGTHB() - 문자열의 길이를 반환해주는 함수
                                        B가 붙은 함수들은 byte 단위로 처리해주는 함수
                                        
                CONCAT()    - 두개의 문자열을 합쳐서 반환해주는 함수
                    
                    형식 ]
                        CONCAT(데이터1, 데이터2)
                        
                    참고 ]
                        입력되는 데이터가 한개가 문자데이터면 결합이 가능하다.
                        
                SUBSTR() / SUBSTRB() - 문자열 중에서 특정 부분의 문자열을 추출해서 반환해주는 함수
                
                    형식 ]
                        SUBSTR(데이터, 시작위치, 갯수)
                        
                    ***
                    참고 ]
                        데이터베이스에서는 위치값이 1 부터 시작한다.
                        
                    갯수는 생략할 수 있다.
                    생략하면 맨 뒤까지 모두 추출해서 반환해준다.
                    
                    참고 ]
                        위치값을 음수로 사용할 수 있다.
                        이때는 맨뒤에서 부터 위치를 의미한다.
                        
                INSTR() / INSTRB()
                ==> 문자열 중에서 원하는 문자열의 위치값을 반환해주는 함수
                    
                    형식 ]
                        INSTR(데이터1, 데이터2[, 시작위치, 출현횟수])
                        
                    참고 ]
                        시작위치를 음수로 사용할 수 있다.
                        음수를 쓰게되면 뒤에서 부터의 위치를 의미한다.
                        그런데 검색방향도 뒤에서부터 찾기 시작한다.
                        
                    참고 ]
                        찾는 문자가 없으면 0 을 반환해준다.
                        
                LPAD() / RPAD()
                ==> 문자열의 길이를 지정해주고
                    남는 공간에 지정한 문자들로 채워주는 함수
                    왼쪽에 채우면 LPAD()
                    오른쪽에 채우면 RPAD()
                    
                    형식 ]
                        LPAD(데이터, 길이, 채울문자)
            
*/

SELECT 
    347824 * 3421903 계산
FROM
    dual
;

-- abs()
SELECT ABS(23412321-789072143) "ABS" FROM DUAL;

-- FLOOR
SELECT FLOOR(3.5411592) FLOOR FROM DUAL;

-- ROUND
SELECT ROUND(3.541592) ROUND FROM dual;
SELECT ROUND(3.541592, 3) ROUND FROM dual;
-- 사원들의 급여를 10단위에서 반올림해서 사원이름, 급여를 조회하세요.
SELECT ename 사원이름, ROUND(sal, -2) 인상급여 FROM emp;

-- TRUNC
SELECT TRUNC(3.541592, 3) TRUNC FROM dual;

SELECT ename 사원이름, sal - TRUNC(sal, -3) 신급여 FROM emp;

-- 급여가 짝수인 사원들의 사원이름, 급여를 조회하세요.
SELECT
    ename 사원이름, sal 급여
FROM
    emp
WHERE
    MOD(sal, 2) = 0 -- 급여가 짝수
;


-- 사원들의 급여가 백단위가 짝수인 사원들만 조회하세요.
--  사원이름, 급여
SELECT
    ename, sal, MOD(FLOOR(sal / 100), 2) 나머지1, 
    MOD(TRUNC(sal, -2) / 100, 2) 나머지2
FROM
    emp
WHERE
    MOD(FLOOR(sal / 100), 2) = 0
;

-- 사원들의 이름을 소문자, 대문자, 첫문자만대문자로 조회하세요.
SELECT
    ename, LOWER(ename) 소문자, 
    UPPER(LOWER(ename)) 다시대문자, 
    INITCAP(ename) 첫문자만대문자,
    INITCAP(ename || ' ' || job) 단어첫문자만대문자
FROM
    emp
;

SELECT
    LENGTH('제니') "제니 문자 수",
    LENGTHB('제니') "제니 바이트 수"
FROM
    dual
;

SELECT CONCAT(1, 2) SOO1, 1 || 2 SOO2 FROM dual;

SELECT
    ename, SUBSTR(ename, -2, 1) "뒤에서 두번째 문자", SUBSTR(ename, -2) "마지막 두글자"
FROM
    emp
;

-- SUBSTRB()
SELECT
    SUBSTRB('제니', 2), LENGTHB(SUBSTRB('제니', 2))
FROM
    dual
;

-- INSTR()
SELECT
    INSTR('jennie jennie', ' ', 2),
    INSTR('jennie jennie', 'n', 2, 3),
    INSTR('jennie', 'n', -2, 2)
FROM
    dual
;

-- 사원들중 이름에 'M' 문자가 포함되지 않은 사원들의 사원이름, 직급 을 조회하세요.
SELECT
    ename 사원이름, job 직급
FROM
    emp
WHERE
    INSTR(ename, 'M') = 0
;

-- 사원들중 이름에 'M' 문자가 포함된 사원들의 사원이름, 급여를 조회하세요.
SELECT
    ename 사원이름, sal 급여
FROM
    emp
WHERE
    INSTR(ename, 'M') <> 0
;

-- 사원들의 이름을 처음 두글자를 추출하세요.
-- 추출한 문자를 열글자로 만들고 남는 부분은 왼쪽에 '*'로 채워주세요.
-- 추출한 문자를 이름글자수로 만들고 남는 부분은 오른쪽에 '#'로 채워주세요.
SELECT
    ename 사원이름,
    SUBSTR(ename, 1, 2) 처음두글자,
    LPAD(SUBSTR(ename, 1, 2), 10, '*') 채운열글자이름,
    RPAD(
        SUBSTR(ename, 1, 2), 
        LENGTH(ename), 
        '#'
    ) 이름감추기
FROM
    emp
;

--  문제 ] 'jennie@human.com' 계정의 아이디중 첫번째 문자와 세번째문자는 추출 나머지는 *로
--          @ 추출
--          도메인의 세번째 문자는 추출
--          .com 은 보여지게...