FC=gfortran-9
FFLAGS=-Wall -Wno-maybe-uninitialized -Wno-unused-function -static-libgfortran -flto
FOPT=-O3 -ftree-vectorize -fopt-info-vec

all:
	$(FC) $(FFLAGS) $(FOPT) -c src/DECOMP.F -J obj/ -o obj/DECOMP.o
	$(FC) $(FFLAGS) $(FOPT) -c src/FEHL.F -J obj/ -o obj/FEHL.o
	$(FC) $(FFLAGS) $(FOPT) -c src/QUANC8.F -J obj/ -o obj/QUANC8.o
	$(FC) $(FFLAGS) $(FOPT) -c src/RKFS.F -J obj/ -o obj/RKFS.o
	$(FC) $(FFLAGS) $(FOPT) -c src/SOLVE.F -J obj/ -o obj/SOLVE.o
	$(FC) $(FFLAGS) $(FOPT) -c src/SVD.F -J obj/ -o obj/SVD.o
	$(FC) $(FFLAGS) $(FOPT) -c src/ZEROIN.F -J obj/ -o obj/ZEROIN.o
	$(FC) $(FFLAGS) $(FOPT) -c src/FMIN.F -J obj/ -o obj/FMIN.o
	$(FC) $(FFLAGS) $(FOPT) -c src/RKF45.F -J obj/ -o obj/RKF45.o
	$(FC) $(FFLAGS) $(FOPT) -c src/SEVAL.F -J obj/ -o obj/SEVAL.o
	$(FC) $(FFLAGS) $(FOPT) -c src/SPLINE.F -J obj/ -o obj/SPLINE.o
	$(FC) $(FFLAGS) $(FOPT) -c src/URAND.F -J obj/ -o obj/URAND.o
	$(FC) $(FFLAGS) -c src/environment.f90 -J obj/ -o obj/environment.o
	
	$(FC) $(FFLAGS) $(FOPT) -c src/spline.f90 -I obj/ -o obj/spline.o

	$(FC) $(FFLAGS) $(FOPT) -o bin/app obj/spline.o ./obj/environment.o obj/DECOMP.o obj/FEHL.o obj/QUANC8.o obj/RKFS.o obj/SOLVE.o obj/SVD.o obj/ZEROIN.o obj/FMIN.o obj/RKF45.o obj/SEVAL.o obj/SPLINE.o obj/URAND.o

clean:
	rm -rf obj/*
	rm -rf bin/*

run:
	cd ./bin; ./app;
