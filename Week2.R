library(data.table)
# Multivariate Regression
J_Multi <- function () {}
gradientDescentMulti <- function () {}
normalizeData <- function () {}

# data sets
Children <- data.table(
    age = c(4, 9, 5),
    height = c(89, 124, 103),
    weight = c(16, 28, 20)
)
Housing <- data.table(
    size = c(2104, 1416, 1534, 852),
    bedrooms = c(5, 3, 3, 2),
    floors = c(1, 2, 2, 1),
    age = c(45, 40, 30, 36),
    price = c(460, 232, 315, 178)
)
Exams <- data.table(
    midterm = c(89, 72, 94, 69),
    midterm_squared = c(7921, 5184, 8836, 4761),
    final = c(96, 74, 87, 78)
)


# Polynomial Regression

# Normal Equation
normal_equation <- function(X, y) {
    t_X = t(X)
    theta = as.matrix(t_X*X) * as.vector(t_X*y)
    return(theta)
}

solve_children <- function () {
    X <- cbind(rep(1,3), Children[,list(age,height)])
    y <- Children[, list(height)]
    normal_equation(X, y)
}
get_weightprediction <- function () {
    thetas <- solve_children()
    
    function (age, height) {
        thetas[1] + thetas[2]*age + thetas[3]*height
    }
}