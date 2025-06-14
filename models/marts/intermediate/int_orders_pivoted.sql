{% set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] %}


WITH payments AS (
    SELECT * FROM {{ ref('stg_stripe__payments') }}
    ),

    pivoted AS (
    SELECT 
        order_id
        {% for payment_method in payment_methods %}
            , SUM(CASE WHEN payment_method = {{ 'payment_method' }} THEN payment_amount ELSE 0 END) AS {{ 'payment_mehtod' }}_amount
        {% endfor %}
    FROM payments
    WHERE payment_status = 'success'
    GROUP BY 
        order_id
    )

SELECT * FROM pivoted

