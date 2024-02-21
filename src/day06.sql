-- day06

/*
    WHERE ���� ���Ǵ� ��������
        1. ���������� ����� ������ �����÷����� ��ȸ�Ǵ� ���
        ==> �Ϲ� ������ �Է��ϴ� �������� ����ϸ� �ȴ�.
            
            �� ]
                'SMITH' ����� ���� �μ��� ����� ����̸�, ����, �μ���ȣ�� ��ȸ�ϼ���.
                
                SELECT
                    ename ����̸�, job ����, deptno �μ���ȣ
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
                
        2. ���������� ����� ������ �����÷����� ��ȸ�Ǵ� ���
        ==> �����Ͱ� ������ ��ȸ�Ǵ� ����̹Ƿ�
            ���߰� �񱳿����ڷ� ó���ؾ� �Ѵ�.
            
            IN
            ==> �������� �������� �ϳ��� ������ �Ǵ� ���
                ����� �� �ִ� �����ڴ� ���� 
                ���������� ����񱳿����� �Ѵ�.
                
                ���� ]
                    �÷��̸� IN (��������)
                    
            ANY
            ==> �������� �������� �ϳ��� ������ �Ǵ� ���
                ����� �� �ִ� �����ڴ� ��� �񱳿����ڸ� ����� �� �ִ�.
                
                ���� ]
                    
                    �÷��̸� = ANY ( ������ �����÷� ��������)
                    �÷��̸� >= ANY ( ������ �����÷� �������� )
                                    
            ALL
            ==> �������� �����Ͱ� ��� ���ǿ� �¾ƾ� �Ǵ� ���
            
            ���� ]
                ����ó���� ũ��(>), �۴�(<)��� ���� �񱳵� �����ϴ�.
            
            
        3. ���������� ����� ������ �����÷����� ��ȸ�Ǵ� ���
            
            EXISTS
            ==> ���������� ����� �����ϸ� true �� ó����
                ������ false�� ó���Ǵ� ������
                ���� �÷��� ������� �ʴ´�.
        
*/

-- 10���μ� ������ ���� ������ ������� ����̸�, ������ ��ȸ�ϼ���.
SELECT
    ename ����̸�, job ����
FROM
    emp
WHERE
    job IN (
                SELECT
                    job
                FROM
                    emp
                WHERE
                    deptno = 10
            )
;

-- �μ��� ��ձ޿��� �� �μ��� �޿��� ���� ����� ����̸�, ����, �޿��� ��ȸ�ϼ���.

SELECT
    AVG(sal)
FROM
    emp
GROUP BY
    deptno
;

SELECT
    ename ����̸�, job ����, sal �޿�
FROM
    emp
WHERE
    sal > ANY (
                    SELECT
                        AVG(sal)
                    FROM
                        emp
                    GROUP BY
                        deptno
                )
ORDER BY
    ����̸�
;

-- ��� �μ��� ��ձ޿����� �޿��� ���� ����� ����̸�, ����, �޿��� ��ȸ�ϼ���.
SELECT
    ename ����̸�, job ����, sal �޿�
FROM
    emp
WHERE
    sal > ALL (
                    SELECT
                        AVG(sal)
                    FROM
                        emp
                    GROUP BY
                        deptno
                )
ORDER BY
    ����̸�
;

-- �̹��޿� Ŀ�̼��� ������ �����ε� 'smith' ����� �ٹ��ϰ� ������
-- ��� ����� Ŀ�̼��� 20% �λ��ؼ� �����ϰ� ������ �������� �ʴ´�.
-- ��, Ŀ�̼��� ���� ����� 200���� �ϰ� ����ϱ�� �Ѵ�.
SELECT
    ename ����̸�, sal �޿�, NVL2(comm, comm * 1.2, 200 * 1.2) ����Ŀ�̼�
FROM
    emp
WHERE
    EXISTS (
                SELECT
                    *
                FROM
                    emp
                WHERE
                    ename = 'smith'
            )
;

/*
    ������ 'MANAGER'�� ����麸�� �޿��� �� ���̶� �޿��� ��������� 
    ����̸�, ����, �޿��� ��ȸ�ϼ���.
*/

SELECT
    ename ����̸�, job ����, sal �޿�
FROM
    emp
WHERE
    sal > ANY (
                    SELECT
                        sal
                    FROM
                        emp
                    WHERE
                        job = 'MANAGER'
            )
;

/*
    ������ 'MANAGER'�� ��� ������� �޿����� �޿��� ��������� 
    ����̸�, ����, �޿��� ��ȸ�ϼ���.
*/

SELECT
    ename ����̸�, job ����, sal �޿�
FROM
    emp
WHERE
    sal > ALL  (
                    SELECT
                        sal
                    FROM
                        emp
                    WHERE
                        job = 'MANAGER'
                )
;
