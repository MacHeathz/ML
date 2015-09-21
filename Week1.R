## Univariate Linear Regression with Gradient Descent

# Some datasets to test.
test1 <- data.frame(
    x = c(0,1,2,3),
    y = c(4,7,7,8)
)

#  The h(x) function to fit is 0 + 0.5x
student_grades <- data.frame(
            x = c(1, 2, 4, 0, 16, 24),
            y = c(0.5, 1, 2, 0, 8, 12)
         )

# Linear Regression Model, hypothesis function
h <- function (t0, t1, x) {
    t0 + (t1 * x)
}

# Cost function
J <- function (dataset) {
    m <- nrow(dataset)
    errors <- dataset$error
    1/(2*m) * sum(errors^2)
}
determine_errors <- function (t0, t1, data_set) {
    predictors <- data_set[,1]
    predictions <- h(t0, t1, data_set[,1])
    answers <- data_set[,2]
    errors <- apply(cbind(predictions, answers), 1, function(row) { row[1] - row[2] })
    data.frame(predictor = predictors,
                     prediction = predictions,
                     answer = answers,
                     error = errors
                    )
}

# Gradient Descent: finds the ultimate theta parameters for given dataset
update_theta <- function (j, alpha, slope) {
    j <- j - alpha * slope
}
determine_slope <- function (error_data, use_x = FALSE) {
    m <- nrow(error_data)
    1/m * sum(apply(error_data, 1, function (row) {
        error <- row["error"]
        x <- row["predictor"]
        if (use_x) return(error*x)
        else return(error)
    }))
}
gradient_descent <- function (data_set, learning_rate = 0.01) {
    # start with params = 0
    alpha <- learning_rate
    t0 <- 0
    t1 <- 0
    SSE <- Inf
    iterations <- 0

    repeat {
        error_data <- determine_errors(t0, t1, data_set)
        
        new_SSE <- J(error_data)
        
        if (new_SSE >= SSE || abs(SSE - new_SSE) < 1e-15) { break }
        else { SSE = new_SSE }
        
        slope_t0 <- determine_slope(error_data)
        slope_t1 <- determine_slope(error_data, TRUE)
        
        t0 <- update_theta(t0, alpha, slope_t0)
        t1 <- update_theta(t1, alpha, slope_t1)
        
        iterations <- iterations + 1
    }
    
    list(t0 = t0, t1 = t1, SSE = SSE, iterations = iterations, learning_rate = alpha)
}