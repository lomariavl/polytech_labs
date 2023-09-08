import random
import math
import matplotlib.pyplot as plt
import numpy as np


def base_gsch():
    sum_randoms = 0.0
    sum_dispersion = 0.0
    nums_values = [0] * num_intervals
    for i in range(n):
        value = random.random()
        sum_randoms += value
        sum_dispersion += math.pow(value - m_theory, 2)
        nums_values[int(value * 10)] += 1
        # print(value)
    math_exp = sum_randoms / n
    dispersion = sum_dispersion / n
    sigma = math.sqrt(dispersion)

    abscissa = ()
    for i in range(num_intervals):
        abscissa += (f'({i / num_intervals},\n{(i + 1) / num_intervals})',)

    x = np.arange(len(abscissa))
    plt.bar(x, nums_values)
    plt.xticks(x, abscissa)
    plt.title('Проверка встроенного ГСЧ')
    for i in range(len(abscissa)):
        plt.text(i, nums_values[i], nums_values[i], ha='center')

    plt.show()
    return f' {math_exp} - матожидание\n {dispersion} - дисперсия\n {sigma} - СКО'


n = 100000
num_intervals = 10
m_theory = 0.5

if __name__ == '__main__':
    generator = base_gsch()
    print(generator)
