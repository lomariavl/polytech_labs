program spline_var_18
    use Environment
 
    ! X(N),Y(N),   вычисляются - B(N),C(N),D(N)
    implicit none
    integer, parameter  :: N = 6
    real(R_)            :: X(N) = [0., 0.2, 0.4, 0.7, 0.9, 1.0]
    real(R_)            :: Y(N), A(N), B(N), C(N), D(N), S, seval, EPS, medium, halfY, leftBorder, rightBorder  
    
    Y = reshape([&
        1., 1.2214, 1.4918, 2.0138, 2.4596, 2.7183&
    ], shape(Y))

    EPS = 0.00001

    write(*, '(A)') "X"
    write(*, '('//N//'F5.2)') X

    write(*, '(A)') "f(x)"
    write(*, '('//N//'F7.4)') Y

    call SPLINE(N, X, Y, B, C, D)

    leftBorder = 0.0
    rightBorder = 1.0
    
    write(*, *)    
    write(*, '(A)') "Значения кубического сплайна:"

    do
        halfY = (rightBorder - leftBorder) / 2.0
        medium = leftBorder + halfY

        S = SEVAL(N, medium, X, Y, B, C, D) + medium**2 - 2

        
        write(*, '(A, T27, F8.5)') "Абсцисса: ", medium 
        write(*, '(A, '//N//'F11.8)') "Значение сплайна: ", S
        write(*, *)
        
        if (S > 0) then
            rightBorder = medium
        end if

        if (S < 0) then
            S = -S
            leftBorder = medium
        end if

        if (S < EPS) then
            exit
        end if
    end do

    write(*, '(A)') "f(x) + x^2 - 2 = 0"
    write(*, '('//N//'F11.8)') S
    write(*, *)

end program spline_var_18