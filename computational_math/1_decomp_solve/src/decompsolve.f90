program decompsolve
    use Environment
 
    implicit none
    integer               :: n, ndimi, i, j
    integer, parameter    :: NDIMS(5) = [4, 6, 8, 10, 12]
    real(R_)              :: cond = 0, p = 4, R, tmpR
    real(R_), allocatable :: B(:, :), tmpB(:, :), IPVT(:), WORK(:), tmpC(:), invB(:, :), E(:, :)

    do ndimi = 1, 5
        n = NDIMS(ndimi)
        allocate(B(n, n))
        allocate(tmpB(n, n))
        allocate(invB(n, n))
        allocate(E(n, n))
        allocate(IPVT(n))
        allocate(WORK(n))
        allocate(tmpC(n))

        write(*,*)
        write(*, '("Matrix #", i1)') ndimi
        write(*,*)


        ! fill and print matrix
        do i = 1, n
            do j = 1, n
                B(i, j) = 1 / (p + i + j - 1)
            end do
            write(*, '('//j//'f8.4)') B(i, :)
        end do

        E = 0
        do i = 1, size(B,1)
            do j = 1, size(B,2)
                if(i == j) E(i, j) = 1.0
            end do
        end do
  
            
        tmpB = B
        call DECOMP(n, n, tmpB, cond, IPVT, WORK)

        write(*,*)
        write(*, '("cond = ", E12.5)') cond
        write(*,*)

            
        do i = 1, n
           do j = 1, n
              tmpC(j)=0d0
              if(j.eq.i) tmpC(j) = 1d0
           end do
           call SOLVE(n, n, tmpB, tmpC, IPVT)
           do j = 1, n
            invB(j, i) = tmpC(j)
           end do
        end do
        
        write(*,*) "B-1"
        do i = 1, n
            write(*, '('//n//'E14.4)') invB(i, :)
        end do
        
       
        tmpB = matmul(B, invB) - E
        
        write(*,*)
        write(*,'(A)') "R = B*B^-1 - E"
        do i = 1, n
            write(*, '('//n//'E14.3)') tmpB(i, :)
        end do
        write(*,*)

        tmpR = 0 
        do i=1,N
            do j=1,N
                tmpR = tmpR + (tmpB(i, j) ** 2)
            end do
        end do 

        R = sqrt(tmpR)
        
        write(*, '("Норма матрицы = ", E12.5)') R

                
        deallocate(B)
        deallocate(tmpB)
        deallocate(invB)
        deallocate(E)
        deallocate(IPVT)
        deallocate(WORK)
        deallocate(tmpC)
        write(*,*)
    end do

end program decompsolve
