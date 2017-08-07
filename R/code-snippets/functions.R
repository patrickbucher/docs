average <- function(...) {
    args = c(...)
    sum <- function(x) {
        s <- 0
        for (i in x) {
            s <- s + i
        }
        return(s)
    }
    return(sum(args) / length(args))
}
average(sample(1:10, replace = TRUE, 100))
