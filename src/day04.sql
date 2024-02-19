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
    REPLACE('Gho Gil Dong', 'D', 'DD') ���浿,
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
            ==> ������ ���Ǹ����� ����Ǵ� ������ ��¥/�ð��� ����ϰ� �ִ� ����
            
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
        ==> ������ �� ���� ó�� ���� ���� ������ ��¥�����͸� ��ȯ
            
            ���� ]
                NEXT_DAY(��¥, '����')
                
        NLS ���� :
                    RRRR/MM/DD HH24:MI:SS
                
            ���� ]
                ���� �����ϴ� ���
                    1. �츮�� ��� �ѱ� ������ �� ����Ŭ �̹Ƿ�
                        '��', 'ȭ',...
                        '������', 'ȭ����', ...
                    2. �������� ���
                        'MON', ...
                        'MONDAY', ...
        
        ROUND()
        ==> ��¥�� ������ �������� �ݿø����ִ� �Լ�
            
            ������ ����]
                ��, ��, ��, �ð�, ��, ��
                
            ���� ]
                ROUND(��¥, '����')
                
    ----------------------------------------------------------------------------
    
    ����ȯ �Լ�
    ==> ����Ŭ���� �Լ��� �������� ���¿� ���� ����� �� �ִ� �Լ��� �޶�����.
        ���� ����Ϸ��� �Լ��� �ʿ��� �����Ͱ� �ƴѰ�쿡�� ������ ���� �� �ִ�.
        �̷� �� ����ϴ� �Լ��� ����ȯ�Լ��̴�.
        ==> �������� ���¸� �ٲ㼭 Ư�� �Լ��� ��밡���ϵ��� ������ִ� �Լ�
        
    ���� ]
                
                    TO_CHAR()       TO_CHAR()
                    ------->        <------
            ����              ����          ��¥
                    <--------       ------->
                    TO_NUMBER()     TO_DATE()
                    
                    <---------------------->
                                X
                                
        1. TO_CHAR()
            ==> ��¥�� ���ڸ� ���� �����ͷ� ��ȯ���ִ� �Լ�
                
                ���� 1 ]
                    TO_CHAR(��¥ �Ǵ� ����)
                    
                    '2024/02/19' �� ��� ���������� ����ϴ� ��¥ �����̹Ƿ�
                    ������ ���������� �ʾƵ� ����ȯ�� ���ش�.
                    
                    2024.02.19
                    2024-02-19
                    
                ���� 2 ]
                    TO_CHAR(��¥ �Ǵ� ����, '���Ĺ���')
                    ==> ��ȯ�� �� ���ϴ� ������ ���ڷ� ��ȯ���ִ� ���
                
                        �� ]
                            ���� �ð��� '��/��/���ڸ��⵵' �� ������ ���ڿ��� ..
                            
                            SELECT
                                TO_CHAR(SYSDATE, 'MM/DD/YY') ����ð�
                            FROM
                                dual
                            ;
                            
                            SELECT
                                TO_CHAR(1000, '9,999,999,999.99L') ����1,  ==> ��ȿ���� ǥ�þ���
                                TO_CHAR(1000, '0,000,000,000.00') ����2   ==> ��ȿ���� ǥ��
                            FROM
                                dual
                            ;
                            ==> $ �� ���� �� �ִ�.
                                �ش� ������ ����ȭ���� ��� 'L' �� �ٿ��� ǥ��
                            
        2. TO_DATE()
            ==> ��¥������ ���ڵ����͸� ��¥�����ͷ� ��ȯ
                
                ���� 1 ]
                    TO_DATE(��¥���� ���ڿ�)
                    ==> ���������� ���Ǵ� ��¥ ������ ������ �������� �ʾƵ� ����ȯ���ش�.
                        �� ]
                            1900/01/01
                            1900-01-01
                            1900.01.01
                            
                ���� 2 ]
                    TO_DATE(��¥���� ���ڿ�, '��¥����')
                    ==> ������ �Ϲ������� ���� ��� ��¥ ������ �����ؼ� ��¥�����ͷ� ��ȯ
                    
                    ���Ĺ��� ]
                        YYYY    - 4�ڸ� �⵵
                        YY      - ���ڸ� �⵵
                        MM      - ���ڸ� ��
                        DD      - ���ڸ� ��
                        DAY     - ����
                        DY      - ���� ����
                        
        3. TO_NUMBER()
            ==>  ���������� ���ڿ��� ���ڷ� ��ȯ
                
                ���� ]
                    TO_NUMBER(���ڿ�, '��������')
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

