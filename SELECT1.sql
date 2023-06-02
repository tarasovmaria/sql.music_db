--SELECT requests #1
-- Название и год выхода альбомов, вышедших в 2018 году.
SELECT title, release_year FROM albums
WHERE release_year = 2018;
-- Название и продолжительность самого длительного трека.
SELECT title, duration FROM tracks 
WHERE duration = (SELECT MAX(duration) FROM tracks);
-- Название треков, продолжительность которых не менее 3,5 минут.
SELECT title FROM tracks
WHERE duration > '00:03:30';
-- Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title FROM collections
WHERE release_year BETWEEN 2018 AND 2020;
-- Исполнители, чьё имя состоит из одного слова.
SELECT alias FROM music_artists
WHERE (LENGTH(alias)-LENGTH(REPLACE(alias,' ',''))+1)=1;
-- Название треков, которые содержат слово «мой» или «my».
SELECT title FROM tracks
WHERE title LIKE '%my%' OR '%мой%';