SELECT 
    m.id, 
    m.title, 
    m.release_date, 
    m.duration, 
    m.description,
    JSON_BUILD_OBJECT(
        'id', pf.id,
        'file_name', pf.file_name,
        'url', pf.url
    ) as poster,
    JSON_BUILD_OBJECT(
        'id', d.id,
        'first_name', d.first_name,
        'last_name', d.last_name,
        'photo', JSON_BUILD_OBJECT(
            'id', df.id,
            'file_name', df.file_name,
            'url', df.url
        )
    ) as director,
    (
        SELECT JSON_AGG(
            JSON_BUILD_OBJECT(
                'id', a.id,
                'first_name', a.first_name,
                'last_name', a.last_name,
                'photo', JSON_BUILD_OBJECT(
                    'id', af.id,
                    'file_name', af.file_name,
                    'url', af.url
                )
            )
        )
        FROM Characters c
        JOIN Persons a ON c.actor_id = a.id
        LEFT JOIN Files af ON a.primary_photo_id = af.id
        WHERE c.movie_id = m.id
    ) as actors,
    (
        SELECT JSON_AGG(
            JSON_BUILD_OBJECT(
                'id', g.id,
                'name', g.name
            )
        )
        FROM MovieGenres mg
        JOIN Genres g ON mg.genre_id = g.id
        WHERE mg.movie_id = m.id
    ) as genres
FROM 
    Movies m
LEFT JOIN Files pf ON m.poster_id = pf.id
JOIN Persons d ON m.director_id = d.id
LEFT JOIN Files df ON d.primary_photo_id = df.id
WHERE 
    m.id = 1;