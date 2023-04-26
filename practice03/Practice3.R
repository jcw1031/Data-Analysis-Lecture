install.packages('arules')
library('arules')
data()

# 데이터 로딩
## read.transactions(): 파일로부터 트랜잭션 형태로 데이터를 로딩하는 함수 [default parameters: minsup = 0.1 / minconf = 0.8]
groceries <- read.transactions(file = "/Users/jcw/Develop/DataAnalysisLecture/practice03/data/groceries.csv",
                               format = "basket", sep = ",")
inspect(groceries)

## apriori(): apriori 알고리즘이 구현되어 있는 함수
rules.all <- apriori(groceries)
rules.all

inspect(rules.all)

## LHS(left-hands side) 값이 없는 규칙들 -> minlen = 2로 설정
## 흥미가 떨어지는 규칙들 -> supp = 0.3, conf = 0.9로 설정
## 출력이 너무 많아 확인이 어려움 -> 진행 과정 정보 생략하기: verbose = F
rules <- apriori(groceries, control = list(verbose = F), parameter = list(minlen = 2, supp = 0.3, conf = 0.9))
rules

