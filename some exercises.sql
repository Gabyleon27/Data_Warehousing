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

Select 'After 2014-06-01' as [Date]