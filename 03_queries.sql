
-- Сумма товаров по клиентам
select 
/*	
    c.client_id,
	c.name,
	c.address,
	o.order_date,
	op.order_id,
	op.product_id,
	op.quantity,
	p.name,
	p.price
*/
	c.name as "Имя клиента",
	sum(p.price * op.quantity) as "Сумма"
from clients c
	inner join orders o on c.client_id = o.client_id
	inner join order_products op on op.order_id = o.order_id
	inner join products p on p.product_id = op.product_id
group by c.client_id
order by "Сумма" DESC
;

-- Количество дочерних элементов первого уровня
WITH RECURSIVE category_tree AS (
    -- Корневые элементы
    select 
    	category_id, 
    	name, 
    	parent_id, 
    	0 as level
    from categories 
    WHERE parent_id IS null
    
    UNION all
    
    -- Дочерние элементы
    SELECT 
    	cg.category_id, cg.name, cg.parent_id, ct.level + 1
    FROM categories cg
    JOIN category_tree ct ON cg.parent_id = ct.category_id
)
SELECT 
    ct.name AS "Категория",
    COUNT(child.category_id) AS "Количество дочерних"
FROM category_tree ct
LEFT JOIN categories child ON child.parent_id = ct.category_id
WHERE ct.level = 0  -- Только категории первого уровня
   OR ct.parent_id IS NOT NULL  -- Или все остальные
GROUP BY ct.category_id, ct.name
ORDER BY ct.category_id;
/*select 
	*
from category_tree ct*/
;