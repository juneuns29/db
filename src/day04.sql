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
        
        ROUND()
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


