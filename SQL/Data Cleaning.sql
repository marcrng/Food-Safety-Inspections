# Update unlabeled city for Walla Walla Farms Cafe @ T-Mobile Newport 2
UPDATE inspection_data

set city = 'BELLEVUE'
where city = '(none)'
and `Zip Code` = 98006;