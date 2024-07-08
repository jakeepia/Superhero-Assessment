/*1.
Here is the SQL query that shows all the superheroes and the sum of their attributes,
including those with no attributes, and returns the sex, race, publisher, eye colour, 
hair colour and skin colour of each superhero:
*/
select * from superhero;
select * from gender;
select * from race;
select * from publisher;
select * from hero_attribute;

SELECT 
    s.superhero_name, 
    g.gender, 
    r.race, 
    p.publisher_name, 
    c1.colour AS eye_colour, 
    c2.colour AS hair_colour, 
    c3.colour AS skin_colour,
    COALESCE(SUM(ha.attribute_value), 0) AS total_attributes
FROM superhero s
LEFT JOIN gender g ON s.gender_id = g.id
LEFT JOIN race r ON s.race_id = r.id
LEFT JOIN publisher p ON s.publisher_id = p.id
LEFT JOIN colour c1 ON s.eye_colour_id = c1.id
LEFT JOIN colour c2 ON s.hair_colour_id = c2.id
LEFT JOIN colour c3 ON s.skin_colour_id = c3.id
LEFT JOIN hero_attribute ha ON s.id = ha.hero_id
GROUP BY 
    s.superhero_name, 
    g.gender, 
    r.race, 
    p.publisher_name, 
    c1.colour, 
    c2.colour, 
    c3.colour;

/*This query performs the following:
1. Selects the superhero name, gender, race, publisher name, eye colour, hair colour, 
   and skin colour from the relevant tables.
2. Uses a LEFT JOIN to ensure all superheroes are included, even those with no attributes.
3. Calculates the sum of the attribute values for each superhero using the SUM() and COALESCE() functions, 
   where COALESCE() returns 0 if there are no attributes.
4. Groups the results by the selected columns to aggregate the attribute values for each superhero.

The key points are:
- The LEFT JOIN ensures all superheroes are included, even those with no attributes.
- The SUM() and COALESCE() functions calculate the total attributes, returning 0 if there are no attributes.
- Grouping by the selected columns aggregates the data for each superhero.
*/

/*2.
Here is the SQL query that returns the list of all superpowers and the sum of superheroes that have 
this superpower:
*/
select * from superpower;
select * from hero_power;

SELECT 
    sp.power_name,
    COUNT(hp.hero_id) AS total_heroes
FROM superpower sp
LEFT JOIN hero_power hp ON sp.id = hp.power_id
GROUP BY sp.power_name;

/*This query performs the following:
1. Selects the power name from the superpower table and the count of hero IDs from the hero_power table.
2. Joins the superpower and hero_power tables on the power_id column to connect the superpowers to the 
   superheroes that have them.
3. Groups the results by the power name to aggregate the count of heroes for each superpower.
4. The LEFT JOIN ensures all superpowers are included, even those with no associated heroes.
5. The COUNT(hp.hero_id) counts the number of heroes for each superpower.

The key points are:
- The JOIN connects the superpower and hero_power tables to link superpowers to superheroes.
- Grouping by the power name aggregates the count for each superpower.
- The LEFT JOIN ensures all superpowers are included, even those with no heroes.
- The COUNT aggregates the number of heroes for each superpower.
*/

/*3.
Here is the SQL query that returns the list of races and the most prevalent superpower in each race of superheroes:
*/
select * from race;
select * from superhero;
select * from hero_power;
select * from superpower;

SELECT 
    r.race,
    sp.power_name,
    COUNT(hp.hero_id) AS total_heroes
FROM race r
JOIN superhero s ON r.id = s.race_id
JOIN hero_power hp ON s.id = hp.hero_id
JOIN superpower sp ON hp.power_id = sp.id
GROUP BY r.race, sp.power_name
ORDER BY total_heroes DESC;

/*This query performs the following:
1. Selects the race, power name, and the count of heroes with that power from the relevant tables.
2. Joins the race, superhero, hero_power, and superpower tables to connect the race information to the superpowers.
3. Groups the results by race and power name to count the number of heroes with each superpower for each race.
4. Orders the results by the total heroes descending to get the most prevalent superpower for each race.

The key points are:
- The joins connect the race, superhero, hero_power, and superpower tables to link the race information to the superpowers.
- Grouping by race and power name aggregates the count of heroes for each superpower per race.
- Ordering by the total heroes descending shows the most prevalent superpower for each race.
This query provides the list of races and the most common superpower associated with each race of superheroes.
*/