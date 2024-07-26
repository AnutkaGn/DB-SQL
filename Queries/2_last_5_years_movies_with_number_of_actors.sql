SELECT 
    m.id, 
    m.title, 
    COUNT(DISTINCT c.actor_id) as "Number of actors"
FROM 
    Movies m
LEFT JOIN 
    Characters c ON m.id = c.movie_id
WHERE 
    m.release_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY 
    m.id, m.title;