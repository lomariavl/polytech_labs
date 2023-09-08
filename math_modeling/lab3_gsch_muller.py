import random
import math
import matplotlib.pyplot as plt
import numpy as np


def gsch_muller() -> float:
    r1 = random.random()
    r2 = random.random()

    z1 = math.cos(2 * math.pi * r1) * math.sqrt(-2 * math.log(r2))
    # z2 = math.sin(2 * math.pi * r1) * math.sqrt(-2 * math.log(r2))

    delta_y = 0.5007268
    math_exp_z = 0.0
    row_x = delta_y * z1 + math_exp_z
    # row_x_2 = delta_y * z2 + math_exp_z
    return row_x


def base_gsch():
    sum_randoms = 0.0
    sum_dispersion = 0.0
    random_numbers = []
    for i in range(n):
        value = gsch_muller()
        sum_randoms += value
        sum_dispersion += math.pow(value - m_theory, 2)
        random_numbers.append(value)

    nums_values, bins = np.histogram(random_numbers, bins=num_intervals)
    math_exp = sum_randoms / n
    dispersion = sum_dispersion / n
    sigma = math.sqrt(dispersion)

    abscissa = tuple()
    for i in range(20):
        if i % 2:
            abscissa += (f'\n({bins[i]:.1f})',)
            continue
        abscissa += (f'({bins[i]:.1f})',)

    x = np.arange(len(abscissa))
    plt.bar(x, nums_values)
    plt.xticks(x, abscissa)
    plt.title('ГСЧ Мюллера')
    for i in range(len(abscissa)):
        plt.text(i, nums_values[i], nums_values[i], ha='center')

    plt.show()
    return f' {math_exp} - матожидание\n {dispersion} - дисперсия\n {sigma} - СКО'


n = 100000
num_intervals = 20
m_theory = 0.5

if __name__ == '__main__':
    value_gsch = base_gsch()
    print(f'{value_gsch}')
