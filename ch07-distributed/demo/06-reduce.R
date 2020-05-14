# module load R
# srun -p high2 -t 1 -n 4 Rscript 06-reduce.R

suppressPackageStartupMessages({
    library(pbdMPI)
})

init()
.comm.size <- comm.size()
.comm.rank <- comm.rank()

### Examples.
x <- .comm.rank + 1
comm.cat("x =", x, "\n", all.rank = TRUE)

y <- reduce(x, op = "sum")  # only rank 0 receives the sum
comm.cat("y is ", y, "\n", all.rank = TRUE)

### Finish.
finalize()
