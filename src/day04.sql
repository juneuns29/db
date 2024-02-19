-- day04

/*
    문자열 처리함수
        
        REPLACE()
        ==> 문자열의 특정 부분을 다른 문자열로 대체해서 반환해주는 함수
            
            형식 ]
                REPLACE(데이터, 찾을문자열, 대체문자열)
        TRIM()
        ==> 문자열 중에서 앞 또는 뒤에 있는 지정한 문자를 모두 삭제하는 함수
        
            형식 ]
                TRIM(삭제할문자 FROM 데이터)
            
            참고 ]
                같은 문자가 앞, 뒤에 연속되어 있으면 모두 지울 수 있다.
                
            참고 ]
                가끔 데이터 앞 뒤에 공백 문자가 들어간 경우가 있다.
                이런 경우를 대비해서 앞 뒤에 들어간 공백문자를 제거할 목적으로
                많이 사용한다.
                
            1) LTRIM()
            2) RTRIM()
                형식 ]
                    LTRIM(데이터, 삭제할문자)
                
        ASCII()
        ==> 문자열의 첫번째문자에 해당하는 ASCII 코드값을 반환해준다.
            
            형식 ]
                ASCII(데이터)
                
        CHR()
        ==> ASCII코드를 입력하면 코드에 해당하는 문자를 반환해주는 함수
            
            형식 ]
                CHR(코드값)
                
        TRANSLATE()
        ==> REPLACE()와 마찬가지로 문자열 중 지정한 부분을 
            다른 문자열로 대체해주는 함수
            
            차이점 ]
                REPLACE() 바꿀문자열의 형태가 정확하게 일치해야하고
                            문자열 전체를 교체
                TRANSLATE() 문자단위로 처리
        
*/

-- REPLACE()
SELECT
    REPLACE('Hong Gil Dong', ' ', '/') 홍길동,
    REPLACE('Gho Gil Dong', 'D', 'DD') 고길동,
    REPLACE('Kim Gil Dong', 'O', 'OO') 김길동
FROM
    dual
;

-- TRIM()
SELECT
    TRIM(' ' FROM '             HONG GIL   DONG              ') 홍길동,
    REPLACE('HONG GIL   DONG', '  ', '')  홍길동2
FROM
    dual
;

SELECT
    ASCII('HONG') 아스키코드,
    CONCAT(ASCII('HONG'), '') 아스키코드2,
    CHR(ASCII('HONG')) 문자
FROM
    dual
;

-- TRANSLATE()
SELECT
    TRANSLATE('ABCDBACE', 'ABCD', '1234') 번역
FROM
    dual
;

