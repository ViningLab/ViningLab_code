library("mixtools")

###### Section 2:  EM Algorithms for Finite Mixtures

attach(faithful)
wait1 <- normalmixEM(waiting, lambda = .5, mu = c(55, 80), sigma = 5)

plot(wait1, density = TRUE, cex.axis = 1.4, cex.lab = 1.4, cex.main = 1.8,
     main2 = "Time between Old Faithful eruptions", xlab2 = "Minutes")

wait1[c("lambda", "mu", "sigma")]

summary(wait1)

###### Section 3:  Cutpoint Methods

data("Waterdata")
cutpts <- 10.5 *(-6:6)
watermult <- makemultdata (Waterdata, cuts = cutpts)

set.seed(15)
theta4 <- matrix(runif(56), ncol=14)
theta3 <- theta4[1:3,]
mult3 <- multmixEM (watermult, lambda=rep (1, 3) / 3, theta = theta3)

cdf3 <- compCDF(Waterdata, mult3$posterior, lwd=2, lab=c(7, 5, 7),
  xlab="Angle in degrees",  ylab="Component CDFs",
  main="Three-Component Solution")
mult4 <- multmixEM (watermult, lambda=rep (1, 4) / 4, theta = theta4)

cdf4 <- compCDF(Waterdata, mult4$posterior, lwd=2, lab=c(7, 5, 7),
  xlab="Angle in degrees", ylab="Component CDFs", 
  main="Four-Component Solution")

summary(mult4)

###### Section 4:  Nonparametric and Semiparametric Methods

plot(wait1, which = 2, cex.axis = 1.4, cex.lab = 1.4, cex.main = 1.8,
  main2 = "Time between Old Faithful eruptions", xlab2 = "Minutes")
wait2 <- spEMsymloc(waiting, mu0 = c(55, 80))
plot(wait2, lty = 2, newplot = FALSE, addlegend = FALSE)

bw.nrd0(waiting)

wait2a <- spEMsymloc(waiting, mu0 = c(55, 80), bw = 1)
wait2b <- spEMsymloc(waiting, mu0 = c(55, 80), bw = 6)
plot(wait2a, lty = 1, addlegend = FALSE, cex.axis = 1.4,
  cex.lab = 1.4, cex.main = 1.8, xlab = "Minutes",
  title = "Time between Old Faithful eruptions")
plot(wait2b, lty = 2, newplot = FALSE, addlegend = FALSE)

m = 2; r = 3; n = 300; S = 100
lambda <- c(0.4, 0.6)
mu <- matrix(c(0, 0, 0, 3, 4, 5), m, r, byrow = TRUE)
sigma <- matrix(rep(1, 6), m, r, byrow = TRUE)

centers <- matrix(c(0, 0, 0, 4, 4, 4), 2, 3, byrow = TRUE)
ISE <- matrix(0, m, r, dimnames = list(Components = 1:m, Blocks = 1:r))
nblabsw <- 0

for (mc in 1:S) {
  x <- rmvnormmix(n, lambda, mu, sigma)
  a <- npEM(x, centers, verb = FALSE, samebw = FALSE)
  if (a$lambda[1] > a$lambda[2]) nblabsw <- nblabsw + 1
  for (j in 1:m) {
    for (k in 1:r) {
      ISE[j, k] <- ISE[j, k] + ise.npEM(a, j, k, dnorm,
         lower = mu[j, k] - 5, upper = mu[j, k] + 5, plots = FALSE,
         mean = mu[j, k], sd = sigma[j, k])$value
    }
  }
}
MISE <- ISE/S
print(sqMISE <- sqrt(MISE))

summary(a)

plot(a)

m <- 2; r <- 5
lambda <- c(0.4, 0.6)
df <- c(2, 10); ncp <- c(0, 8)
sh1 <- c(1, 1) ; sh2 <- c(1, 5)

n <- 300; z <- sample(m, n, rep = TRUE, prob = lambda)
r1 <- 3; z2 <- rep(z, r1)
x1 <- matrix(rt(n * r1, df[z2], ncp[z2]), n, r1)
r2 <- 2; z2 <- rep(z, r2)
x2 <- matrix(rbeta(n * r2, sh1[z2], sh2[z2]), n, r2)
x <- cbind(x1, x2)

id <- c(rep(1, r1), rep(2, r2))
centers <- matrix(c(0, 0, 0, 1/2, 1/2, 4, 4, 4, 1/2, 1/2), m, r, 
  byrow = TRUE)
b <- npEM(x, centers, id, eps = 1e-8, verb = FALSE, samebw = FALSE)

plot(b, breaks = 15)

par(mfrow = c(2, 2))
for (j in 1:2){
  ise.npEM(b, j, 1, truepdf = dt, lower = ncp[j] - 10,
    upper = ncp[j] + 10, df = df[j], ncp = ncp[j])
  ise.npEM(b, j, 2, truepdf = dbeta, lower = -0.5,
    upper = 1.5,  shape1 = sh1[j], shape2 = sh2[j])
}

###### Section 5:  Mixtures of Regressions

data("CO2data")
attach(CO2data)
CO2reg <- regmixEM(CO2, GNP, lambda = c(1, 3) / 4,
  beta = matrix(c(8, -1, 1, 1), 2, 2), sigma = c(2, 1))

summary(CO2reg)

plot(CO2reg, density = TRUE, alpha = 0.01)

CO2igle <- regmixEM.loc(CO2, GNP, beta = CO2reg$beta, sigma = CO2reg$sigma,
  lambda = matrix(.5, 28, 2), kern.l = "Beta", kernl.h = 20, kernl.g = 3)

summary(CO2igle)

plot(GNP, CO2igle$post[,1], xlab = "GNP", 
  ylab = "Final posterior probabilities")
lines(sort(GNP), CO2igle$lambda[order(GNP), 1], col=2)
abline(h = CO2igle$lambda[1], lty = 2)

set.seed(123)
CO2boot <- boot.se(CO2reg, B = 100)

rbind(range(CO2boot$beta[1,]), range(CO2boot$beta[2,]))

CO2boot[c("lambda.se", "beta.se", "sigma.se")]

###### Section 6:  Additional Capabilities of Mixtools

set.seed(10)
multmixmodel.sel(watermult, comps = 1:4, epsilon = 0.001)




