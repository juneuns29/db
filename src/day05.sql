-- day05

/*
    �׷��Լ�
    ==> �������� �����͸� �ϳ��� ���� �����ϰ� ����� �˷��ִ� �Լ�
        
        ***
        ���� ]
            �׷� �Լ��� ����� ���� �Ѱ��� ������ �ȴ�.
            ���� �׷��Լ��� ����� ������ ������ ����
            ȥ���ؼ� ����� �� ����.
            ���� �������� ����� �������θ� ������ �Ͱ��� ����� �� �ִ�.
            
            �� ]
                SELECT ename FROM emp; ==> ����� 14���� ���� �߻��Ѵ�.
                SELECT SUM(sal) FROM emp; 
                ==> SUM(sal) : ������� �޿��� �հ踦 ����ؼ� ��ȯ���ִ� �Լ�
                    ���� ������� �հ�� �������� ������ ���ϰ����� ���Ǿ ������� ���̴�.
                    
                ����
                    SELECT sal, SUM(sal) FROM emp;
                �� ����� �� ����.
                
            �� ]
                SELECT
                    ename, SUM(sal)
                FROM
                    emp
                ;
                �� ���Ǹ�� ���� �Ұ����ϴ�.
              
        ���� ]
            �׷��Լ������� ���� ����� �� �ִ�.
                
        1. SUM()
            ==> �������� �հ踦 ���ϴ� �Լ�
                
                ���� ]
                    SUM(�÷��̸�)
        
        2. AVG()
            ==> �������� ����� ���ϴ� �Լ�
                
                ���� ]
                    AVG(�÷��̸�)
                    
                ���� ]
                    NULL �������� ���� ����� ����ϴ� ���꿡�� ������ ���ܵȴ�.
        
        3. COUNT()
            ==> ������ �÷� �߿��� �����Ͱ� �����ϴ� �÷��� ���� �˷��ش�.
                
                ���� ]
                    �����Ϳ� '*'�� �Է��ϸ� ���� ���� ��ȸ�Ѵ�.
                    
        4. MAX() / MIN()
            ==> �ִ�/�ּҰ��� �˷��ִ� �Լ�
                
                ���� ]
                    MAX(�÷��̸�)
                    
        5. STDDEV()
        ==> ǥ������ ��ȯ���ִ� �Լ�
        
        6. VARIANCE() 
        ==> �л� ��ȯ���ִ� �Լ�
*/

-- SELECT ename, SUM(10) FROM emp; -- �ȵȴ�.

/*
    ������� �ѱ޿��հ踦 ��ȸ�ϼ���.
*/
SELECT
    SUM(sal)
FROM
    emp
;

-- ������� ��ձ޿��� ��ȸ�ϼ���.
SELECT
    TRUNC(AVG(sal), 2) ��ձ޿�
FROM
    emp
;

-- ������� �ѱ޿��� ��ձ޿��� ��ȸ�ϼ���.
SELECT
    SUM(sal) �ѱ޿�, 
    TRUNC(AVG(sal), 2) ��ձ޿�
FROM
    emp
;

-- ������� ���Ŀ�̼��� ��ȸ�ϼ���.
SELECT
    AVG(comm) ���Ŀ�̼� -- NULL �����ʹ� ��ձ��ϴ� ���꿡�� ���ܵǹǷ� �̷��� ��ȸ�ϸ� �ȵȴ�.
    -- ���⼭�� �ǹ̴� Ŀ�̼��� �޴� ������� ���Ŀ�̼��� �ȴ�.
FROM
    emp
;

SELECT COMM FROM EMP;

-- ������� Ŀ�̼��� �޴� ����� ���� ��ȸ�ϼ���.
SELECT
    COUNT(*)
FROM
    emp
WHERE
    comm IS NOT NULL
;

SELECT
    COUNT(comm) "Ŀ�̼ǹ޴� ��� ��"
FROM
    emp
;

-- ������� �ִ�޿��� �ּұ޿��� ��ȸ�ϼ���.
SELECT
    MAX(sal) �ִ�޿�, MIN(sal) �ּұ޿�
FROM
    emp
;

-- ���ڵ����͵� �ִ�/�ּҸ� ��ȸ�� �� �ִ�.
SELECT
    MAX(ename), MIN(ename)
FROM
    emp
;

/*
    ������� ����(job)�� ������ ��ȸ�ϼ���.
    
    ==> ������ �ߺ����� �����
        �׷����� ������ ��ȸ�Ѵ�.
*/

SELECT
    COUNT(DISTINCT job) "������ ����"
FROM
    emp
;