--------------------------------------------------------------------------------
/*
    날짜 함수
        참고 ]
            오라클에서 날짜 데이터는 1970년 1월 1일 0시 0분 0초를 기준으로
            숫자형식의 날짜 연번을 이용해서 관리한다. 
            
            형식 ]
                날수.시간
        
        ***
        참고 ]
            SYSDATE
            ==> 예약어로 질의명령이 실행되는 순간의 날짜/시간을 기억하고 있는 변수
            
        참고 ]
            날짜 - 날짜 연산식은 허락한다.
            ==> 날짜 연번끼리 - 연산을 한다.
            
        참고 ]
            날짜 + 숫자 연산을 허락한다.
            ==> 날짜연번의 날수가 숫자이므로
                날짜를 이용해서 연산한다.
                따라서 날짜에서 숫자만큼 이동된 날짜를 조회하게 된다.
                
                
    함수들 ]
        
        ADD_MONTHS()
        ==> 현재 날짜에 지정한 개월수를 더하거나 뺀 날짜를 반환해준다.
        
            형식 ]
                ADD_MONTHS(날짜데이터, 개월수)
                
            참고 ]
                개월수가 음수면 해당 개월 수를 뺀 날짜를 반환
                
                
        MONTHS_BETWEEN()
        ==> 두 날짜 사이의 간격을 월단위로 알려주는 함수
        
            형식 ]
                MONTHS_BETWEEN(날짜, 날짜)
                
        LAST_DAY()
        ==> 입력한 날짜가 포함된 월의 마지막 날짜데이터를 반환
        
        NEXT_DAY()
        ==> 지정한 날 이후 처음 오는 지정 요일의 날짜데이터를 반환
            
            형식 ]
                NEXT_DAY(날짜, '요일')
                
        NLS 셋팅 :
                    RRRR/MM/DD HH24:MI:SS
                
            참고 ]
                요일 지정하는 방법
                    1. 우리의 경우 한글 셋팅이 된 오라클 이므로
                        '월', '화',...
                        '월요일', '화요일', ...
                    2. 영문권인 경우
                        'MON', ...
                        'MONDAY', ...
        
        ROUND()
        ==> 날짜를 지정한 기준으로 반올림해주는 함수
            
            지정한 기준]
                년, 월, 일, 시간, 분, 초
                
            형식 ]
                ROUND(날짜, '기준')
                
    ----------------------------------------------------------------------------
    
    형변환 함수
    ==> 오라클에서 함수는 데이터의 형태에 따라서 사용할 수 있는 함수가 달라진다.
        만약 사용하려는 함수에 필요한 데이터가 아닌경우에는 문제가 생길 수 있다.
        이럴 때 사용하는 함수가 형변환함수이다.
        ==> 데이터의 형태를 바꿔서 특정 함수에 사용가능하도록 만들어주는 함수
        
    참고 ]
                
                    TO_CHAR()       TO_CHAR()
                    ------->        <------
            숫자              문자          날짜
                    <--------       ------->
                    TO_NUMBER()     TO_DATE()
                    
                    <---------------------->
                                X
                                
        1. TO_CHAR()
            ==> 날짜나 숫자를 문자 데이터로 변환해주는 함수
                
                형식 1 ]
                    TO_CHAR(날짜 또는 숫자)
                    
                    '2024/02/19' 의 경우 공통적으로 사용하는 날짜 형식이므로
                    형식을 지정해주지 않아도 형변환을 해준다.
                    
                    2024.02.19
                    2024-02-19
                    
                형식 2 ]
                    TO_CHAR(날짜 또는 숫자, '형식문자')
                    ==> 변환할 때 원하는 형태의 문자로 변환해주는 방법
                
                        예 ]
                            현재 시간을 '월/일/두자리년도' 의 형식의 문자열로 ..
                            
                            SELECT
                                TO_CHAR(SYSDATE, 'MM/DD/YY') 현재시간
                            FROM
                                dual
                            ;
                            
                            SELECT
                                TO_CHAR(1000, '9,999,999,999.99L') 숫자1,  ==> 무효숫자 표시안함
                                TO_CHAR(1000, '0,000,000,000.00') 숫자2   ==> 무효숫자 표시
                            FROM
                                dual
                            ;
                            ==> $ 를 붙일 수 있다.
                                해당 국가의 지역화폐의 경우 'L' 을 붙여서 표현
                            
        2. TO_DATE()
            ==> 날짜형식의 문자데이터를 날짜데이터로 변환
                
                형식 1 ]
                    TO_DATE(날짜형식 문자열)
                    ==> 공통적으로 사용되는 날짜 형식은 형식을 지정하지 않아도 형변환해준다.
                        예 ]
                            1900/01/01
                            1900-01-01
                            1900.01.01
                            
                형식 2 ]
                    TO_DATE(날짜형식 문자열, '날짜형식')
                    ==> 형식이 일반적이지 않은 경우 날짜 형식을 지정해서 날짜데이터로 변환
                    
                    형식문자 ]
                        YYYY    - 4자리 년도
                        YY      - 두자리 년도
                        MM      - 두자리 월
                        DD      - 두자리 일
                        DAY     - 요일
                        DY      - 요일 약자
                        
        3. TO_NUMBER()
            ==>  숫자형식의 문자열을 숫자로 변환
                
                형식 ]
                    TO_NUMBER(문자열, '숫자형식')
*/

-- 현재 시간 조회
SELECT
    TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS') 현재시각
FROM
    dual
;

-- 사원들의 사원이름, 입사일, 근무일 수를 조회하세요.
SELECT
    ename 사원이름, hiredate 입사일, FLOOR(SYSDATE - hiredate) "근무일 수"
