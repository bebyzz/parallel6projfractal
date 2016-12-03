make:
	export LD_LIBRARY_PATH=/usr/local/cuda-5.5/lib64/
	g++ -march=native -O3 -fopenmp -c fractal_hyb1.cpp -o Cfractal.o 
	nvcc -O3 -arch=sm_20 -c fractal_hyb1.cu -o CUfractal.o
	g++ -march=native -O3 -fopenmp Cfractal.o CUfractal.o -lcudart \
     -L /usr/local/cuda/lib64/ -o fractal_hyb1

smake:
	module load cuda
	icc -xhost -openmp -O3 -c fractal_hyb1.cpp -o Cfractal.o 
	nvcc -O3 -arch=sm_35 -c fractal_hyb1.cu -o CUfractal.o icc -xhost -openmp -O3 Cfractal.o CUfractal.o -lcudart \
     -L$TACC_CUDA_LIB -o fractal_hyb1

gif:
	convert -delay 1x30 fractal1*.bmp fractal.gif

test:
	diff fractal.gif /home/Students/yyz1/cs/4380burtcher/testfiles/fractal.gif

clean:
	rm fractal*.bmp
