with unsatisfactory_count as
         (
             select City,
                    count(distinct Name) as fails
             from inspection_data
             where `Inspection Result` = 'Unsatisfactory'
             group by City
         )

select i.City,
       fails / count(distinct Name) as fail_ratio
from inspection_data i
join unsatisfactory_count u on i.City = U.City
group by I.City
order BY fail_ratio desc;

select distincT City
from inspection_data