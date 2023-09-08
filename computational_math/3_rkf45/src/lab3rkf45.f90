program rkf45_var18
    use Environment
 
    implicit none
 
    integer, parameter  :: NEQN = 2
    integer             :: IWORK(5), IFLAG, I
    real(R_)            :: T, Tstep, Y(NEQN), Tout, RELERR, ABSERR, Tfinal, Tprint, WORK(15)
    real(R_)            :: Zn(NEQN), Zn1(NEQN), Zn2(NEQN), F1(NEQN), F2(NEQN)
    real(R_), parameter :: h = 0.001

    T = 0.0
    Tfinal = 0.4
    Tprint = 0.01
    Y(1) = 0.0
    Y(2) = 1.0
    RELERR = 0.1E-06
    ABSERR = 0.0
    IFLAG = 1
    I = 0

    Tout = T

    do
        call RKF45(ORBIT, NEQN, Y, T, Tout, RELERR, ABSERR, IFLAG, WORK, IWORK)
        if (T > Tfinal) exit

        write(*, '(a, F4.2, 2(a, F10.6))') "t = ", T, " y1 = ", Y(1)," y2 = ", Y(2)
        
        select case(IFLAG)
            case(1, 8)
                exit
            case(2)
                Tout = T + Tprint
                if (T < Tfinal) then
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

    T = 0.0
    Zn(1) = 0.0
    Zn(2) = 1.0    

    write(*, *)
    write(*, '(a, F4.2, 2(a, F10.6))') "t = ", T, " y1 = ", Zn(1)," y2 = ", Zn(2)

    do 
        if (mod(I, 10) == 0) then
            write(*, '(a, F4.2, 2(a, F10.6))') "t = ", T, " y1 = ", Zn(1)," y2 = ", Zn(2) ! h=0.001
        end if 
        ! write(*, *) Zn(1), Zn(2) ! h=0.01
        if (T > Tfinal) exit
        
        call ORBIT(T, Zn, Y)

        F1 = Zn + h/6 * Y
        Tstep = T + h / 6
        call ORBIT(Tstep, F1, Zn1)
        
        F2 = Zn + h*(-2*Y + 3*Zn1)
        Zn = F2
        
        ! write(*, *) F2(1), F2(2) ! h=0.01
        T = T + h
        I = I + 1
    end do

contains
    
    SUBROUTINE ORBIT(T, Y, Yp)
        real(R_)     :: T, Y(2), Yp(2)

        Yp(1) = -310*Y(1)-3000*Y(2)+1/(10*T**2+1)
        Yp(2) = Y(1)+exp(-2*T)
                
        return
    END SUBROUTINE ORBIT 

end program rkf45_var18
