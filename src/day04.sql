-- day04

/*
    ���ڿ� ó���Լ�
        
        REPLACE()
        ==> ���ڿ��� Ư�� �κ��� �ٸ� ���ڿ��� ��ü�ؼ� ��ȯ���ִ� �Լ�
            
            ���� ]
                REPLACE(������, ã�����ڿ�, ��ü���ڿ�)
        TRIM()
        ==> ���ڿ� �߿��� �� �Ǵ� �ڿ� �ִ� ������ ���ڸ� ��� �����ϴ� �Լ�
        
            ���� ]
                TRIM(�����ҹ��� FROM ������)
            
            ���� ]
                ���� ���ڰ� ��, �ڿ� ���ӵǾ� ������ ��� ���� �� �ִ�.
                
            ���� ]
                ���� ������ �� �ڿ� ���� ���ڰ� �� ��찡 �ִ�.
                �̷� ��츦 ����ؼ� �� �ڿ� �� ���鹮�ڸ� ������ ��������
                ���� ����Ѵ�.
                
            1) LTRIM()
            2) RTRIM()
                ���� ]
                    LTRIM(������, �����ҹ���)
                
        ASCII()
        ==> ���ڿ��� ù��°���ڿ� �ش��ϴ� ASCII �ڵ尪�� ��ȯ���ش�.
            
            ���� ]
                ASCII(������)
                
        CHR()
        ==> ASCII�ڵ带 �Է��ϸ� �ڵ忡 �ش��ϴ� ���ڸ� ��ȯ���ִ� �Լ�
            
            ���� ]
                CHR(�ڵ尪)
                
        TRANSLATE()
        ==> REPLACE()�� ���������� ���ڿ� �� ������ �κ��� 
            �ٸ� ���ڿ��� ��ü���ִ� �Լ�
            
            ������ ]
                REPLACE() �ٲܹ��ڿ��� ���°� ��Ȯ�ϰ� ��ġ�ؾ��ϰ�
                            ���ڿ� ��ü�� ��ü
                TRANSLATE() ���ڴ����� ó��
        
*/

-- REPLACE()
SELECT
    REPLACE('Hong Gil Dong', ' ', '/') ȫ�浿,
    REPLACE('Gho Gil Dong', 'D', 'DD') ��浿,
    REPLACE('Kim Gil Dong', 'O', 'OO') ��浿
FROM
    dual
;

-- TRIM()
SELECT
    TRIM(' ' FROM '             HONG GIL   DONG              ') ȫ�浿,
    REPLACE('HONG GIL   DONG', '  ', '')  ȫ�浿2
FROM
    dual
;

SELECT
    ASCII('HONG') �ƽ�Ű�ڵ�,
    CONCAT(ASCII('HONG'), '') �ƽ�Ű�ڵ�2,
    CHR(ASCII('HONG')) ����
FROM
    dual
;

-- TRANSLATE()
SELECT
    TRANSLATE('ABCDBACE', 'ABCD', '1234') ����
FROM
    dual
;

--------------------------------------------------------------------------------
/*
    ��¥ �Լ�
        ���� ]
            ����Ŭ���� ��¥ �����ʹ� 1970�� 1�� 1�� 0�� 0�� 0�ʸ� ��������
            ���������� ��¥ ������ �̿��ؼ� �����Ѵ�. 
            
            ���� ]
                ����.�ð�
        
        ***
        ���� ]
            SYSDATE
            ==> ������ ���Ǹ���� ����Ǵ� ������ ��¥/�ð��� ����ϰ� �ִ� ����
            
        ���� ]
            ��¥ - ��¥ ������� ����Ѵ�.
            ==> ��¥ �������� - ������ �Ѵ�.
            
        ���� ]
            ��¥ + ���� ������ ����Ѵ�.
            ==> ��¥������ ������ �����̹Ƿ�
                ��¥�� �̿��ؼ� �����Ѵ�.
                ���� ��¥���� ���ڸ�ŭ �̵��� ��¥�� ��ȸ�ϰ� �ȴ�.
                
                
    �Լ��� ]
        
        ADD_MONTHS()
        ==> ���� ��¥�� ������ �������� ���ϰų� �� ��¥�� ��ȯ���ش�.
        
            ���� ]
                ADD_MONTHS(��¥������, ������)
                
            ���� ]
                �������� ������ �ش� ���� ���� �� ��¥�� ��ȯ
                
                
        MONTHS_BETWEEN()
        ==> �� ��¥ ������ ������ �������� �˷��ִ� �Լ�
        
            ���� ]
                MONTHS_BETWEEN(��¥, ��¥)
                
        LAST_DAY()
        ==> �Է��� ��¥�� ���Ե� ���� ������ ��¥�����͸� ��ȯ
        
        NEXT_DAY()
        
        ROUND()
*/

-- ���� �ð� ��ȸ
SELECT
    TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS') ����ð�
FROM
    dual
;

-- ������� ����̸�, �Ի���, �ٹ��� ���� ��ȸ�ϼ���.
SELECT
    ename ����̸�, hiredate �Ի���, FLOOR(SYSDATE - hiredate) "�ٹ��� ��"
FROM
    emp
;

SELECT
    SYSDATE + 11 "11�� ��"
FROM
    dual
;

-- ���ú��� 5���� �� ��¥�� ��ȸ�ϼ���.
SELECT
    ADD_MONTHS(SYSDATE, 5) "5���� ��"
FROM
    dual
;

-- ������� ����̸�, �Ի���, �ٹ� �������� ��ȸ�ϼ���.
SELECT
    ename ����̸�, hiredate �Ի���,
    FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) "�ٹ� ���� ��1",
    ABS(FLOOR(MONTHS_BETWEEN(hiredate, SYSDATE))) "�ٹ� ���� ��2",
    FLOOR(SYSDATE - HIREDATE) / 30 
FROM
    emp
;

-- �̹��� ������ ��
SELECT
    LAST_DAY(SYSDATE + 11)
FROM
    dual
;

-- ������� �Ի���� �ٹ� �� ���� ��ȸ�ϼ���.
SELECT
    ename ����̸�, hiredate �Ի���,
    (LAST_DAY(hiredate) + 1) - hiredate "�Ի�� �ٹ��� ��"
FROM
    emp
;


