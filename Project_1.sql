/*Q1: who is the senior most employee based on the job title?*/

SELECT * FROM employee ORDER BY levels DESC LIMIT 1

/*Q2.which countries have the most invoices*/
SELECT COUNT(invoice_id) AS num_invoices ,billing_country FROM invoice 
GROUP BY billing_country 
ORDER BY num_invoices DESC 

/*Q3: what are top 3 values of total invoice*/
SElect total FROM invoice ORDER BY total DESC
LIMIT 3

/*4. Which city has the best customers? We would like to throw a promotional Music
Festival in the city we made the most money. Write a query that returns one city that
has the highest sum of invoice totals. Return both the city name & sum of all invoice
totals*/
SELECT SUM(total) AS totals, billing_city FROM invoice
GROUP BY billing_city
ORDER BY totals DESC
LIMIT 1

/*Q5. Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent the
most money*/

/*customer table does not have the total bill made by the customer. So we need to join the customer table with invoice table*/
SELECT customer.customer_id, customer.first_name, customer.last_name,SUM(total) AS total_bill
FROM customer
JOIN invoice on customer.customer_id=invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total_bill DESC
LIMIT 1

/*1. Write query to return the email, first name, last name, & Genre of all Rock Music
listeners. Return your list ordered alphabetically by email starting with A*/
select distinct customer.first_name, customer.last_name, customer.email from customer
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in(
	Select track_id from track
	join genre on track.genre_id=genre.genre_id
	where genre.name='Rock'
)
order by email

/*Q.2. Let's invite the artists who have written the most rock music in our dataset. Write a
query that returns the Artist name and total track count of the top 10 rock bands*/
select artist.name, count(artist.artist_id) as num_songs from artist
join album on artist.artist_id=album.artist_id
join track on album.album_id=track.album_id
join genre on track.genre_id=genre.genre_id 
where genre.name='Rock'
group by artist.artist_id
order by num_songs desc
limit 10

/*Q3. Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the
longest songs listed first*/
select name, milliseconds from track
where milliseconds>(select avg(milliseconds) as average_track_length from track)
order by milliseconds desc