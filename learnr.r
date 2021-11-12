# (Original file courtesy of https://learnxinyminutes.com/docs/r)

# Comments start with #.
# in Windows/Linux you can use CTRL-ENTER to execute a line.
# on Mac it is COMMAND-ENTER

#############################################################################
# Stuff you can do without understanding anything about programming
#############################################################################

# In this section, we show off some of the cool stuff you can do in
# R without understanding anything about programming. Do not worry
# about understanding everything the code does. Just enjoy!

data()	        # browse pre-loaded data sets
data(rivers)	# get this one: "Lengths of Major North American Rivers"
ls()	        # notice that "rivers" now appears in the workspace
head(rivers)	# peek at the data set

length(rivers)	# how many rivers were measured?

summary(rivers) # what are some summary statistics?

# make a histogram:
hist(rivers, col="#333333", border="white", breaks=25)

# Here's another neat data set that comes pre-loaded. R has tons of these.
data(discoveries)

discoveries

plot(discoveries, col="#333333", lwd=3, xlab="Year",
     main="Number of important discoveries per year")

help(plot)

plot(discoveries, col="#333333", lwd=3, type = "h", xlab="Year",
     main="Number of important discoveries per year")

max(discoveries)

summary(discoveries)

# Draw from a standard Gaussian 9 times
rnorm(9)

rnorm(100)

# Plot using function hist() to generate 
# an histogram
hist(rnorm(100))

# A function in another function?
hist(rnorm(1000))

##################################################
# Data types and basic arithmetic
##################################################

# Now for the programming-oriented part of the tutorial.
# In this section you will meet the important data types of R:
# integers, numerics, characters, logicals, and factors.
# There are others, but these are the bare minimum you need to
# get started.

# INTEGERS
class(5)

?class

# You can use scientific notation too
5e4

# BASIC ARITHMETIC
# You can do arithmetic with numbers
# Doing arithmetic on a mix of integers and numerics gives you another numeric
53.2 - 4  # 49.2    # numeric minus numeric gives numeric
2.0 * 2  # 4       # numeric times integer gives numeric
3 / 4    # 0.75    # integer over numeric gives numeric
3 %% 2	  # 1       # the remainder of two numerics is another numeric
# Illegal arithmetic yields you a "not-a-number":
0 / 0
class(NaN)

# CHARACTERS
"Horatio" 
class("Horatio") 

# LOGICALS
# In R, a "logical" is a boolean
class(TRUE)
class(FALSE)

TRUE == TRUE
TRUE == FALSE	
FALSE != FALSE
FALSE != TRUE
# Missing data (NA) is logical, too
class(NA)
# Use | and & for logic operations.
# OR
TRUE | FALSE
# AND
TRUE & FALSE

# TYPE COERCION
# Type-coercion is when you force a value to take on a different type
as.character(6)
as.logical(1)

# Also note: those were just the basic data types
# There are many more data types, such as for dates, time series, etc.

##################################################
# Variables, loops, if/else
##################################################

# A variable is like a box you store a value in for later use.
# We call this "assigning" the value to the variable.

# VARIABLES
# Lots of way to assign stuff:
x = 5 # this is possible
y <- "1" # this is preferred
TRUE -> z # this works but is weird

# FUNCTIONS
# Defined like so:
sum_two_numbers <- function(a, b) {
	s <- a + b
	return(s)
}
# Called like any other R function:
sum_two_numbers(4, 10)

###########################################################################
# Data structures: Vectors, matrices, data frames, and arrays
###########################################################################

# ONE-DIMENSIONAL

# Let's start from the very beginning: vectors.
vec <- c(8, 9, 10, 11)
vec
# We ask for specific elements by subsetting with square brackets
# (Note that R starts counting from 1)
vec[1]
c(6, 8, 7, 5, 3, 0, 9)[3]

# We can also search for the indices of specific components,
which(vec %% 2 == 0)	

# or figure out if a certain value is in the vector
any(vec == 10)

# If an index "goes over" you'll get NA:
vec[6]

# You can find the length of your vector with length()
length(vec)
# You can perform operations on entire vectors or subsets of vectors
vec * 4
vec[2:3] * 5
any(vec[2:3] == 8)
# and R has many built-in functions to summarize vectors
mean(vec)
var(vec)
sd(vec)
max(vec)
min(vec)
sum(vec)

# Some more nice built-ins:
5:15
seq(from=0, to=31337, by=1337)

# If you put elements of different types into a vector, weird coercions happen:
c(TRUE, 4)
c("dog", TRUE, 4)
as.numeric("Bilbo")

