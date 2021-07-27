# Miscelleaneous

## The Environment

Set a custom prompt (`R> `):

```R
options(prompt = "R> ")
```

List variables, objects and user-defined functions of the current session:

```R
ls()
```

Remove an item from the current session:

```R
ls() # nothing
foo <- "bar"
ls() # "foo"

rm(foo)
ls() # nothing
```

Empty the current session:

```R
rm(list = ls())
```

Leave R:

```R
q()
```

## Scoping

List environments:

```R
search() # ".GlobalEnv" "tools:rstudio" ... "package:base"
```

When refering to a symbol (a variable, object, functin etc.), R searches through
the environments listed by `search()` from left to right.

Determine the environment in which an object lives:

```R
environment(seq) # <environment: namespace:base>
environment(plot) # <environment: namespace:graphics>
```

List the content of an environment:

```R
ls("package:graphics")
```

When a package is no longer used, it can be detached in order to clean up the
namespace:

```R
search() # ".GlobalEnv" "package:stats" "package:graphics" etc.
library("MASS")
search() # ".GlobalEnv" "package:MASS" "package:stats" etc.
detach("package:MASS", detach = TRUE)
search() # ".GlobalEnv" "package:stats" "package:graphics" etc.
```

For easier lookup, objects can be attached:

```R
person <- data.frame(name = "Patrick", age = 30)
person.name # "Patrick"
person.age # 30

name # Error: object 'name' not found
age # Error: object 'age' not found

attach(person)
name # "Patrick"
age # 30

detach(person)
name # Error: object 'name' not found
age # Error: object 'age' not found
```

In order to keep the namespace clean, attaching objects to the namespace
("mounting") should be avoided.

## Sessions

Find out and set the current working directory:

```R
getwd()
setwd("~/my-workspace")
```

Save the current session:

```R
save.image("my-session.RData")
```

Load a stored session:

```R
load("my-session.RData")
```

## Packages

Install a new package (`MASS`, for example):
    
```R
install.packages("MASS")
```

List installed packages:

```R
installed.packages()
```

Load the installed `MASS` library:

```R
library("MASS")
```

Update installed packages:

```R
update.packages()
```

Uninstall a package (using default library paths):

```R
remove.packages("MASS", .libPaths())
```

## Help

Get help for a specific keyword (the `mean` function, for example):

```R
help("mean")
?mean # shortcut
```

Search for a help topic (`random`, for example):

```R
help.search("random")
??"random" # shortcut
```

## Working with Files

### Reading Text Files

Sample file (`table.txt`):

    species mammal legs area
    cow TRUE 4 land
    spider FALSE  8 land
    whale TRUE N/A sea
    bird TRUE 2 air

Read tabular data from a file (`table.txt`):

    animals <- read.table(file = "table.txt", header = TRUE, sep = " ",
        na.strings = "N/A", stringsAsFactors = FALSE)

Parameters:

- `file`: the (absolute or relative) file name
- `header`: whether or not the first line should be read as a header
- `sep`: the seperator (here: one space, use `""` for any amount of whitespace)
- `na.strings`: define which strings (either a single string or a vector of
  strings) should be recognized as `NA` values
- `stringsAsFactors`: whether or not string columns should be interpreted as
  factors (same parameter as for `data.frame`)

If _some_ of the non-numeric columns should be interpreted as factors, simply
overwrite them, providing optional levels (in case some possible values are
missing in the data set):

    animals$area = factor(animals$area)
    animals$area = factor(animals$area, levels = c("air", "land", "sea")

Either use an absolute file path or make sure to change your working directory:

    getwd() # "C:/Users/patrick.bucher/Documents/R"
    setwd("tables") # relative path (absolute paths are also possible)
    getwd() # "C:/Users/patrick.bucher/Documents/R/tables"

List all files in the current working directory (for more information type
`?list.files` and `?list.dirs`):

    list.files()

Files can also be choosen interactively, returning the absolute path of the file
selected:

    myFile <- file.choose()

Files can also be read directly from the web:

    forbes500 <- read.table(file = "http://forbes.com/assets/filthy-rich-people.txt")

### Reading CSV Files

Sample file (`table.csv`):

    species,mammal,legs,area
    cow,TRUE,4,land
    wolf spider,FALSE,8,land
    whale,TRUE,N/A,sea
    guinea pig,TRUE,4,land
    
Read the data from a CSV file (with the comma as the default seperator):

    animals <- read.csv(file = "table.csv", header = TRUE,
        stringsAsFactors = TRUE)

CSV files often use the semicolon (`;`) or the tab (`\t`) as the seperator
value, so make sure to define the `sep` parameter accordingly:

    animals <- read.csv(file = "table.csv", header = TRUE,
        stringsAsFactors = TRUE, sep = ';')

### Writing Files

Sample data frame:

    names <- c("Sepp", "Max", "Uschi")
    sex <- factor("M", "M", "F")
    age <- c(42, 50, 61)
    people <- data.frame(person = names, sex = sex, age = age)

Write the data frame to a tabular text file:

    write.table(x = people, file = "people.txt")

Write the data frame to a CSV file:

    write.csv(x = people, file = "people.csv", row.names = TRUE)

The argument `row.names` adds an unnamed column with a row counter to the
output.

Store any single object in a file:

    m <- matrix(1:64, ncol = 8) # 8x8 matrix
    dput(x = m, file = "matrix.txt")

Retreive a formerly stored object from a file:

    m <- dget(file = "matrix.txt")

## Timing

Pause the program execution for a given amount of time (in seconds):

```R
for (i in 1:10) {
    print(i)
    Sys.sleep(0.5)
}
```

Display a textual progress bar:

```R
from <- 1
to <- 10
prog <- txtProgressBar(min = from, max = to, char = "#", style = 3)
cat("counting from", from, "to", to, "\n")
for (i in from:to) {
    setTxtProgressBar(prog, value = i)
    Sys.sleep(0.5)
}
close(prog)
```

Get the current date and time:

```R
Sys.time() # returns current date time
Sys.Date() # returns current date
```

Format date and time:

```R
format(Sys.time(), "%d.%m.%Y %H:%M") # 30.07.2017 17:41
format(Sys.time(), "%s") # 1501429298, UNIX timestamp
```

Measure execution time (difference between two times):

```R
start <- Sys.time()
Sys.sleep(1.23)
end <- Sys.time()
diff <- end - start # diff is of type "difftime"
as.numeric(diff, units = "secs") # time difference in seconds, around 1.23
```

Measure duration of a function call (similar to the UNIX command `time`):

```R
system.time(sqrt(mean(1:1e9)))
```

Output:

     user  system elapsed
    1.504   0.233   1.738

