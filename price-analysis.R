#Loading Required Libraries
library(readxl)
library(car)
library(dplyr)
library(stringr)
options(max.print=1000000)
require(qqplotr)
##Loads the initial uncleaned scrapped data.
uncleaned <- read_xlsx("coles%wools.xlsx")

View(uncleaned)

##Deletes all entries where there's no value.
cleaned <- na.omit(uncleaned)

##Clears all entries with 'null' value from coles and woolworth's prices columns. 
cleaned<-cleaned%>% filter(coles!="null")
cleaned<-cleaned%>% filter(wools!="null")

##Apply string split to coles price column for distinguishing the before and after offer price values
cleaned$before <- sapply(strsplit(as.character(cleaned$coles),' '), "[", 1)
cleaned$after <- sapply(strsplit(as.character(cleaned$coles),' '), "[", 2)

##Replacing the before offer price column with after discount(current price) value.
cleaned[ !is.na(cleaned$after)  , "before" ] <- cleaned[ !is.na(cleaned$after), "after" ]

##Removing special character ('$') from the price columns.
cleaned$wools<-str_remove(cleaned$wools, "[$]")
cleaned$coles<-str_remove(cleaned$before, "[$]")

##Assigning values within coles and wools column as numeric types.
cleaned$coles <- as.numeric(cleaned$coles)
cleaned$wools <- as.numeric(cleaned$wools)

#########Visualization############

cleaned %>% boxplot(cleaned$coles, data = ., ylab = "Price")

cleaned %>% boxplot(cleaned$wools, data = ., ylab = "Price")

##Removing identified outliers

boxplot<-cleaned %>% boxplot(cleaned$coles , data = ., ylab = "Price", plot = FALSE)

filt_mat <- data.frame(group = boxplot$group, outliers = boxplot$out)

clean_coles<-cleaned %>% filter(!(coles %in% filt_mat$outliers) )

clean_coles %>% boxplot(clean_coles$coles, data = ., ylab = "Price")

boxplot1<-clean_coles %>% boxplot(clean_coles$wools , data = ., ylab = "Price", plot = FALSE)

filt_mat1 <- data.frame(group = boxplot1$group, outliers = boxplot1$out)

clean_final<-clean_coles %>% filter(!(wools %in% filt_mat1$outliers) )

clean_final %>% boxplot(clean_final$wools, data = ., ylab = "Price")

##Creating separate dataframe to store coles and woolworths data.
clean_data_1<-data.frame(name=clean_final$name,store=c("coles"),price=clean_final$coles,category=clean_final$category)

clean_data_2<-data.frame(name=clean_final$name,store=c("wools"),price=clean_final$wools,category=clean_final$category)

##Merging both dataframe to a single dataframe using, rbind()
clean_final_trans<-rbind(clean_data_1,clean_data_2)

##Plotting boxplots for product prices from both stores 
clean_final_trans %>% boxplot(price ~ store, data = ., ylab = "Price")

##Filtering products based on store - 'Coles' & 'Woolworth'and Plotting QQ-Plots to check normality

#For store - 'Coles'
clean_coles_fil <- clean_final_trans %>% filter(store == "coles")
clean_coles_fil$price %>% qqPlot(dist="norm")
#For store - 'Woolworth'
clean_wools_fil <- clean_final_trans %>% filter(store == "wools")
clean_wools_fil$price %>% qqPlot(dist="norm")

##Summarizing the measurement variables

#Summarizing by store
clean_final_trans %>% group_by(store) %>%
  summarise(
    Min = min(price, na.rm = TRUE),
    Q1 = quantile(price, probs = .25, na.rm = TRUE),
    Median = median(price, na.rm = TRUE),
    Q3 = quantile(price, probs = .75, na.rm = TRUE),
    Max = max(price, na.rm = TRUE),
    Mean = mean(price, na.rm = TRUE),
    SD = sd(price, na.rm = TRUE),
    n = n()
  )

##Checking equality of variance for the two populations using LaveneTest
leveneTest(price ~ store, data = clean_final_trans)

##Performing the paired t-test considering all assumptions
t.test(
  price ~ store,
  data = clean_final_trans,
  paired = TRUE,
  var.equal = FALSE,
  alternative = "two.sided",
  conf.interval=0.95
)
