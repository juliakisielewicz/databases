--1
DO $$
DECLARE
  rate_mean numeric;
  i record;
BEGIN
SELECT ROUND(AVG(rate), 2) INTO rate_mean FROM humanresources.employeepayhistory;
raise notice 'Rate mean is %', rate_mean;

FOR i IN SELECT *  FROM humanresources.employee
             WHERE businessentityid IN (SELECT businessentityid FROM humanresources.employeepayhistory WHERE rate < rate_mean)
    LOOP
        RAISE NOTICE 'businessentityid: %; nationalidnumber: %; loginid: %, jobtitle: %', i.businessentityid, i.nationalidnumber, i.loginid, i.jobtitle;
    END LOOP;
END$$;

--2

CREATE OR REPLACE FUNCTION get_shipdate(p_order INT) 
RETURNS timestamp without time zone 
LANGUAGE SQL
AS $$
SELECT shipdate FROM sales.salesorderheader WHERE salesorderid = p_order;
$$;

SELECT * FROM get_shipdate(43757);

--3
CREATE OR REPLACE PROCEDURE display_product(p_name VARCHAR(50))
LANGUAGE plpgsql
AS $$
DECLARE p_product record;
BEGIN
SELECT product.productid, "name", productnumber, SUM(quantity) as availability INTO p_product
FROM production.product JOIN production.productinventory 
ON product.productid = productinventory.productid
GROUP BY product.productid, "name", productnumber HAVING "name" = p_name;

RAISE NOTICE 'name: %; id: %; number: %; availability: %', 
p_product.name, p_product.productid, p_product.productnumber, p_product.availability;
END$$; 

CALL display_product('Blade');


--4
CREATE OR REPLACE FUNCTION get_credit(p_order INT) 
RETURNS VARCHAR(25)
LANGUAGE SQL
AS $$
SELECT cardnumber FROM sales.salesorderheader JOIN sales.creditcard 
ON salesorderheader.creditcardid = creditcard.creditcardid
WHERE  salesorderid = p_order;
$$;

SELECT * FROM get_credit(43757);

--5
CREATE OR REPLACE PROCEDURE division(num1 numeric, num2 numeric)
LANGUAGE plpgsql
AS $$
DECLARE res numeric;
BEGIN
IF num1 < num2 THEN
RAISE EXCEPTION 'Niewłaściwie zdefiniowałeś dane wejściowe';
ELSE
	res := ROUND(num1/num2, 3);
RAISE NOTICE 'result: %', res;
END IF;
EXCEPTION
	WHEN division_by_zero THEN
		RAISE EXCEPTION 'Nie można dzielić przez zero';
END$$; 

CALL division(34.5,6.0);
CALL division(2.5,6.0);
CALL division(5.5,0.0);

--6
CREATE OR REPLACE PROCEDURE display_employee(natid VARCHAR(15))
LANGUAGE plpgsql
AS $$
DECLARE p_emp record;
BEGIN
SELECT jobtitle, vacationhours/8 as vacationdays, sickleavehours/8 as sickleavedays INTO p_emp 
FROM humanresources.employee WHERE nationalidnumber = natid;

RAISE NOTICE 'jobtitle: %; vacationdays: %; sickleavedays: %', 
p_emp.jobtitle, p_emp.vacationdays, p_emp.sickleavedays;
END$$; 

CALL display_employee('295847284');


--7
CREATE OR REPLACE PROCEDURE currency_calc(_amount NUMERIC, _from VARCHAR(50), _to VARCHAR(50), _date TIMESTAMP WITHOUT TIME ZONE)
LANGUAGE plpgsql
AS $$
DECLARE _result NUMERIC;
BEGIN
IF _from = 'US Dollar' THEN
	SELECT _amount*averagerate INTO _result
	FROM sales.currency JOIN sales.currencyrate ON currencycode = tocurrencycode
	WHERE currencyratedate = _date AND "name" = _to;
ELSE
	SELECT _amount/averagerate INTO _result
	FROM sales.currency JOIN sales.currencyrate ON currencycode = tocurrencycode
	WHERE currencyratedate = _date AND "name" = _from;
END IF;
RAISE NOTICE '%', ROUND(_result, 2);
END$$; 

CALL currency_calc(100, 'US Dollar', 'EURO', timestamp '2011-05-31 00:00:00');
CALL currency_calc(100, 'EURO', 'US Dollar', timestamp '2011-05-31 00:00:00');

