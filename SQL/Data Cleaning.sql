# TODO: Geocode missing lon/lat using python - geopy
# TODO: Split data (violation id, description, points)

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

# Normalize `Violation Description` data
select distinct `Violation Description` from inspection_data;

update inspection_data
set `Violation Description` = '0100 - PIC certified by accredited program or compliance with code, or correct answers'
where `Violation Description` like '0100%'
or `Violation Description` like 'PIC certified%';

update inspection_data
set `Violation Description` = '0200 - Food Worker Cards current for all food workers; new food workers trained'
where `Violation Description` like '0200%'
or `Violation Description` like '%Food worker cards%';

update inspection_data
set `Violation Description` = '0300 - Proper ill worker and conditional employee practices; no ill practices workers
present; proper reporting of illness'
where `Violation Description` like '0300%'
or `Violation Description` like 'Proper ill worker%';

update inspection_data
set `Violation Description` = '0400 - Hands washed as required'
where `Violation Description` like '0400%'
or `Violation Description` like 'Hands washed as%';

update inspection_data
set `Violation Description` = '0500 - Proper barriers used to prevent bare hand contact with ready to eat foods.'
where `Violation Description` like '0500%'
or `Violation Description` like '%bare hand%';

update inspection_data
set `Violation Description` = '0600 - Adequate handwashing facilities'
where `Violation Description` like '0600%'
or `Violation Description` like '%handwashing facilities%';

update inspection_data
set `Violation Description` = '0700 - Food obtained from approved source'
where `Violation Description` like '0700%'
or `Violation Description` like 'Food obtained from%';

update inspection_data
set `Violation Description` = '0800 - Water supply, ice from approved source'
where `Violation Description` like '0800%'
or `Violation Description` like '%water supply, ice%';

update inspection_data
set `Violation Description` = '0900 - Proper washing of fruits and vegetables'
where `Violation Description` like '0900%'
or `Violation Description` like '%fruits and vegetable%';

update inspection_data
set `Violation Description` = '1000 - Food in good condition, safe and unadulterated; approved additives'
where `Violation Description` like '1000%'
or `Violation Description` like 'Food in good condition%';

update inspection_data
set `Violation Description` = '1100 - Proper disposition of returned, previously served, unsafe, or contaminated food'
where `Violation Description` like '1100%'
or `Violation Description` like 'Proper disposition of returned%';

update inspection_data
set `Violation Description` = '1200 - Proper shellstock ID; wild mushroom ID; parasite destruction procedures for fish'
where `Violation Description` like '1200%'
or `Violation Description` like 'Proper shellstock ID%'
or `Violation Description` like 'Proper shellfish identi%';

update inspection_data
set `Violation Description` = '1300 - Food contact surfaces and utensils used for raw meat thoroughly cleaned and
 sanitized. No cross contamination'
where `Violation Description` like '1300%'
or `Violation Description` like 'Food contact surfaces%'
or `Violation Description` like 'Food-contact surfaces%';

update inspection_data
set `Violation Description` = '1400 - Raw meats below and away from ready to eat food; species separated'
where `Violation Description` like '1400%'
or `Violation Description` like 'Raw meats below and away from%';

update inspection_data
set `Violation Description` = '1500 - -Proper handling of pooled eggs'
where `Violation Description` like '1500%'
or `Violation Description` like '%pooled eggs%';

update inspection_data
set `Violation Description` = '1600 - Proper cooling procedures'
where `Violation Description` like '1600%'
or `Violation Description` like '%cooling procedure%';

update inspection_data
set `Violation Description` = '1710 - Proper hot holding temperatures (less than 130 degrees F)'
where `Violation Description` like '1710%'
or `Violation Description` like '%less than 130%';

update inspection_data
set `Violation Description` = '1720 - Proper hot holding temperatures (between 130 degrees F to 134 degrees F)'
where `Violation Description` like '1720%'
or `Violation Description` like '%between 130%';

update inspection_data
set `Violation Description` = '1800 - Proper cooking time and temperature; proper use of non-continuous cooking'
where `Violation Description` like '1800%'
or `Violation Description` like 'Proper cooking time%';

update inspection_data
set `Violation Description` = '1900 - No room temperature storage; proper use of time as a control'
where `Violation Description` like '1900%'
or `Violation Description` like 'No room temperature storage%';

update inspection_data
set `Violation Description` = '2000 - Proper reheating procedures for hot holding'
where `Violation Description` like '2000%'
or `Violation Description` like 'Proper reheating procedures%';

update inspection_data
set `Violation Description` = '2110 - Proper cold holding temperatures (greater than 45 degrees F)'
where `Violation Description` like '2110%'
or `Violation Description` like '%greater than 45%';

update inspection_data
set `Violation Description` = '2120 - Proper cold holding temperatures (between 42 degrees F to 45 degrees F)'
where `Violation Description` like '2120%'
or `Violation Description` like '%42 degrees f to 45%';

update inspection_data
set `Violation Description` = '2200 - Accurate thermometer provided and used to evaluate temperature
of PHF'
where `Violation Description` like '2200%'
or `Violation Description` like 'Accurate thermometer %';

update inspection_data
set `Violation Description` = '2300 - Proper Consumer Advisory posted for raw or undercooked foods'
where `Violation Description` like '2300%'
or `Violation Description` like 'Proper Consumer advisory%';

