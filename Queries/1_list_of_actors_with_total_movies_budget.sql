SELECT
    p.id AS "ID",
    p.first_name AS "First name",
    p.last_name AS "Last name",
    COALESCE(SUM(m.budget), 0) AS "Total movies budget"
FROM
    Persons p
    JOIN (
        SELECT DISTINCT
            c.actor_id,
            m.budget
        FROM
            Characters c
            JOIN Movies m ON c.movie_id = m.id
    ) m ON p.id = m.actor_id
GROUP BY
    p.id, p.first_name, p.last_name;