-- ���� ���� ó������ �ұ��� ��¥�� ��ȸ�ϼ���.
SELECT
    NEXT_DAY(SYSDATE, '��') "���� �ݿ���",
    NEXT_DAY(SYSDATE, '������') "���� ������"
FROM
    dual
;

-- ������ �⵵�� �������� �ݿø��� ��¥�� ��ȸ�ϼ���.
SELECT
    ROUND(SYSDATE, 'YEAR') "�ݿø��� �⵵"
FROM
    dual
;

-- 7�� 4���� �⵵�������� �ݿø��� ��¥�� ��ȸ�ϼ���.
SELECT
    ROUND(TO_DATE('2024/07/04', 'YYYY/MM/DD'), 'YEAR') "�ݿø� ��¥"
FROM
    dual
;

-- ���ó�¥�� �� ���� �ݿø��� ��¥...
SELECT
    ROUND(SYSDATE, 'MONTH'),
    ROUND(SYSDATE, 'DD'),
    TO_CHAR(ROUND(SYSDATE, 'HH'), 'YYYY/MM/DD HH24:MI:SS')
FROM
    dual
;


-- ����ð��� 'XXXX�� XX�� XX�� XX�� XX�� XX��'�� �������� ��ȸ�ϼ���.
SELECT
    TO_CHAR(SYSDATE,
        'YYYY"��" MM"��" DD"��" HH24"��" MI"��" SS"��"'
    ) ����ð�
FROM
    dual
;

SELECT
    TO_CHAR(1000, 'L9,999,999,999.99') ����1,
    TO_CHAR(1000, '0,000,000,000.00$') ����2
FROM
    dual
;

-- ������� ����̸�, �Ի���, �Ի������ ��ȸ�ϼ���.
SELECT
    ename ����̸�, hiredate �Ի���, TO_CHAR(hiredate, 'DAY') �Ի����
FROM
    emp
;

-- ���� ] �����, �Ͽ��Ͽ� �Ի��� �������
--          ����̸�, �Ի���, �޿�, Ŀ�̼�
--          �� ��ȸ�ϼ���. Ŀ�̼��� ���� Ŀ�̼ǿ� 200�� ���Ѱ����� ��ȸ�ϰ�
--          Ŀ�̼��� ������ 300���� 200�� ���� ������ ��ȸ�ϼ���.
SELECT
    ename ����̸�, hiredate �Ի���, sal �޿�,
    NVL(comm, 300) + 200 Ŀ�̼�
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'DAY') IN ('�����', '�Ͽ���')
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
    NULL ó���Լ�
        
        1.
            NVL(������ , NULL�϶� ��ü��)
            
        2.
            NVL2(�÷��̸�, �÷������, NULL�� �� ��ü��)
            
        3. NULLIF()
            
            ���� ]
                NULLIF(������1, ������2)
                
            �ǹ� ]
                [ ������1 ]�� [ ������2 ]�� ������ [ NULL ]�� ��ȯ�ϰ�
                �ٸ��� [������1] �� ��ȯ
        
        4. COALESCE()
            
            ���� ]
                COALESCE(������1, ������2, ..... )
                
            �ǹ� ]
                �������� ������ �� ���� ó�� ������ NULL �� �ƴ� �����͸� ��ȯ....
*/


