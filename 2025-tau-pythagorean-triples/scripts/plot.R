library(dplyr)
library(readr)
library(ggplot2)
library(tidyr)
path <- "~/localsrc/conjure-bits/2025-tau-pythagorean-triples/data.csv"
data <- read_csv(path) %>% 
  tidyr::unite('group',model,command,remove=FALSE)

data <- data %>% 
  rename(`Model` = `model`) %>%
  rename(`Program`=`command`) %>%
  mutate(`Model` = case_when(`Model` == "in_return_expression" ~ "Dynamic Guard",
                             `Model` == "inside_comprehension" ~ "Static Guard")) %>%
  mutate(`Program`=case_when(`Program` == "conjureoxide" ~ "Conjure Oxide",
                             `Program` == "savilerow" ~ "Savile Row (-O0)"))



ggplot(data) + 
  aes(x=`n`, y=`mean`,group=`group`,color=`Program`,linetype=`Model`) + 
  geom_path() + 
  geom_point() + 
  xlab('n') + 
  ylab('Mean time (s)') + 
  ggtitle('Boolean Pythagorean Triples Problem: Time to First Solution')  + 
  theme_minimal()

ggplot(data) + 
  aes(x=`n`, y=log(`mean`,10),group=`group`,color=`Program`,linetype=`Model`) + 
  geom_path() + 
  geom_point() + 
  xlab('n') + 
  ylab('Log Mean time (s)') + 
  ggtitle('Boolean Pythagorean Triples Problem: Time to First Solution')  + 
  theme_minimal()

ggplot(data) + 
  aes(x=`n`, y=log(`mean`,10),group=`Program`,color=`Program`) + 
  geom_path() + 
  geom_point() + 
  xlab('n') + 
  ylab('Log mean time (s)') + 
  ggtitle('Boolean Pythagorean Triples Problem: Time to First Solution') + facet_wrap(~Model) + theme_linedraw()

ggplot(data) + 
  aes(x=`n`, y=log(`mean`,10),group=`Model`,color=`Program`,linetype=`Model`) + 
  geom_path() + 
  geom_point() + 
  xlab('n') + 
  ylab('Log mean time (s)') + 
  ggtitle('Boolean Pythagorean Triples Problem: Time to First Solution') + facet_wrap(~Program) + theme_linedraw()