update inspection_data
set `Violation Description` = '2400 - Pasteurized foods used as required; prohibited foods not offered'
where `Violation Description` like '2400%'
or `Violation Description` like 'Pasteurized foods used%';

update inspection_data
set `Violation Description` = '2500 - Toxic substances properly identified, stored, used'
where `Violation Description` like '2500%'
or `Violation Description` like 'Toxic substances properly%';

update inspection_data
set `Violation Description` = '2600 - Compliance with risk control plans, variances, plan of operation; valid permit;
approved procedures for non-continuous cooking'
where `Violation Description` like '2600%'
or `Violation Description` like '%Compliance with risk%';

update inspection_data
set `Violation Description` = '2700 - Variance obtained for specialized processing methods
(e.g., ROP)'
where `Violation Description` like '2700%'
or `Violation Description` like 'Variance obtained for%';

update inspection_data
set `Violation Description` = '2800 - Food received at proper temperature'
where `Violation Description` like '2800%'
or `Violation Description` like '%food received at%';

update inspection_data
set `Violation Description` = '2900 - Adequate equipment for temperature control'
where `Violation Description` like '2900%'
or `Violation Description` like '%equipment for temp%';

update inspection_data
set `Violation Description` = '3000 - Proper thawing methods used'
where `Violation Description` like '3000%'
or `Violation Description` like 'Proper thawing methods%';

update inspection_data
set `Violation Description` = '3100 - Proper labeling, signage'
where `Violation Description` like '3100%'
or `Violation Description` like '%proper labeling%';

update inspection_data
set `Violation Description` = '3200 - Insects, rodents, animals not present; entrance controlled'
where `Violation Description` like '3200%'
or `Violation Description` like 'Insects, rodents, animals%';

update inspection_data
set `Violation Description` = '3300 - Potential food contamination prevented during delivery,  preparation, storage, display'
where `Violation Description` like '3300%'
or `Violation Description` like 'Potential food contamination%';

update inspection_data
set `Violation Description` = '3400 - Wiping cloths properly used, stored; proper sanitizer'
where `Violation Description` like '3400%'
or `Violation Description` like 'Wiping cloths properly%';

update inspection_data
set `Violation Description` = '3500 - Employee cleanliness and hygiene'
where `Violation Description` like '3500%'
or `Violation Description` like '%Employee cleanliness and%';

update inspection_data
set `Violation Description` = '3600 - Proper eating, tasting, drinking, or tobacco use'
where `Violation Description` like '3600%'
or `Violation Description` like 'Proper eating, tasting%';

update inspection_data
set `Violation Description` = '3700 - In-use utensils properly stored'
where `Violation Description` like '3500%'
or `Violation Description` like '%In-use utensils%';

update inspection_data
set `Violation Description` = '3800 - Utensils, equipment, linens properly stored, used, handled'
where `Violation Description` like '3800%'
or `Violation Description` like 'Utensils, equipment, linens%';

update inspection_data
set `Violation Description` = '3900 - Single-use and single-service articles properly stored, used'
where `Violation Description` like '3900%'
or `Violation Description` like 'Single-use and single-service articles%'
or `Violation Description` like 'single use and single service articles%';

update inspection_data
set `Violation Description` = '4000 - Food and non-food surfaces properly used and constructed; cleanable'
where `Violation Description` like '4000%'
or `Violation Description` like 'Food and non-food surfaces%';

update inspection_data
set `Violation Description` = '4100 - Warewashing facilities properly installed, maintained, used; test strips
available and used'
where `Violation Description` like '4100%'
or `Violation Description` like 'Warewashing%';

update inspection_data
set `Violation Description` = '4400 - Plumbing properly sized, installed, and maintained; proper backflow devices,
indirect drains, no cross-connections'
where `Violation Description` like '4400%'
or `Violation Description` like 'Plumbing properly sized%';

update inspection_data
set `Violation Description` = '4500 - Sewage, wastewater properly disposed'
where `Violation Description` like '4500%'
or `Violation Description` like '%sewage, waste water%';

update inspection_data
set `Violation Description` = '4600 - Toilet facilities properly constructed, supplied, cleaned'
where `Violation Description` like '4600%'
or `Violation Description` like 'Toilet facilities properly%';

update inspection_data
set `Violation Description` = '4700 - Garbage, refuse properly disposed; facilities maintained'
where `Violation Description` like '4700%'
or `Violation Description` like 'Garbage, refuse%';

update inspection_data
set `Violation Description` = '4800 - Physical facilities properly installed, maintained, cleaned; unnecessary
persons excluded from establishment'
where `Violation Description` like '4800%'
or `Violation Description` like 'Physical facilities properly installed%';

update inspection_data
set `Violation Description` = '4900 - Adequate ventilation, lighting; designated areas used'
where `Violation Description` like '4900%'
or `Violation Description` like '%Adequate ventilation%';

update inspection_data
set `Violation Description` = '5000 - Posting of permit; mobile establishment name easily visible'
where `Violation Description` like '5000%'
or `Violation Description` like 'Posting of permit%';

# ---------------------------------------------------------------------------------------------------------------------

# Create id column for violation description, consider splitting data into multiple tables
alter table inspection_data
add violation_id smallint;

update inspection_data
set violation_id = left(`Violation Description`, 4);