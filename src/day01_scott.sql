SELECT
    *
FROM
    emp
;
-- 오라클 단일행 주석
/*
   sqldeveloper 에서 사용하는 다중행 주석
   여러줄 주석처리....
*/

/*
    자바에서와 마찬가지로 
    모든 것을 의미하는 문자는 * 를 사용한다.
    
    -------------------------------------------------------------
    sql 에서는 명령어가 대소문자를 구분하지 않는다.
    하지만 데이터는 대소문자를 꼭 구분해줘야 한다.
    
    자바에서는 문자와 문자열을 구분했지만
    데이터베이스에서는 구분하지 않는다.
    표현은 '' 를 이용해서 표현한다.
    
    오라클에서도 자바와 마찬가지로
    명령의 구분은 토큰(;)으로 구분한다.
    
*/

SELECT 'abc' FROM DUAL;

SELECT 1 + 2 FROM DUAL;

-------------------------------------------------------------------
/*
    데이터 조회 명령
    
    형식 ]
        SELECT
            컬럼이름1, 컬럼이름2, ...
        FROM
            테이블이름
        [WHERE
         조건 ]
        [GROUP BY
            그룹기준
        [HAVING
        ]]
        [ORDER BY
        ]
        ;
*/

-- 사원들의 사원이름, 급여를 조회하세요.
SELECT
    ename, sal
FROM
    emp -- 사원정보테이블
;

/*
    조회하거나 데이터베이스 작업을 하는 명령(문장들)을
    쿼리문, 질의명령 라고 부른다.
*/

/*
    scott 계정이 소유하는 테이블들
        
        emp         : 사원정보테이블
            empno       : 사원번호
            ename       : 사원이름
            job         : 직급
            mgr         : 상사의 사원번호
            hiredate    : 입사일
            sal         : 급여
            comm        : 커미션
            deptno      : 부서번호
            
            
            
        dept        : 부서정보테이블
        salgrade    : 급여등급테이블
        bonus       : 보너스테이블
        
*/









