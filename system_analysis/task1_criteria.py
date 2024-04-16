arr_income = [[15, 10, 0, -6, 17],
              [3, 14, 8, 9, 2],
              [1, 5, 14, 20, -3],
              [7, 19, 10, 2, 0]]

arr_solution = ['x1', 'x2', 'x3', 'x4']

# 1
z_mm = [min(el) for el in arr_income]  # Column with the minimum values in the income matrix
print('Столбец минимальных значений:', z_mm)
max_index = z_mm.index(max(z_mm))  # Maximum value and its index in the column
z_mm = arr_solution[max_index]  # Solving the minimax criterion
print('Решение по минимаксного критерию, Zmm =', z_mm)

# 2
max_values = list(map(max, zip(*arr_income)))  # Column with the maximum values in the income matrix
rotated_arr = list(zip(*arr_income))  # Transposing the income matrix

# From the maximum value we subtract the column of the transposed matrix
rotated_arr_loss = [[max_values[i] - rotated_arr[i][j] for j in range(4)] for i in range(5)]
arr_loss = list(zip(*rotated_arr_loss))  # Transposing the loss matrix
print('Матрица потерь: [')
for arr in arr_loss:
    print(f'\t{arr}')
print(']')

z_s = [max(el) for el in arr_loss]  # Column with the maximum values in the loss matrix
print('Столбец максимальных значений:', z_s)
min_index = z_s.index(min(z_s))  # Minimum value and its index in the column
z_s = arr_solution[min_index]  # Solving the Savage criterion
print('Решение по критерию Сэвиджа, Zs =', z_s)

# 3
const = 0.61  # Initial constant
print('С =', const)

# Columns with minimum and maximum values in the income matrix
min_values, max_values = [min(el) for el in arr_income], [max(el) for el in arr_income]
print('Столбец минимальных значений:', min_values, '\nСтолбец максимальных значений: ', max_values)
min_values, max_values = list(map(float, min_values)), list(map(float, max_values))  # From int matrix to float matrix

# Calculation by Hurwitz criterion
arr_calc = [const * min_values[el] for el in range(4)], [(1 - const) * max_values[el] for el in range(4)]
z_hw = [sum(x) for x in zip(*arr_calc)]
print('Столбец вычисленный по формуле Гурвица: [' + ", ".join("%.2f" % x for x in z_hw) + ']')
max_index = z_hw.index(max(z_hw))  # Maximum value and its index in the column
z_hw = arr_solution[max_index]  # Solving the Hurwitz criterion
print('Решение по критерию Гурвица, Zhw =', z_hw)
