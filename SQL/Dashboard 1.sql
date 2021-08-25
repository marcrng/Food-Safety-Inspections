# Create a fail ratio for each city found by total # of 'Unsatisfactory' inspections / All inspections
create view fail_ratio_city as
with unsatisfactory_count as
         (
             select City,
                    count(Name) as fails
             from inspection_data
             where `Inspection Result` = 'Unsatisfactory'
             group by City
         )
select i.City,
       fails / count(*) as fail_ratio
from inspection_data i
join unsatisfactory_count u on i.City = U.City
group by I.City
order BY fail_ratio desc;

# Create a fail ratio for each zip found by total # of 'Unsatisfactory' inspections / All inspections
# NOTE: Algona zip 98001 has a ratio of 0.3631, while city of Algona returns a 0.6323. Large discrepancy--
create view fail_ratio_zip as
with unsatisfactory_count as
         (
             select `Zip Code`,
                    count(Name) as fails
             from inspection_data
             where `Inspection Result` = 'Unsatisfactory'
             group by `Zip Code`
         )
select i.`Zip Code`,
       fails / count(*) as fail_ratio
from inspection_data i
join unsatisfactory_count u on i.`Zip Code` = U.`Zip Code`
group by I.`Zip Code`
order BY fail_ratio desc;
