install.packages('arules')
library('arules')
data()

# 데이터 로딩

## read.transactions(): 파일로부터 트랜잭션 형태로 데이터를 로딩하는 함수
## inspect(): 트랜잭션 데이터의 내용을 출력하는 함수
groceries <- read.transactions(file = "/Users/jcw/Develop/DataAnalysisLecture/practice03/data/groceries.csv",
                               format = "basket", sep = ",")
inspect(groceries)

# 연관 분석 실행

## apriori(): apriori 알고리즘이 구현되어 있는 함수 [default parameters: minsup = 0.1 / minconf = 0.8]
rules.all <- apriori(groceries)
rules.all

## 발견된 모든 룰 출력
inspect(rules.all)

# 룰 정제

## lhs(left-hands side) 값이 없는 규칙들 -> minlen = 2로 설정
## 흥미가 떨어지는 규칙들 -> supp = 0.3, conf = 0.9로 설정
## 출력이 너무 많아 확인이 어려움 -> 진행 과정 정보 생략하기: verbose = F
rules <- apriori(groceries, control = list(verbose = F), parameter = list(minlen = 2, supp = 0.3, conf = 0.9))
rules

# 결과 정렬

## quality(): apriori()의 결과에서 measure를 추출하는 함수
## round(): 실수 데이터를 digits 크기의 자리에서 반올림하는 함수
quality(rules) <- round(quality(rules), digits = 3)
## sort(): 데이터를 by 기준으로 정렬하는 함수
rules.sorted <- sort(rules, by = "confidence")
inspect(rules.sorted)

# 결과 분석

## supp = 0.3, conf = 0.9일 때, 47개의 규칙이 발견
### 하지만 모든 규칙의 rhs는 shopping bags로 나타남 -> shopping bags가 대부분의 트랜잭션에서 나타나기 때문이다. (Confidence의 한계점과 연관)
## -> 따라서 lift를 중심으로 마이닝 => parameter를 supp = 0.2, conf = 0.8로 설정
rules <- apriori(groceries, control = list(verbose = F), parameter = list(minlen = 2, supp = 0.2, conf = 0.8))
rules
quality(rules) <- round(quality(rules), digits = 3)
rules.sorted <- sort(rules, by = "lift")
inspect(rules.sorted)

# 특정 데이터를 제외한 연관 규칙 마이닝

## shopping bags는 다른 데이터와 독립적이므로 연관 규칙에서 제외 -> none = "shopping bags" 설정
rules <- apriori(groceries, control = list(verbose = F), parameter = list(minlen = 2, supp = 0.1, conf = 0.8),
                 appearance = list(none = "shopping bags"))
quality(rules) <- round(quality(rules), digits = 3)
rules.sorted <- sort(rules, by = "lift")
inspect(rules.sorted)