FROM
    emp
;

SELECT
    SYSDATE + 11 "11일 후"
FROM
    dual
;

-- 오늘부터 5개월 후 날짜를 조회하세요.
SELECT
    ADD_MONTHS(SYSDATE, 5) "5개월 후"
FROM
    dual
;

-- 사월들의 사원이름, 입사일, 근무 개월수를 조회하세요.
SELECT
    ename 사원이름, hiredate 입사일,
    FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) "근무 개월 수1",
    ABS(FLOOR(MONTHS_BETWEEN(hiredate, SYSDATE))) "근무 개월 수2",
    FLOOR(SYSDATE - HIREDATE) / 30 
FROM
    emp
;

-- 이번달 마지막 날
SELECT
    LAST_DAY(SYSDATE + 11)
FROM
    dual
;

-- 사원들의 입사월의 근무 일 수를 조회하세요.
SELECT
    ename 사원이름, hiredate 입사일,
    (LAST_DAY(hiredate) + 1) - hiredate "입사월 근무일 수"
FROM
    emp
;

-- 오늘 이후 처음오는 불금의 날짜를 조회하세요.
SELECT
    NEXT_DAY(SYSDATE, '금') "다음 금요일",
    NEXT_DAY(SYSDATE, '월요일') "다음 월요일"
FROM
    dual
;

-- 오늘을 년도를 기준으로 반올림한 날짜를 조회하세요.
SELECT
    ROUND(SYSDATE, 'YEAR') "반올림한 년도"
FROM
    dual
;

-- 7월 4일을 년도기준으로 반올림한 날짜를 조회하세요.
SELECT
    ROUND(TO_DATE('2024/07/04', 'YYYY/MM/DD'), 'YEAR') "반올림 날짜"
FROM
    dual
;

-- 오늘날짜를 월 기준 반올림한 날짜...
SELECT
    ROUND(SYSDATE, 'MONTH'),
    ROUND(SYSDATE, 'DD'),
    TO_CHAR(ROUND(SYSDATE, 'HH'), 'YYYY/MM/DD HH24:MI:SS')
FROM
    dual
;


-- 현재시간을 'XXXX년 XX월 XX일 XX시 XX분 XX초'의 형식으로 조회하세요.
SELECT
    TO_CHAR(SYSDATE,
        'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"'
    ) 현재시간
FROM
    dual
;

SELECT
    TO_CHAR(1000, 'L9,999,999,999.99') 숫자1,
    TO_CHAR(1000, '0,000,000,000.00$') 숫자2
FROM
    dual
;

-- 사원들의 사원이름, 입사일, 입사요일을 조회하세요.
SELECT
    ename 사원이름, hiredate 입사일, TO_CHAR(hiredate, 'DAY') 입사요일
FROM
    emp
;

-- 문제 ] 토요일, 일요일에 입사한 사원들의
--          사원이름, 입사일, 급여, 커미션
--          을 조회하세요. 커미션은 기존 커미션에 200을 더한값으로 조회하고
--          커미션이 없으면 300에서 200을 더한 값으로 조회하세요.
SELECT
    ename 사원이름, hiredate 입사일, sal 급여,
    NVL(comm, 300) + 200 커미션
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'DAY') IN ('토요일', '일요일')
;

SELECT
    TO_CHAR(SYSDATE, 'YY/MM/DD DAY'),
    TO_CHAR(SYSDATE, 'YY/MM/D DY')
FROM
    dual
;

SELECT
    TO_NUMBER('$2,345', '$9,999')
FROM
    dual
;

--------------------------------------------------------------------------------
/*
    NULL 처리함수
        
        1.
            NVL(데이터 , NULL일때 대체값)
            
        2.
            NVL2(컬럼이름, 컬럼연산식, NULL일 때 대체값)
            
        3. NULLIF()
            
            형식 ]
                NULLIF(데이터1, 데이터2)
                
            의미 ]
                [ 데이터1 ]과 [ 데이터2 ]가 같으면 [ NULL ]을 반환하고
                다르면 [데이터1] 을 반환
        
        4. COALESCE()
            
            형식 ]
                COALESCE(데이터1, 데이터2, ..... )
                
            의미 ]
                여러개의 데이터 중 가장 처음 나오는 NULL 이 아닌 데이터를 반환....
*/


