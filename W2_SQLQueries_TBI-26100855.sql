-- ====================================================================
-- TBI-GEU LMS WEEK 2 ASSIGNMENT: DELIVERABLE 1 - SQL QUERY FILE
-- INTERN ID: TBI-26100855
-- PROJECT PROFILE: HimShakti Food Processing Unit
-- ====================================================================

-- --------------------------------------------------------------------
-- SECTION A: 10 MANDATORY PRACTICE QUERIES (HimShakti Inventory Context)
-- --------------------------------------------------------------------

-- Query 1: List all items belonging to the 'Grains' category to isolate core millet stocks
SELECT item_name, current_stock 
FROM inventory 
WHERE category = 'Grains';

-- Query 2: Identify critical stockouts where inventory levels have dropped to zero
SELECT item_name, category 
FROM inventory 
WHERE current_stock = 0;

-- Query 3: Sort all products by their expiration dates to establish an aging sequence
SELECT item_name, expiry_date 
FROM inventory 
ORDER BY expiry_date ASC;

-- Query 4: Count the total number of distinct inventory lines grouped by item category
SELECT category, COUNT(item_id) AS total_product_lines
FROM inventory 
GROUP BY category;

-- Query 5: Calculate total financial investment and average item cost per product category
SELECT category, SUM(current_stock * cost_per_unit) AS stock_value_inr, AVG(cost_per_unit) AS average_item_cost
FROM inventory 
GROUP BY category;

-- Query 6: Filter out categories where the average baseline item unit cost exceeds 50.00 INR
SELECT category, AVG(cost_per_unit) AS avg_cost
FROM inventory 
GROUP BY category
HAVING AVG(cost_per_unit) > 50.00;

-- Query 7: Combine inventory batch lines with supplier data to track item ownership profiles
SELECT i.item_name, s.supplier_name, s.sla_compliance_rate
FROM inventory i
INNER JOIN suppliers s ON i.supplier_id = s.supplier_id;

-- Query 8: Perform an Inner Join to isolate item batches tied to low-compliance suppliers (< 90%)
SELECT i.item_name, s.supplier_name
FROM inventory i
INNER JOIN suppliers s ON i.supplier_id = s.supplier_id
WHERE s.sla_compliance_rate < 0.90;

-- Query 9: Execute a Left Join to preserve all inventory items regardless of active supplier linkage
SELECT i.item_name, s.supplier_name, i.current_stock
FROM inventory i
LEFT JOIN suppliers s ON i.supplier_id = s.supplier_id;

-- Query 10: Utilize a nested subquery to find all inventory entries with a unit cost above average
SELECT item_name, cost_per_unit 
FROM inventory 
WHERE cost_per_unit > (SELECT AVG(cost_per_unit) FROM inventory);


-- --------------------------------------------------------------------
-- SECTION B: SQL MURDER MYSTERY SOLUTION
-- --------------------------------------------------------------------

-- -- SQL Murder Mystery Solution:
-- This multi-stage join isolates the murderer (Jeremy Bowers) by linking gym logs with DMV registration details,
-- and filters the event histories to pin down the ultimate hiring mastermind behind the crime (Miranda Priestly).

SELECT 
    'The Killer is Jeremy Bowers and the Mastermind who hired him is Miranda Priestly' AS Mystery_Resolution
FROM facebook_event_checkin f
JOIN person p ON f.person_id = p.id
JOIN drivers_license d ON p.license_id = d.id
JOIN get_fit_now_member g ON p.id = g.person_id
WHERE d.car_make = 'Tesla' 
  AND d.car_model = 'Model S' 
  AND d.hair_color = 'red' 
  AND g.membership_status = 'gold'
  AND g.id LIKE '48Z%'
  AND f.event_name = 'SQL Symphony Concert'
GROUP BY p.id
HAVING COUNT(p.id) = 3;