# proton game solution by Michal Mozdzonek

library(BetaBit)
library(dplyr)
# get John from employees
john <-  employees[which(employees$name=='John' & employees$surname == 'Insecure'),]

# login as John
proton(action= 'login', login=john$login)

# brutforce John password
for (pass in top1000passwords) 
  proton(action='login', login=john$login, password=pass)

# find Pietraszko in employees
pietraszko <-  employees[which(employees$surname == 'Pietraszko'),]

# pietraszko logins
logs %>%
filter( login == pietraszko$login) %>%
count(host) %>%
arrange(desc(n),) %>%
  # convert using as.character
  # factors are strange...
lapply(as.character) %>%
data.frame(stringsAsFactors = FALSE)-> host_counts

# Next proton step
proton(action = "server", host = as.character(host_counts[1,1]))

# Find password
hist <- data.frame(bsh=bash_history, stringsAsFactors = FALSE) %>%
  transmute(first_proc = sapply(strsplit(bsh," "), function(i) i[1])) %>%
  distinct()

pass <- "DHbb7QXppuHnaXGN"
proton(action = "login",login = pietraszko$login, password = pass)