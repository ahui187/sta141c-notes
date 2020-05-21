suppressPackageStartupMessages({
    library(pbdMPI)
})

init()
.comm.rank <- comm.rank()

B <- 10000
rs <- pbdSapply(seq_len(B), function(i) {
        n <- nrow(mtcars)
        index <- sample.int(n, n, replace = TRUE)
        x <- mtcars$mpg[index]
        y <- mtcars$hp[index]
        cor(x, y)
    },
    pbd.mode = "spmd")


rs <- allgather(rs, unlist = TRUE)

if (.comm.rank == 0) {
    answer <- quantile(rs, c(0.025, 0.975))
}

# it is important to not to put the comm.print inside the if statement,
# otherwise it will block the runtime
comm.print(answer)

### Finish.
finalize()
