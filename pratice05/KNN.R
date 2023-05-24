library(textir)
library(MASS)

data(fgl)
fgl
str(fgl)

n <- length(fgl$type)
nt <- 200
train <- sample(1:n, nt)
train

x <- fgl[, c(4, 1)]

library(class)

nearest1 <- knn(train = x[train,], test = x[-train,], cl = fgl$type[train], k = 1)
nearest5 <- knn(train = x[train,], test = x[-train,], cl = fgl$type[train], k = 5)

data.frame(fgl$type[-train], nearest1, nearest5)

par(mfrow = c(1, 2))
plot(x[train,], col = fgl$type[train], cex = .8, main = "1-nearest neighbor")
points(x[-train,], bg = nearest1, pch = 21, col = grey(.9), cex = 1.25)
plot(x[train,], col = fgl$type[train], cex = .8, main = "5-nearest neighbor")
points(x[-train,], bg = nearest5, pch = 21, col = grey(.9), cex = 1.25)
legend("topright", legend = levels(fgl$type), fill = 1:6, bty = "n", cex = .75)

pcorrn1 <- 100*sum(fgl$type[-train] == nearest1)/(n - nt)
pcorrn5 <- 100*sum(fgl$type[-train] == nearest5)/(n - nt)

pcorrn1
pcorrn5