/*
    토요일, 일요일에 입사한 사원들의
    사원이름, 입사일, 급여, 커미션
    을 조회하세요. 커미션은 기존 커미션에 200을 더한값으로 조회하고
    커미션이 없으면 300에서 200을 더한 값으로 조회하세요.
*/
SELECT
    ename 사원이름, hiredate 입사일, sal 급여,
    NVL2(comm, comm + 200, 500) 커미션
FROM
    emp
WHERE
--    TO_CHAR(hiredate, 'DY') IN ('토', '일')
    SUBSTR(TO_CHAR(hiredate, 'DAY'), 1, 1) IN ('토', '일')
;

/*
    사원들의
        사원이름, 입사일, 급여, 커미션, 지급액
    을 조회하세요.
    
    지급액은 커미션으로 하고 커미션이 없으면 급여로 지급하고 급여도 없으면 0으로 지급하도록 한다.
*/
SELECT
    ename 사원이름, hiredate 입사일, sal 급여, comm 커미션, COALESCE(comm, sal, 0) 지급액
FROM
    emp
;



/*
    조건처리함수
        
        ==> 함수라기 보다는 명령에 가까운 것으로
            자바의 switch - case, if 를 대신하기 위해서 만들어 놓은 것
            
        1. DECODE()
        ==> 자바의 SWITCH 문에 해당하는 함수
        
            형식 ]
                DECODE(컬럼이름, 데이터1, 반환값1,
                                데이터2, 반환값2,
                                ...
                                반환값N
                )
                ==> 컬럼의 내용이 데이터1과 같으면 반환값1을 반환하고
                                데이터2와 같으면 반환값2를 반환하고
                                ...
                                맞는게 없으면 반환값N을 반환해준다.
        
        2. CASE WHEN THEN
            
            형식 1 ]
                
                CASE WHEN 조건식1 THEN 처리내용1
                     WHEN 조건식2 THEN 처리내용2
                     ....
                     ELSE 처리내용N
                END
                
            형식 2 ] ==> DECODE()와 같은 의미
                
                CASE 컬럼이름 WHEN 데이터1 THEN 처리내용1
                              WHEN 데이터2 THEN 처리내용2
                              ...
                              ELSE 처리내용N
                END
*/

/*
    예제 ]
        사원들의 
            사원이름, 직급, 부서번호, 부서이름
        을 조회하세요.
        부서이름은
            10 - 영업부
            20 - 총무부
            30 - 전산부
            그 이외는 '인턴'
        으로 조회하기로 한다.
*/

SELECT
    ename 사원이름, job 직급, deptno 부서번호,
    DECODE(deptno, 10, '영업부',
                20, '총무부',
                30, '전산부',
                '인턴'
    ) 부서이름,
    CASE deptno WHEN 10 THEN '영업부'
                WHEN 20 THEN '총무부'
                WHEN 30 THEN '전산부'
                ELSE '인턴'
    END 부서명칭,
    CASE WHEN deptno = 10 THEN '영업부'
         WHEN deptno = 20 THEN '총무부'
         WHEN deptno = 30 THEN '전산부'
         ELSE '인턴'
    END 부서명
FROM
    emp
;

/*
    사원들의
        사원이름, 직급, 부서번호, 보너스
    를 조회하세요.
    보너스는 부서별로
        10 - 급여의 10%
        20 - 급여의 15%
        30 - 급여의 20%
        그 이외는 0 으로
    지급 하기로 한다.
*/

SELECT
    ename 사원이름, job 직급, deptno 부서번호,
    DECODE(deptno, 10, sal * 1.1,
                    20, sal * 1.15,
                    30, sal * 1.2,
                    0
    ) 보너스,
    CASE deptno WHEN 10 THEN sal * 1.1
                WHEN 20 THEN sal * 1.15
                WHEN 30 THEN sal * 1.2
                ELSE 0
    END 비자금,
    CASE WHEN  THEN
        
    END 꽁돈
FROM
    emp
;









