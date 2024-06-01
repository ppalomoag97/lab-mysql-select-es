use publications;

-- Desafío 1 - ¿Quién ha publicado qué y dónde?
-- En este desafío escribirás una consulta SELECT de MySQL que una varias tablas para descubrir qué títulos ha publicado cada autor en qué editoriales.

SELECT a.au_id as 'AUTHOR ID',
	   a.au_lname as 'LAST NAME',
       a.au_fname as 'FIRST NAME' ,
       t.title as TITLE,
       p.pub_name as PUBLISHER
FROM titleauthor as ta
LEFT JOIN authors as a
ON ta.au_id = a.au_id
LEFT JOIN titles as t
ON ta.title_id = t.title_id
LEFT JOIN publishers as p
ON t.pub_id = p.pub_id
ORDER BY a.au_id;

-- Desafío 2 - ¿Quién ha publicado cuántos y dónde?
-- Partiendo de tu solución en el Desafío 1, consulta cuántos títulos ha publicado cada autor en cada editorial.

SELECT a.au_id as 'AUTHOR ID',
	   a.au_lname as 'LAST NAME',
       a.au_fname as 'FIRST NAME' ,
	   p.pub_name as PUBLISHER,
	   COUNT(t.title) as 'TITLE COUNT'
FROM titleauthor as ta
LEFT JOIN authors as a
ON ta.au_id = a.au_id
LEFT JOIN titles as t
ON ta.title_id = t.title_id
LEFT JOIN publishers as p
ON t.pub_id = p.pub_id
GROUP BY a.au_id, a.au_lname, a.au_fname, p.pub_name
ORDER BY a.au_id, p.pub_name;

-- Desafío 3 - Autores Más Vendidos
-- ¿Quiénes son los 3 principales autores que han vendido el mayor número de títulos? Escribe una consulta para averiguarlo.
SELECT a.au_id as 'AUTHOR ID',
	   a.au_lname as 'LAST NAME',
       a.au_fname as 'FIRST NAME' ,
	  sum(s.qty) AS "TOTAL"
FROM authors as a
LEFT JOIN titleauthor as ta
ON ta.au_id = a.au_id
JOIN sales as s
ON ta.title_id = s.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY sum(s.qty) desc
limit 3;


-- Desafío 4 - Ranking de Autores Más Vendidos
-- Ahora modifica tu solución en el Desafío 3 para que la salida muestre a todos los 23 autores en lugar de solo los 3 principales. Ten en cuenta que los autores que han vendido 0 títulos también deben aparecer en tu salida (idealmente muestra 0 en lugar de NULL como TOTAL). También ordena tus resultados basándose en TOTAL de mayor a menor.
SELECT a.au_id as 'AUTHOR ID',
	   a.au_lname as 'LAST NAME',
       a.au_fname as 'FIRST NAME' ,
	  sum(case when s.qty is null then 0
		else s.qty
		end)
FROM authors as a
LEFT JOIN titleauthor as ta
ON ta.au_id = a.au_id
JOIN sales as s
ON ta.title_id = s.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY sum(s.qty) desc;
