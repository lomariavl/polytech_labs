program cw_var18
    use Environment
 
    implicit none
 
    integer, parameter    :: NDIM = 3, NEQN = 3
    integer               :: j, IPVT(NDIM), NOFUN = 0, IWORK(5), IFLAG
    real(R_)              :: c_first, c_final, Uc_calc(11), t_init(11), Uc_init(11), Uc_finish(11), CF
    real(R_)              :: cond = 0, WORK(NDIM), R, R2, E2, matrix(NDIM, NDIM), matrix_b(NDIM)
    real(R_)              :: A_low, B_high, ABSERR, RELERR, RESULT, ERREST, FLAG, L
    real(R_)              :: TOL, E1, ZEROIN, A, B
    real(R_)              :: WORK_RKF(21), t, tPrint, tFinal, CiG, i1(NEQN), tOut, FMIN, endC
    real(R_), parameter   :: h = 0.00000005

    matrix = reshape([&
        53, 46, 20,&
        46, 50, 26,&
        20, 26, 17&
    ], shape(matrix))
    
    matrix_b = reshape((/ 3060, 2866, 1337 /), shape(matrix_b))

    Uc_init = reshape((/ -1.0, 7.777, 12.017, 10.701, 5.407, -0.843, -5.159, -6.015, -3.668, 0.283, 3.829 /), shape(Uc_init))
    t_init = reshape((/ 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0 /), shape(t_init))
    

    call DECOMP(NDIM, NDIM, matrix, cond, IPVT, WORK)
    write(*, *)
    write(*, '("Число обусловленности = ", E12.5)') cond
    write(*, *)

    call SOLVE(NDIM, NDIM, matrix, matrix_b, IPVT)
    R  = matrix_b(1)
    R2 = matrix_b(2)
    E2 = matrix_b(3)
    write(*, '(3(a, f4.1))') "R = ", R, " R2 = ", R2, " E2 = ", E2
        
    A_low = 1.0
    B_high = 2.0
    ABSERR = 0.0
    RELERR = 1.E-06

    call QUANC8(integralFunc, A_low, B_high, ABSERR, RELERR, RESULT, ERREST, NOFUN, FLAG)
    
    L = 0.4674158 * RESULT
    write(*, '(a, f4.2)') "L = ", L
    write(*, *)
    write(*, '(a8, e14.7/, a8, e14.7/, a8, i14/, a8, f14.3/)') "Result: ", RESULT, &
                                                               "Errest: ", ERREST, &
                                                               "NOFUN: ", NOFUN, &
                                                               "FLAG: ", FLAG
    TOL=1.0E-6
    A = 0.0
    B = 1.0
    E1 = 5.718088 * ZEROIN(A, B, F, TOL)
    write(*, '(a, f5.2)') "E1 = ", E1
    write(*, *)
    tFinal = 0.001
    tPrint = 0.0001
    
    TOL = 0.00000005

    c_first = 0.0000005
    c_final = 0.000002

    endC = FMIN(c_first, c_final, getDiff, TOL)
    write(*, *) "Capacitor: ", endC * 1000000, " mF"

contains

    real(R_) function integralFunc(x)
        real(R_)    :: x
        integralFunc = cos(x) / x
    
    end function integralFunc

    real(R_) function F(x)
        real(R_)    :: x
        F = 0.6 ** x - x
    
    end function F
    
    SUBROUTINE funcDiff(t, i1, Yp)
        real(R_)     :: t, i1(3), Yp(3)
        
        Yp(1) = (E1 - E2 - i1(3) + i1(2)*R2 - i1(1)*(R + R2)) / L
        Yp(2) = (E2 + i1(3) + i1(1)*R2 - i1(2)*(R2 + R)) / L
        Yp(3) = (i1(1) - i1(2)) / CiG
        return

    END SUBROUTINE funcDiff

    real(R_) function getDiff(Ci)
        real(R_)     :: Ci
        CiG = Ci
        
        i1(1) = E1 / R
        i1(2) = 0.0
        i1(3) = -E2

        RELERR = 0.1E-06
        ABSERR = 0.0
        IFLAG = 1
        t = 0.0
        tOut = t
        j = 1
        write(*, *) "Ci=", Ci
        do
            call RKF45(funcDiff, NEQN, i1, t, tOut, RELERR, ABSERR, IFLAG, WORK_RKF, IWORK)

            if (t >= tFinal) exit
            
            write(*, '(a, F6.4, 3(a, F10.4))') "t = ", t, " i1 = ", i1(1)," i3 = ", i1(2), " Uc_calc = ", i1(3)
           
            select case(IFLAG)
                case(1, 8)
                    exit
                case(2)
                    tOut = t + tPrint
                    if (t < tFinal) then
                        Uc_calc(j) = i1(3)                           
                        j = j + 1
                        continue
                    end if
                case(3)
                    write (*, '(a)') " ГPAHИЦЫ ПOГPEШHOCTEЙ ИЗMEHEHЫ"
                    write (*, '(2(a, E10.3))') "RELERR= ", RELERR, " ABSERR= ", ABSERR
                    continue
                case(4)
                    continue
                case(5)
                    ABSERR = 1e-7
                    continue
                case(6)
                    RELERR = RELERR * 10.0 
                    IFLAG = 2
                    continue
                case(7)
                    IFLAG = 2
                    continue
            end select
        end do
        Uc_finish = (Uc_calc - Uc_init) ** 2
        CF = sum(Uc_finish)
        write(*, *) "CF=", CF
        write(*, *)
        getDiff = CF
        return

    end function getDiff

    

end program cw_var18
