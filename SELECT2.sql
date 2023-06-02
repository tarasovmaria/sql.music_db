--SELECT requests #2
--Количество исполнителей в каждом жанре.
SELECT name, COUNT(ga.artist_id) FROM genres g
LEFT JOIN genres_artists ga ON g.genre_id = ga.genre_id
LEFT JOIN music_artists ma ON ga.artist_id = ma.artist_id
GROUP BY g.genre_id;
--Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(track_id) FROM tracks t
JOIN albums a ON t.album_id = a.album_id
WHERE release_year BETWEEN 2019 AND 2020;
--Средняя продолжительность треков по каждому альбому.
SELECT a.title, AVG(t.duration) FROM albums a  
LEFT JOIN tracks t on t.album_id = a.album_id
GROUP BY a.title 
ORDER BY AVG(t.duration);
--Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT DISTINCT ma.alias FROM music_artists ma
WHERE ma.alias NOT IN (
SELECT DISTINCT ma.alias FROM music_artists ma
LEFT JOIN artists_albums aa ON ma.artist_id = aa.artist_id
LEFT JOIN albums a ON a.album_id = aa.album_id
WHERE a.release_year = 2020
)
ORDER BY ma.alias;
--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT c.title FROM collections c
LEFT JOIN tracks_collections tc ON c.collection_id = tc.collection_id
LEFT JOIN tracks t ON t.track_id = tc.track_id
LEFT JOIN albums a ON a.album_id = t.album_id
LEFT JOIN artists_albums aa ON aa.album_id = a.album_id
LEFT JOIN music_artists ma ON ma.artist_id = aa.artist_id
WHERE ma.alias LIKE '%Tame Impala%'
ORDER BY c.title;
--Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT DISTINCT a.title FROM albums a
JOIN artists_albums aa ON a.album_id = aa.album_id
JOIN music_artists ma ON aa.artist_id = ma.artist_id
JOIN genres_artists ga ON ma.artist_id = ga.artist_id
GROUP BY a.title, ga.artist_id
HAVING COUNT(ga.genre_id) > 1;
--Наименования треков, которые не входят в сборники.
SELECT t.title FROM tracks t
LEFT JOIN tracks_collections tc ON t.track_id = tc.track_id
WHERE tc.track_id IS NULL;
--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT ma.alias, t.duration FROM tracks t
LEFT JOIN albums a ON t.album_id = a.album_id
LEFT JOIN artists_albums aa ON a.album_id = aa.album_id
LEFT JOIN music_artists ma ON aa.artist_id = ma.artist_id
GROUP BY ma.alias, t.duration
HAVING t.duration = (SELECT MIN(duration) FROM tracks)
ORDER BY t.duration;
--Названия альбомов, содержащих наименьшее количество треков.
SELECT DISTINCT a.title FROM albums a 
LEFT JOIN tracks t ON t.album_id = a.album_id 
WHERE t.album_id IN (
	SELECT album_id FROM tracks
	GROUP BY album_id
	HAVING COUNT(track_id) = (
		SELECT COUNT(track_id) FROM tracks
		GROUP BY album_id 
		ORDER BY count(*)
		LIMIT 1
		)
)
ORDER BY a.title;