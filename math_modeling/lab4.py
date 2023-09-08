import matplotlib.pyplot as plt
import random
import numpy as np

random.seed(0)


def transmission(z1: float, z2: float, z3: float, b_: float, tay_: float) -> tuple[float, float, float]:
    dz1 = z1 + step * z2
    dz2 = z2 + step * z3
    dz3 = z3 + step * (30 - 6*z1 - (6*b_+3*tay_)*z2 - (3*b_*tay_+tay_**2)*z3) / (b_*tay_**2)
    return dz1, dz2, dz3


def coordinates(b: float, tay: float):
    Z1, Z2, Z3 = 0, 0, 0
    t = 0
    t_base, y_base = [], []

    while t < 150:
        DZ1, DZ2, DZ3 = transmission(Z1, Z2, Z3, b, tay)
        y = 2 * (Z1 - tay/2 * Z2 + tay**2/6 * Z3)
        Z1, Z2, Z3 = DZ1, DZ2, DZ3
        t_base.append(t)
        y_base.append(y)
        if int(y) == 10:
            break
        t += step * 15
    return t_base, y_base


def gsch() -> float:
    norm_distribution = 0.0  # random numbers sum

    for i in range(numbers):
        value = random.random()
        norm_distribution += value
    row_z = (norm_distribution - math_exp_v) / sigma_v

    delta_y = 0.5007268
    row_x = delta_y * row_z
    return row_x


def get_cf(b_tay_test):
    Z1, Z2, Z3 = 0, 0, 0

    y_finish = []

    for n in range(197):
        DZ1, DZ2, DZ3 = transmission(Z1, Z2, Z3, *b_tay_test)
        y = 2 * (Z1 - b_tay_test[1] / 2 * Z2 + b_tay_test[1] ** 2 / 6 * Z3)
        Z1, Z2, Z3 = DZ1, DZ2, DZ3
        y_finish.append(y)

    arr1 = np.array(y_test)
    arr2 = np.array(y_finish)
    out_arr = (arr1 - arr2) ** 2
    cf = 1 / 198 * sum(out_arr)
    return cf


def method_gauss_seidel():
    init_value = get_cf(a0)
    abscissa = []
    ordinate = []
    found_exp = False
    i = 0
    for i in range(mak_k):
        for k in range(2):
            hk = h.copy()
            ak = a0.copy()
            hk[k] *= M
            ak[k] += hk[k]
            next_value = get_cf(ak)

            if next_value < init_value:
                h[k] *= M
                a0[k] += h[k]
                diff = abs(next_value - init_value)
                init_value = next_value

                if diff < epx:
                    found_exp = True
            else:
                h[k] *= N

            abscissa.append(a0[0])
            ordinate.append(a0[1])
        print(f'{abscissa[-1]:.4f}, {ordinate[-1]:.6f} = {init_value:.8f}')

        if found_exp:
            break
    print(i + 1)
    return abscissa, ordinate


if __name__ == '__main__':
    numbers = 12
    math_exp_v = 6  # mathematical expectation
    sigma_v = 1
    step = 0.05
    b1, tay1 = 2, 4
    b2, tay2 = 1.9281, 4.020156
    b3, tay3 = 1.9556, 3.999219

    t_base, y_base = coordinates(b1, tay1)
    noise = []
    for y in y_base:
        noise.append(gsch())

    y_test = []
    for j, val in enumerate(y_base):
        y_test.append(val + noise[j])

    plt.plot(t_base, y_test)
    plt.ylabel('y(t)')
    plt.xlabel('t')
    plt.show()

    epx = 0.00001
    M, N = 2, -0.5
    a0 = [2, 4]
    h = [0.06, 0.07]
    mak_k = 10000

    x, y = method_gauss_seidel()
    plt.figure(dpi=600)
    plt.scatter(x, y)
    plt.plot(x, y)
    plt.title('Траектория движения к минимуму')
    plt.show()
# ----------------------------------------

    t2_base, y2_base = coordinates(b2, tay2)
    t3_base, y3_base = coordinates(b3, tay3)

    for i in range(len(y_base)):
        print('%.2f' % t_base[i], '\t', '%.6f' % y_base[i])

    plt.plot(t_base, y_base, color='yellow')
    plt.plot(t2_base, y2_base, color='red')
    plt.plot(t3_base, y3_base, color='green')
    plt.ylabel('y(t)')
    plt.xlabel('t')
    plt.show()
