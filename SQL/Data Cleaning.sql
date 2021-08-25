# Update unlabeled city for Walla Walla Farms Cafe @ T-Mobile Newport 2
update inspection_data

set city = 'BELLEVUE'
where city = '(none)'
and `Zip Code` = 98006;

# Remove restaurants that aren't in King County, but show up in dataset.
# These data points result in inaccurate results for certain cities due to incomplete data.
delete from inspection_data
where city in ('Baring', 'Buckley', 'Everett', 'Fall city', 'Lynnwood', 'Mount Vernon',
               'Mukilteo', 'Puyallup', 'SNOHOMISH', 'TACOMA');

# Update all 'SEA TAC' entries to 'SEATAC' to normalize data
update inspection_data
set City = 'SEATAC'
where city = 'SEA TAC';