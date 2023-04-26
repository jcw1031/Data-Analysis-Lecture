# 데이터 로딩

load("/Users/jcw/Develop/DataAnalysisLecture/practice03/data/titanic.raw.rdata")

# 데이터 확인

## 데이터 구조
str(titanic.raw)
head(titanic.raw)
summary(titanic.raw)

# 연관 분석 실행

## Titanic 데이터에 apriori() 함수 적용 [defalut parameters: minsup = 0.1 / minconf = 0.8]
rules.all <- apriori(titanic.raw)
rules.all
inspect(rules.all)

# 룰의 정제 및 결과의 정렬

## 발견된 규칙 중, 의미가 없는 결과들이 많이 포함됨
### Titanic 데이터에서는 생사 여부에 대한 rule이 가장 의미 있음 -> rhs(right-hands side) = c("Survived=No", "Survived=Yes") 설정
### lhs에는 다른 모든 속성이 포함될 수 있음 -> default = "lhs" 설정
### lhs 값이 비어있는 rule이 나타남 -> minlen = 2 설정

## 출력이 너무 많아 확인이 어려움 -> 진행 과정 정보 생략하기: verbose = F
rules <- apriori(titanic.raw, control = list(verbose = F), parameter = list(minlen = 2, supp = 0.005, conf = 0.8),
                 appearance = list(rhs = c("Survived=No", "Survived=Yes"), default = "lhs"))
## round() 함수를 통해 support, confidence, lift 값을 반올림
quality(rules) <- round(quality(rules), digits = 3)
## sort() 함수를 통해 lift를 기준으로 내림차순 정렬
rules.sorted <- sort(rules, by = "lift")

inspect(rules.sorted)

# 결과 분석

## 높은 lift의 rule을 찾기는 쉽지만 rule을 이해하기는 어려움
## 실제로 연관 규칙을 잘못 이해하는 경우가 많기 때문에 파악하고자 하는 대상을 명확히 하는 것이 필요 -> 각 class와 나이에 따른 사망 여부에 대한 마이닝 진행
rules <- apriori(titanic.raw, parameter = list(minlen = 3, supp = 0.002, conf = 0.2),
                 appearance = list(
                   rhs = "Survived=No",
                   lhs = c("Class=1st", "Class=2nd", "Class=3rd", "Age=Child", "Age=Adult"),
                   default = "none"
                 ), control = list(verbose = F))
rules.sorted <- sort(rules, by = "confidence")
inspect(rules.sorted)