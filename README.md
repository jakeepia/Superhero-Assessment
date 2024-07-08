# SQL-Assessment-Solutions-for-Superhero-Database

## Overview
This document contains SQL queries designed to address specific assessment questions related to a superhero database. The questions focus on extracting and analyzing data on superheroes, their attributes, and their superpowers. Each section includes the SQL query, an explanation of its functionality, and key points for understanding the query's purpose and execution.

## 1. Querying Superhero Attributes
### Question:
Write a query that shows all the superheroes and the sum of their attributes, including those with no attributes. This query should return the sex, race, publisher, eye color, hair color, and skin color of each superhero.

### Answer:
<pre>
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
  </pre>

### Explanation:
1. Select Columns: Retrieves the superhero's name, gender, race, publisher name, eye color, hair color, and skin color.
2. LEFT JOINs: Ensures all superheroes are included, even those with no attributes.
3. SUM() and COALESCE(): Calculates the sum of the attribute values for each superhero, returning 0 if there are no attributes.
4. GROUP BY: Aggregates the results by the selected columns.

### Key Points:
- Ensures inclusion of all superheroes.
- Aggregates attribute values.
- Handles superheroes with no attributes by returning 0.

## 2. Counting Superheroes with Each Superpower
### Question:
Write a query that returns the list of all superpowers and the sum of superheroes that have this superpower.

### Answer:
<pre>
SELECT 
    sp.power_name,
    COUNT(hp.hero_id) AS total_heroes
FROM superpower sp
LEFT JOIN hero_power hp ON sp.id = hp.power_id
GROUP BY sp.power_name;
  </pre>


