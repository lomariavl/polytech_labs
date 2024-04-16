# Initial values
arr_init = [100, 150, 200, 250, 300]
probability = [0.3, 0.25, 0.1, 0.25, 0.1]
full_price = 49
cost_price = 25
discount_price = 15
arr_calc = []

# Profit calculation
for order in arr_init:
    for demand in arr_init:
        # Demand exceeds order
        if order <= demand:
            arr_calc += [full_price * order - cost_price * order]
            continue
        arr_calc += [(full_price - cost_price) * demand + (discount_price - cost_price) * (order - demand)]

arr_calc = [arr_calc[5*x:5+x*5] for x in range(5)]
print('Массив зависимостей заказ/спрос:\n [')
for x in range(5):
    print(f'\t{arr_calc[x]}')
print(']')

# Calculation by Bayes-Laplace criterion
z_bl = [arr[x] * probability[x] for x in range(5) for arr in arr_calc]
z_bl = list(map(int, z_bl))
z_bl = [z_bl[5*x:5+x*5] for x in range(5)]
z_bl = list(zip(*z_bl))
z_bl = [sum(arr) for arr in z_bl]
print('Ожидаемая прибыль от заказа: [')
for x in range(5):
    print(f'\t{100+x*50}: {z_bl[x]}')
print(']')

max_index = z_bl.index(max(z_bl))  # Maximum value and its index in the column
# Solving the Bayes-Laplace criterion
order = arr_init[max_index]  # Optimal order of Mercedes
z_bl = max(z_bl)  # Optimal expected cost
print('Оптимальный заказ мерседесов:', order)
print('Оптимальная ожидаемая стоимость:', z_bl)
