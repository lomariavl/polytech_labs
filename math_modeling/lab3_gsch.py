import random
import math
import matplotlib.pyplot as plt
import numpy as np


def gsch() -> float:
    norm_distribution = 0.0  # random numbers sum

    for i in range(numbers):
        value = random.random()
        norm_distribution += value
    row_z = (norm_distribution - math_exp_v) / sigma_v
    # print(f'{row_z} - Z')

    delta_y = 0.5007268
    math_exp_z = 0.0
    row_x = delta_y * row_z + math_exp_z
    # print(f'{delta_y} - delta y')
    # print(row_x, ' - X')
    return row_x


numbers = 12
math_exp_v = numbers / 2  # mathematical expectation
sigma_v = math.sqrt(numbers / 12)


def base_gsch():
    sum_randoms = 0.0
    sum_dispersion = 0.0
    random_numbers = []
    for i in range(n):
        value = gsch()
        sum_randoms += value
        sum_dispersion += math.pow(value - m_theory, 2)
        random_numbers.append(value)
    intervals_values, bins = np.histogram(random_numbers, bins=num_intervals)

    math_exp = sum_randoms / n
    dispersion = sum_dispersion / n
    sigma = math.sqrt(dispersion)

    abscissa = tuple()
    for i in range(10):
        abscissa += (f'({bins[i]:.1f},'
                     f'\n{bins[i+1]:.1f})',)

    x = np.arange(len(abscissa))
    plt.bar(x, intervals_values)
    plt.xticks(x, abscissa)
    plt.title('ГСЧ')
    for i in range(len(abscissa)):
        plt.text(i, intervals_values[i], intervals_values[i], ha='center')

    plt.show()
    return f' {math_exp} - матожидание\n {dispersion} - дисперсия\n {sigma} - СКО'


n = 100000
num_intervals = 10
m_theory = 0.5

if __name__ == '__main__':
    value_gsch = base_gsch()
    print(f'{value_gsch}')
