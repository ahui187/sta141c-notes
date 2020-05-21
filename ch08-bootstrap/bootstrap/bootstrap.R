suppressPackageStartupMessages({
    library(pbdMPI)
})

init()
.comm.rank <- comm.rank()

B <- 10000
rs <- pbdLapply(seq_len(B), function(i) {
        n <- nrow(mtcars)
        index <- sample.int(n, n, replace = TRUE)
        x <- mtcars$mpg[index]
        y <- mtcars$hp[index]
        cor(x, y)
    },
    pbd.mode = "spmd")


rslist <- allgather(rs)

if (.comm.rank == 0) {
    answer <- quantile(unlist(rslist), c(0.025, 0.975))
}

# it is important to not to put the comm.print inside the if loop,
# otherwise it will block the runtime
comm.print(answer)

### Finish.
finalize()
