import math

def fft(x):
    '''Fast Fourier Transform.
    Implemented using the Cooley-Tukey algorithm.
    The Discrete Fourier Transform is described by the formula:
        X_k = \sum_{n = 0}^N x_n * e^{-2 * pi * i * n * k / N}

    Algorithm:
        - split into two parts in the well known d&c way.
        - first half contains all the even indexed values and the second the odd ones.
        - compute the DFT for those two halves.
        - now the DFT can be can be compute by:
            X_k = Even_k + e^{-2 * pi * i * k / N} * Odd_k      if k < N / 2
                  Even_k - e^{-2 * pi * i * k / N} * Odd_k      if not

    Time: O(n*log(n))
    '''
    n = len(x)

    if n == 1:
        return x

    even = fft(x[::2])
    odd = fft(x[1::2])

    X = [0] * n
    for k in range(n // 2):
        w = math.e ** (math.pi * 2j * k / n)
        X[k] = even[k] + w * odd[k]
        X[k + n // 2] = even[k] - w * odd[k]

    return X

def test():
    from numpy.fft import fft as npfft
    import random

    a = [random.randint(0, 100) for i in range(8)]
    print(a)
    print(fft(a))
    print(list(npfft(a)))

if __name__ == "__main__":
    test()
