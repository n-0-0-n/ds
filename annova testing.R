mistime2 <- read.csv(file.choose(),header = T)
var.test(mistime2$Time_G1,mistime2$Time_G2,alternative= "two.sided")


satlevel <- read.csv(file.choose(),header = T)
anovatable <- aov(formula = satindex~dept,data=satlevel)
summary(anovatable)

satlevel <- read.csv(file.choose(),header = T)
anovatable <- aov(formula = satindex~dept + exp + dept * exp,data = satlevel)
summary(anovatable)