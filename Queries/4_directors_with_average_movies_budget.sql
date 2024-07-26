SELECT 
    p.id as "Director id", 
    CONCAT(p.first_name, ' ', p.last_name) as "Director name", 
    AVG(m.budget) as "Average budget"
FROM 
    Persons p
JOIN 
    Movies m ON p.id = m.director_id
GROUP BY 
    p.id, p.first_name, p.last_name;