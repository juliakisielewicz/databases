CREATE SCHEMA other;

CREATE TABLE other.fibo (numbers BIGINT);

--DROP FUNCTION fib(integer);
CREATE OR REPLACE FUNCTION fib(param_n INT) 
RETURNS SETOF BIGINT
LANGUAGE SQL
AS $$
WITH RECURSIVE numbers(n, num1,num2) AS (
    SELECT
		1::integer,
		0::bigint,
		1::bigint
    UNION ALL
    SELECT n+1, greatest(num1, num2), num1 + num2 from numbers
    WHERE n < param_n
   )
SELECT num1 FROM numbers;
$$;

--DROP PROCEDURE IF EXISTS display_fib(INT);
CREATE OR REPLACE PROCEDURE display_fib(param_n INT)
LANGUAGE SQL
AS $$
INSERT INTO other.fibo 
SELECT * FROM fib(param_n);
$$;

TRUNCATE TABLE other.fibo;
CALL display_fib(50);
SELECT * FROM other.fibo;