/*
    �����, �Ͽ��Ͽ� �Ի��� �������
    ����̸�, �Ի���, �޿�, Ŀ�̼�
    �� ��ȸ�ϼ���. Ŀ�̼��� ���� Ŀ�̼ǿ� 200�� ���Ѱ����� ��ȸ�ϰ�
    Ŀ�̼��� ������ 300���� 200�� ���� ������ ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, hiredate �Ի���, sal �޿�,
    NVL2(comm, comm + 200, 500) Ŀ�̼�
FROM
    emp
WHERE
--    TO_CHAR(hiredate, 'DY') IN ('��', '��')
    SUBSTR(TO_CHAR(hiredate, 'DAY'), 1, 1) IN ('��', '��')
;

/*
    �������
        ����̸�, �Ի���, �޿�, Ŀ�̼�, ���޾�
    �� ��ȸ�ϼ���.
    
    ���޾��� Ŀ�̼����� �ϰ� Ŀ�̼��� ������ �޿��� �����ϰ� �޿��� ������ 0���� �����ϵ��� �Ѵ�.
*/
SELECT
    ename ����̸�, hiredate �Ի���, sal �޿�, comm Ŀ�̼�, COALESCE(comm, sal, 0) ���޾�
FROM
    emp
;



/*
    ����ó���Լ�
        
        ==> �Լ���� ���ٴ� ���ɿ� ����� ������
            �ڹ��� switch - case, if �� ����ϱ� ���ؼ� ����� ���� ��
            
        1. DECODE()
        ==> �ڹ��� SWITCH ���� �ش��ϴ� �Լ�
        
            ���� ]
                DECODE(�÷��̸�, ������1, ��ȯ��1,
                                ������2, ��ȯ��2,
                                ...
                                ��ȯ��N
                )
                ==> �÷��� ������ ������1�� ������ ��ȯ��1�� ��ȯ�ϰ�
                                ������2�� ������ ��ȯ��2�� ��ȯ�ϰ�
                                ...
                                �´°� ������ ��ȯ��N�� ��ȯ���ش�.
        
        2. CASE WHEN THEN
            
            ���� 1 ]
                
                CASE WHEN ���ǽ�1 THEN ó������1
                     WHEN ���ǽ�2 THEN ó������2
                     ....
                     ELSE ó������N
                END
                
            ���� 2 ] ==> DECODE()�� ���� �ǹ�
                
                CASE �÷��̸� WHEN ������1 THEN ó������1
                              WHEN ������2 THEN ó������2
                              ...
                              ELSE ó������N
                END
*/

/*
    ���� ]
        ������� 
            ����̸�, ����, �μ���ȣ, �μ��̸�
        �� ��ȸ�ϼ���.
        �μ��̸���
            10 - ������
            20 - �ѹ���
            30 - �����
            �� �ܴ̿� '����'
        ���� ��ȸ�ϱ�� �Ѵ�.
*/

SELECT
    ename ����̸�, job ����, deptno �μ���ȣ,
    DECODE(deptno, 10, '������',
                20, '�ѹ���',
                30, '�����',
                '����'
    ) �μ��̸�,
    CASE deptno WHEN 10 THEN '������'
                WHEN 20 THEN '�ѹ���'
                WHEN 30 THEN '�����'
                ELSE '����'
    END �μ���Ī,
    CASE WHEN deptno = 10 THEN '������'
         WHEN deptno = 20 THEN '�ѹ���'
         WHEN deptno = 30 THEN '�����'
         ELSE '����'
    END �μ���
FROM
    emp
;

/*
    �������
        ����̸�, ����, �μ���ȣ, ���ʽ�
    �� ��ȸ�ϼ���.
    ���ʽ��� �μ�����
        10 - �޿��� 10%
        20 - �޿��� 15%
        30 - �޿��� 20%
        �� �ܴ̿� 0 ����
    ���� �ϱ�� �Ѵ�.
*/

SELECT
    ename ����̸�, job ����, deptno �μ���ȣ,
    DECODE(deptno, 10, sal * 1.1,
                    20, sal * 1.15,
                    30, sal * 1.2,
                    0
    ) ���ʽ�,
    CASE deptno WHEN 10 THEN sal * 1.1
                WHEN 20 THEN sal * 1.15
                WHEN 30 THEN sal * 1.2
                ELSE 0
    END ���ڱ�,
    CASE WHEN  THEN
        
    END �ǵ�
FROM
    emp
;








