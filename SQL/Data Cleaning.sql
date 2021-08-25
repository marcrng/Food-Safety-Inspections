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
# (Good example of why city IDs are a good idea)
update inspection_data
set City = 'SEATAC'
where city = 'SEA TAC';

# Remove data from SNOQUALMIE PASS, which isn't located in King County but wasn't removed at first pass
delete from inspection_data
where `Zip Code` = 98068;

# Normalize 'VASON ISLAND' to 'VASHON'
update inspection_data
set City = 'VASHON'
where city = 'VASHON ISLAND';

# Set all cities to uppercase to improve readability
update inspection_data
set City = upper(City);