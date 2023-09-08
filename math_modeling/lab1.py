import matplotlib.pyplot as plt


def transmission(z1: float, z2: float, z3: float, h: float) -> tuple[float, float, float]:
    dz1 = z1 + h * z2
    dz2 = z2 + h * z3
    dz3 = z3 + h * (15 - 3*z1 - 12*z2 - 20/3*z3) / 16
    return dz1, dz2, dz3


if __name__ == '__main__':
    Z1, Z2, Z3 = 0, 0, 0
    h = 0.05
    t = 0
    abscissa, ordinate = [], []

    while t < 150:
        DZ1, DZ2, DZ3 = transmission(Z1, Z2, Z3, h)
        y = 2 * Z1 - 4 * Z2 + 16 / 3 * Z3 + 0 * DZ3
        Z1, Z2, Z3 = DZ1, DZ2, DZ3
        abscissa.append(t)
        ordinate.append(y)
        if int(y) == 10:
            break
        t += h * 15

    counter = 0
    for i in range(len(ordinate)):
        print('%.2f' % abscissa[i], '\t', '%.6f' % ordinate[i])
        counter += 1
    plt.plot(abscissa, ordinate)
    plt.ylabel('y(t)')
    plt.xlabel('t')
    plt.show()
