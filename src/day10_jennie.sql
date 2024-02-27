select tname from tab; -- 접속계정이 소유한 테이블 조회 명령

SELECT 'BLACK' || ' PINK' FROM DUAL;

-- tmp1 테이블 생성
CREATE TABLE tmp1(
    no NUMBER(2),
    name VARCHAR2(10 CHAR)
);

-- 데이터 추가
INSERT INTO
    tmp1
VALUES(
    1, '제니'
);

INSERT INTO
    tmp1
VALUES(
    2, '제니'
);

-- 2번 이름을 '리사'로 변경
UPDATE 
    tmp1
SET
    name = '리사'
WHERE
    no = 2
;

INSERT INTO
    tmp1
VALUES(
    3, '쵸파'
);

-- 쵸파 삭제
DELETE FROM tmp1 WHERE no = 3;

DROP TABLE tmp1;











