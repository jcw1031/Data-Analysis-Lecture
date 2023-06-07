library(party)

str(iris)

iris

ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.7, 0.3))
trainData <- iris[ind == 1,]
testData <- iris[ind == 2,]

irisCtree <- ctree(Species ~ Sepal.Length +
  Sepal.Width +
  Petal.Length +
  Petal.Width, data = trainData)
print(irisCtree)

plot(irisCtree)

plot(irisCtree, type = "simple")

testPred <- predict(irisCtree, newdata = testData)
testPred

sum(testPred == testData$Species)/length(testPred)*100