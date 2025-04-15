-- 1) Como encontrar todos os filmes de James Cameron, Luc Besoson e de John Woo?
With james_cameron AS(
  select d.name, m.title
  from movies m
  join directors d ON d.id = m.director_id
  where d.name = 'James Cameron'
),
luc_besson AS (
  select d.name, m.title
  from movies m
  join directors d ON d.id = m.director_id
  where d.name = 'Luc Besson'
),
john_woo AS (
  select d.name, m.title
  from movies m
  join directors d ON d.id = m.director_id
  where d.name = 'John Woo'
)

SELECT * FROM james_cameron
UNION ALL
SELECT * FROM luc_besson
UNION ALL
SELECT * FROM john_woo;


-- 2) Que filmes foram dirigidos por Brenda Chapman?
select m.title
from movies m
join directors d ON d.id = m.director_id
where d.name = 'Brenda Chapman';


-- 3) Diretor e diretora que mais dirigiu filmes
with top_male AS(
  select d.name, count(m.id) as qtd_filmes
  from movies m
  join directors d ON d.id = m.director_id
  WHERE d.gender = 2 
  GROUP By d.name
  ORDER By qtd_filmes DESC
  LIMIT 1	  
),
top_female AS (
  select d.name, count(m.id) as qtd_filmes
  from movies m
  join directors d ON d.id = m.director_id
  WHERE d.gender = 1
  GROUP By d.name
  ORDER By qtd_filmes DESC
  LIMIT 1
)

SELECT * from top_male
UNION ALL
SELECT * from top_female;

-- 4) Diretor e diretora que mais vendeu 

WITH top_female AS(
  SELECT d.name, m.revenue as Receita
  FROM movies m 
  join directors d ON d.id = m.director_id
  where d.gender = 1
  GROUP by d.name
  ORDER BY m.revenue DESC
  LIMIT 1
),

top_male AS (
  SELECT d.name, m.revenue as Receita
  FROM movies m 
  join directors d ON d.id = m.director_id
  where d.gender = 2
  GROUP by d.name
  ORDER BY m.revenue DESC
  LIMIT 1
)

SELECT * FROM top_female
UNION ALL
SELECT * FROM top_male;

-- 5) Quais diretores lançaram filmes em 2009?
SELECT d.name 
FROM directors d 
JOIN movies m ON m.director_id = d.id
WHERE strftime('%Y', m.release_date) = '2009';