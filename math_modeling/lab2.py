from matplotlib import pyplot

A, B = 2, 3
epx = 0.00001
M, N = 2, -0.5
a0 = [2, -0.5]  # ellipsoid
# a0 = [-0.5, 3]  # rozen
h = [0.06, 0.07]  # ellipsoid
# h = [0.4, 0.5]  # rozen
mak_k = 10000


def ellipsoid(x, y):
    return (x / A) ** 2 + (y / B) ** 2


def rozen(x, y):
    return (1 - x) ** 2 + 100 * (y - x * x) ** 2


def method_gauss_seidel():
    init_value = ellipsoid(*a0)
    # init_value = rozen(*a0)
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
            next_value = ellipsoid(*ak)
            # next_value = rozen(*ak)

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


x, y = method_gauss_seidel()
pyplot.figure(dpi=600)
pyplot.scatter(x, y)
pyplot.plot(x, y)
pyplot.show()