--------------------------------------------------------------------------------
/*
    GROUP BY ��
    ==>     �׷��Լ��� ������ �׷��� �����ϴ� ��
        
        �� ]
            �μ��� �޿��� �հ踦 ��ȸ�ϼ���.
            ���޺� �޿��� ����� ��ȸ�ϼ���.
            
        ���� ]
            SELECT
                �÷��̸�1, �÷��̸�2, �׷��Լ���...
            FROM
                ���̺��̸�
            [ WHERE
                ���ǽ� ]
            GROUP BY
                �÷��̸�1, �÷��̸�2, ...
            ;
            
        ���� ]
            �׷�ȭ ������ �Ǵ�(GROUP BY ���� �����) �÷���� �׷��Լ��� ���� ��ȸ�� �� �ִ�.
            
        ���� ]
            �������� �̿��ؼ� �׷��Լ���꿡 ����� �����͸� �� �� �ִ�.
            
        ���� ]
            �׷�ȭ ������ �÷� ��ü�� �ƴϾ �ȴ�.
            �÷��� �Ϻκ��� �̿��ص� �׷�ȭ�� �����ϴ�.
            
    ----------------------------------------------------------------------------
    HAVING ��
    ==> �׷�ȭ�� ��� ���� �׷� �߿��� ��ȸ�� ���Խ�ų �׷��� �����ϴ� ������
        �׷�ȭ�� ����� �ɷ����� ��...
        
        GROUP BY �� ���� �ܵ����� ����� �� ����.
        �ݵ�� GROUP BY ���� ���� ����ؾ� �Ѵ�.
        
        ���� ]
            SELECT
                �׷��Լ���...
            FROM
                ���̺��̸�
            [ WHERE
                ���ǽ� ]
            GROUP BY
                �׷�ȭ�����÷�
            [ HAVING
                ���ǽ� ] -- ���ǽ��� ������ ������ ��� ��������(AND, OR)�� ó�����ش�.
            [ ORDER BY
                �÷��̸� ASC �Ǵ� DESC, �÷��̸� ASC �Ǵ� DESC,...
            ;
*/

-- �μ��� �μ���ȣ, �ִ�޿�, �ּұ޿�, ��ձ޿�, �޿��հ�, ����� �� ��ȸ�ϼ���.
SELECT
    deptno �μ���ȣ, MAX(sal) �ִ�޿�, MIN(sal) �ּұ޿�, 
    TRUNC(AVG(sal), 2) ��ձ޿�, SUM(sal) �޿��հ�, COUNT(*) �����
FROM
    emp
GROUP BY
    deptno
;

-- ������� ù���ں��� �׷�ȭ�ؼ� ù����, �޿��� �հ踦 ��ȸ�ϼ���.
SELECT
    SUBSTR(ename, 1, 1) �̸�ù����, SUM(sal) �޿��հ�
FROM
    emp
GROUP BY
    SUBSTR(ename, 1, 1)
;

/*
    ���޺��� ������� ��ȸ�ϼ���.
*/

/*
    �μ��� �ּұ޿��� ��ȸ�ϼ���.
*/

/*
    �� ���޺� �޿��հ�� ��ձ޿��� ��ȸ�ϼ���.
*/

/*
    �Ի�⵵�� �Ի�⵵, ��ձ޿�, �޿��հ�, �Ի������ ��ȸ�ϼ���.
*/
SELECT
    TO_CHAR(hiredate, 'YYYY') �Ի�⵵, 
    AVG(SAL) �޿����, SUM(SAL) �޿��հ�, COUNT(*) �Ի����
FROM
    emp
GROUP BY
    TO_CHAR(hiredate, 'YYYY')
;
/*
    ������� �̸� ���ڼ��� 4, 5������ ������� ��ȸ�ϼ���.
    1. �׷�ȭ�����ʰ� ��ȸ�ϼ���.
    2. GROUP BY���� �̿��ؼ� ó���ϼ���.
*/
-- 1
SELECT
    COUNT(*) "��� ��"
FROM
    emp
WHERE
    LENGTH(ename) IN (4, 5)
;

-- HAVING

-- �μ����� ��� �޿��� ��ȸ�ϼ���.
-- ��, �μ���ձ޿��� 2000�̻��� �μ��� ��ȸ�ϼ���.
SELECT
    deptno �μ���ȣ, AVG(sal) �μ���ձ޿�
FROM
    emp
WHERE
    AVG(sal) >= 2000 -- �׷��Լ��� where���� ����� �� ����.
GROUP BY
    deptno
;

SELECT
    deptno �μ���ȣ, TRUNC(AVG(sal), 2) �μ���ձ޿�
FROM
    emp
GROUP BY
    deptno
HAVING
    AVG(sal) >= 2000
;

-- 30�� �μ� ������� ���޺� �޿������ ��ȸ�ϼ���.
SELECT
    job ����, TRUNC(AVG(sal), 2) �޿���� 
