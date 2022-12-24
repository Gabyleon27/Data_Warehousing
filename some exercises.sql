use ap
SELECT 
	vendors.*
	, invoices.* 
FROM 
	vendors INNER JOIN invoices ON vendors.vendor_id = invoices.vendor_id


SELECT 
	v.vendor_name, i.invoice_number, i.invoice_date, invoice_total - payment_total + credit_total as [balance_due]
FROM 
	vendors v INNER JOIN invoices i ON v.vendor_id = i.vendor_id
WHERE
	invoice_total - payment_total + credit_total != 0
ORDER BY
	v.vendor_name ASC

SELECT 
	v.vendor_name, v.default_account_number as [default_account], gla.account_description as [description]
FROM 
	vendors v INNER JOIN general_ledger_accounts gla ON v.default_account_number = gla.account_number
GROUP BY
	v.vendor_name, v.default_account_number, gla.account_description
ORDER BY
	gla.account_description, v.vendor_name

SELECT 
	v.vendor_name, i.invoice_date, i.invoice_number, ili.invoice_sequence as [li_sequence], ili.line_item_amount as [li_amount]
FROM 
	vendors v INNER JOIN invoices i ON v.vendor_id = i.vendor_id INNER JOIN invoice_line_items ili ON i.invoice_id = ili.invoice_id
ORDER BY
	v.vendor_name, i.invoice_date, i.invoice_number, ili.invoice_sequence

SELECT vendor_name, 'CA' as [vendor_state]
FROM vendors
WHERE vendor_state in ('CA')
UNION
SELECT vendor_name, 'Outside CA' as [vendor_state]
FROM vendors
WHERE vendor_state not in ('CA')
ORDER BY vendor_name

Select 'After 2014-06-01' as [Date]	,count(*) as [Count of Invoices]	,min(invoice_total) as [Lowest Total]	,max(invoice_total) as [Highest Total]	,round(avg(invoice_total), 2) as [Average Invoice]	,sum(invoice_total) as [Total]from invoiceswhere invoice_date >= '2014-06-01'use masterSELECT 	'Movie' as [Type] , first_name	, last_name	, m.title 	as [title or make], m.genre as [genre or model]FROM 	people p	left JOIN 	favorite_movies fm on p.person_id = fm.person_id	left JOIN movies m on fm.movie_id = m.movie_idWHERE fm.movie_id is not nullunionSELECT 'Cars', p.first_name,p.last_name,v.make,v.modelfrom people as pinner join vehicle_owners as vo on vo.person_id = p.person_idinner join vehicles as v on v.vehicle_id = vo.vehicle_idorder by last_name, first_name