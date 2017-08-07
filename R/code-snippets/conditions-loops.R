print("CC: CrappyCalculator")
repeat {
    i <- trimws(readline("Enter '+' for addition or 'q' to quit: "))
    if (i == "q") {
        break
    }
    if (i != "+") {
        next
    }
    a <- as.numeric(readline("Enter a number: "))
    b <- as.numeric(readline("Enter another number: "))
    print(paste(a, "+", b, "is", a + b))
}