FROM
    emp
WHERE
    deptno = 30
GROUP BY
    job
;

-- ���޺��� ������� ��ȸ�ϼ���.
-- ��, ������� 1���� ������ ��ȸ���� �����ϼ���.
SELECT
    job ����, COUNT(*) �����
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(*) <> 1
;

/*
    81�⵵ �Ի��� ������� �޿��հ踦 ���޺��� ��ȸ�ϼ���.
    ��, ���޺� ��ձ޿��� 1000 �̸��� ������ ��ȸ���� �ʰ� �ϼ���.
*/

/*
    81�⵵ �Ի��� ������� �޿��հ踦 
    ������� �̸����̺��� �׷�ȭ�ϼ���.
    ��, �޿��հ谡 2000�̸��� �׷��� ��ȸ���� �����ϼ���.
    �޿��հ� ���� �������� �����ؼ� ��ȸ�ǰ� �ϼ���.
*/

/*
    ������� �̸� ���̰� 4, 5������ ������� �μ��� ������� ��ȸ�ϼ���.
    ��, ������� 0�� �μ��� ��ȸ���� �����ϼ���.
    �μ���ȣ ���� �������� �����ϼ���.
*/

--------------------------------------------------------------------------------
/*
    ���� ]
        DECODE �Լ��� �׷��Լ��� ����
        
    �μ����� �޿��� ����ϴµ�
    10�� �μ��� �����
    20�� �μ��� �޿��հ踦
    30�� �μ��� �ִ�޿��� 
    ��ȸ�ϼ���.
*/

SELECT
    deptno �μ���ȣ, 
    DECODE(deptno, 10, TRUNC(AVG(sal), 2),
                    20, SUM(sal),
                    30, MAX(sal)
    ) �μ����޿�
FROM
    emp
GROUP BY
    deptno
;



--------------------------------------------------------------------------------
/*
    ��������(Sub Query, ������)
    ==> ���Ǹ�� ���� �ٽ� ���Ǹ���� ���Ե� �� �ִµ�
        �� ���Ե� ���Ǹ���� �������Ƕ� �Ѵ�.
        
        ���� ]
            �������Ǵ� ����������� ��밡���ѵ�..
            
            SELECT ���� ���Ե� �������Ǵ� �ݵ�� ������ �����÷����� ����� ��������� �Ѵ�.
    
*/

-- 'SMITH' ����� ���� �μ� ������� ����̸�, �μ���ȣ, ������ ��ȸ�ϼ���.
SELECT
    ename ����̸�, deptno �μ���ȣ, job ����
FROM
    emp
WHERE
    deptno = 20
;

SELECT
    deptno
FROM
    emp
WHERE
    ename = 'SMITH'
;

SELECT
    ename ����̸�, deptno �μ���ȣ, job ����
FROM
    emp
WHERE
    deptno = (
                SELECT
                    distinct deptno
                FROM
                    emp
--                WHERE
--                    ename = 'SMITH'
             )
;

SELECT
    ename, job, (
        SELECT
            job
        FROM
            emp
        WHERE
            ename = 'MILLER'
    ) ����
FROM
    emp
WHERE
    ename = 'KING'
;

-- SELECT ���� ���Ե� ��������
-- �ݵ�� ������ �����÷����� ��ȸ�Ǿ�� �Ѵ�.
-- 'SMITH'�� ����̸�, ����, �μ���ȣ, �ҼӺμ���ձ޿� �� ��ȸ�ϼ���.

SELECT
    ename ����̸�, job ����, deptno �μ���ȣ,
    (
        SELECT
            AVG(sal)
        FROM
            emp
        WHERE
            deptno = (
                        SELECT
                            deptno
                        FROM
                            emp
                        WHERE
                            ename = 'SMITH'
                      )
    ) �ҼӺμ���ձ޿�
FROM
    emp
WHERE
    ename = 'SMITH'
;

SELECT
    e.ename ����̸�, e.job ����, e.deptno �μ���ȣ,
    (
        SELECT
            AVG(sal)
        FROM
            emp
        GROUP BY
            deptno
        HAVING
            deptno = e.deptno
    ) �ҼӺμ���ձ޿�
FROM
    emp e
WHERE
    e.ename = 'SMITH'
;

-- SMITH ����� �μ���ձ޿�
SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = (
                SELECT
                    deptno
                FROM
                    emp
                WHERE
                    ename = 'SMITH'
              )
;


SELECT
    AVG(sal)
FROM
    emp
GROUP BY
    deptno
HAVING
    deptno = 20
;

SELECT
    AVG(sal)
FROM
    emp
GROUP BY
    deptno
HAVING
    deptno = deptno
;