# TWO-DIMENSIONAL (ALL ONE CLASS)
# You can make a matrix out of entries all of the same type like so:
mat <- matrix(nrow = 3, ncol = 2, c(1,2,3,4,5,6))
mat
# Unlike a vector, the class of a matrix is "matrix", no matter what's in it
class(mat)
# Ask for the first row
mat[1,]
# Perform operation on the first column
3 * mat[,1]
# Ask for a specific cell
mat[3,2]

# Transpose the whole matrix
t(mat)

# TWO-DIMENSIONAL (DIFFERENT CLASSES)
# For columns of different types, use a data frame
# This data structure is so useful for statistical programming

students <- data.frame(c("Cedric","Fred","George","Cho","Draco","Ginny"),
                       c(3,2,2,1,0,-1),
                       c("H", "G", "G", "R", "S", "G"))
names(students) <- c("name", "year", "house")
class(students)
students

class(students[,3])

# The data.frame() function converts character vectors to factor vectors
?data.frame

# There are many twisty ways to subset data frames, all subtly unalike
students$year
students[,2]
students[,"year"]

#########################
# Loading data
#########################

# "pets.csv" is a file on the internet
# (but it could just as easily be a file on your own computer)
sim_out <- read.csv("~/projects/sm4a/GenericModelOutputs.csv")
sim_out
head(sim_out, 2) # first two rows
tail(sim_out, 1) # last row
str(sim_out) # data.frame structure

# To save a data frame or matrix as a .csv file
write.csv(sim_out, "sim_out.csv") # to make a new .csv file
# set working directory with setwd(), look it up with getwd()
getwd()
setwd("~/projects/sm4a")

#########################
# Statistical Analysis
#########################
# Linear regression!
data(mtcars)
mtcars
linear_model <- lm(mpg  ~ disp, data = mtcars)
linear_model # outputs result of regression

summary(linear_model) # more verbose output from the regression

coef(linear_model) # extract estimated parameters

summary(linear_model)$coefficients # another way to extract results

summary(linear_model)$coefficients[,4] # the p-values 

# Making an ANOVA has never been so easy
anova(linear_model)

#########################
# Plots
#########################
# BUILT-IN PLOTTING FUNCTIONS
# Scatterplots!
plot(mtcars$mpg, mtcars$disp, main = "Miles/(US) gallon vs Displacement (cu.in.)")
# Plot regression line on existing plot
abline(linear_model, col = "red")
# Get a variety of nice diagnostics
plot(linear_model)
# Histograms!
hist(rpois(n = 10000, lambda = 5), col = "thistle")
# Barplots!
barplot(c(1,4,5,1,2), names.arg = c("red","blue","purple","green","yellow"))

# the "tidyverse" tools for tidy data manipulation
install.packages("tidyverse")
# contains library(dplyr)
library(tidyverse)

# piping is better than nesting
# writing
function_c(function_b(function_a()))

# is the same as
function_a() %>% 
  function_b() %>% 
  function_c()
# but much less ugly!

# Filtering data
starwars %>% 
  filter(species == "Droid")

# Selecting specific columns
starwars %>% 
  select(name, ends_with("color"))

# Modify/Create columns
  starwars %>% 
    mutate(bmi = mass / ((height / 100)  ^ 2)) %>%
    select(name:mass, bmi)
  
# All together
starwars %>% 
  filter(species == "Droid") %>% 
  mutate(bmi = mass / ((height / 100)  ^ 2)) %>% 
  select(name:mass, bmi)
  
# Summarise data
starwars %>%
  group_by(species) %>%
  summarise(
    n = n(),
    mass = mean(mass, na.rm = TRUE)
  )
# GGPLOT2
# But these are not even the prettiest of R's plots
# Try the ggplot2 package for more and better graphics
install.packages("ggplot2")
library(ggplot2)
# ggplot2 has excellent documentation (available http://docs.ggplot2.org/current/)

my_plot <- 
  ggplot(mtcars) +
  aes(mpg, disp) +
  geom_point()

my_plot

my_plot +
  geom_smooth()

my_plot +
  geom_smooth(method = "lm")

ggplot(mtcars) +
  aes(cyl, mpg) +
  geom_boxplot() #???


my_boxplot <- 
  ggplot(mtcars) +
  aes(factor(cyl), mpg) +
  geom_boxplot()
my_boxplot

my_boxplot +
  geom_point()

my_boxplot +
  geom_jitter()

my_boxplot +
  geom_jitter(aes(col = disp))