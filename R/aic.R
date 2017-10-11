#' Computes AIC or AICc
#'
#' Computes the AIC of a model. When the number of parameters is
#' large relatively to the number of observations, we apply the second-order
#' bias correction for small samples. Threshold definition is based on
#' recommendations from Burnham & Anderson (2002, 2004).
#'
#' @param mod A fitted model of class lm or merMod.
#'
#' @importFrom stats logLik nobs
#'
#' @examples
#' library(ESTER)
#' data(mtcars)
#' mod1 <- lm(mpg ~ cyl, mtcars)
#' aic(mod1)
#'
#' @references Burnham, K. P., \& Anderson, D. R. (2002). Model Selection and Multimodel Inference: A Practical Information-Theoretical Approach. 2d ed. New York: Springer-Verlag.
#'
#' @references Burnham, K. P., \& Anderson, D. R. (2004). Multimodel inference: Understanding AIC and BIC in model selection. Sociological Methods and Research, 33(2), 261-304.
#'
#' @export

aic <- function(mod) {

    n <- nobs(mod)
    ll <- logLik(mod)[1]
    k <- attr(logLik(mod), "df")

    if (n / k > 40) {

        aic <- -2 * ll + 2 * k

    } else {

        aic <- -2 * ll + 2 * k * (n / (n - k - 1) )
    }

    aic[2] <- k

    return(aic)

}