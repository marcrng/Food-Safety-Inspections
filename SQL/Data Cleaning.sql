# TODO: Geocode missing lon/lat using python - geopy

# Update unlabeled city for Walla Walla Farms Cafe @ T-Mobile Newport 2
update inspection_data

set city = 'BELLEVUE'
where city = '(none)'
and `Zip Code` = 98006;

# Remove restaurants that aren't in King County, but show up in dataset.
# These data points result in inaccurate results for certain cities due to incomplete data.
delete from inspection_data
where city in ('Baring', 'Buckley', 'Everett', 'Fall city', 'Lynnwood', 'Mount Vernon',
               'Mukilteo', 'Puyallup', 'SNOHOMISH', 'TACOMA', 'HOBART');

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

# Fix -12.2 longitude for MOD PIZZA - AUBURN NORTH
update inspection_data
set Longitude = -122.22239
where Longitude = -12.222239;

# # Create proper 'Inspection Date' column with 'date' datatype
# alter table inspection_data
# add inspection_date date;
#
# # Populate inspection_date column with data from 'Inspection Date'
# update inspection_data
# set inspection_date = str_to_date(`Inspection Date`, '%m/%d/%Y');

# Would generally execute the above 2 commented queries to preserve original 'Inspection Date' data, but electing
# to directly update `Inspection Date` column for this project since we're using a personal database
update inspection_data
set `Inspection Date` = str_to_date(`Inspection Date`, '%m/%d/%Y');