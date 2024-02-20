-- day05

/*
    그룹함수
    ==> 여러행의 데이터를 하나로 만들어서 연산하고 결과를 알려주는 함수
        
        ***
        참고 ]
            그룹 함수는 결과가 오직 한개만 나오게 된다.
            따라서 그룹함수는 결과가 여러개 나오는 경우와
            혼용해서 사용할 수 없다.
            오직 여러행의 결과가 한행으로만 나오는 것과만 사용할 수 있다.
            
            예 ]
                SELECT ename FROM emp; ==> 결과가 14개의 행이 발생한다.
                SELECT SUM(sal) FROM emp; 
                ==> SUM(sal) : 사원들의 급여의 합계를 계산해서 반환해주는 함수
                    따라서 사원들의 합계는 여러행의 값들이 단일값으로 계산되어서 만들어질 것이다.
                    
                따라서
                    SELECT sal, SUM(sal) FROM emp;
                는 사용할 수 없다.
                
            예 ]
                SELECT
                    ename, SUM(sal)
                FROM
                    emp
                ;
                이 질의명령 역시 불가능하다.
                
                
        1. SUM()
            ==> 데이터의 합계를 구하는 함수
                
                형식 ]
                    SUM(컬럼이름)
        
        2. AVG()
            ==> 데이터의 평균을 구하는 함수
                
                형식 ]
                    AVG(컬럼이름)
        
        3. COUNT()
        
        4. MAX() / MIN()
        
        5. STDDEV()
        
        6. VARIANCE() 
*/

-- SELECT ename, SUM(10) FROM emp; -- 안된다.

/*
    사원들의 총급여합계를 조회하세요.
*/
SELECT
    SUM(sal)
FROM
    emp
;

-- 사원들의 평균급여를 조회하세요.
SELECT
    TRUNC(AVG(sal), 2) 평균급여
FROM
    emp
;




















