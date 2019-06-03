# Supermarket-Price-Wars
Analysis carried out to find which major supermarket in Australia Coles or Woolworths, is cheaper.

#### Executive statement

An investigation is done to identify which Australian supermarket among coles and Woolworths sells products at a cheaper price. Data containing details of products(ProductName, Prices, Category)from both stores were scrapped online, a sample of approximately 50 products were taken from each category namely 'Clothing, Household & Pet','Pantry','Freezer','Baby, Health & Beauty','Fridge','Bakery','Meat & Seafood' and 'Drinks & Tobacco'.The dataset was checked for different anomalies and the dataset was cleaned and made efficient for analysis.The final cleaned dataset named 'clean_final_trans' was used for analysis which contains 4 variables 'name','store','price','category'.Prices are in Australian dollars and are from 16 May 2019. Using this dataset, descriptive statistics, box plot and qqplot visuals were created to investigate price variations. And a paired t-test was used to test for a significant price difference.

From the summary statistics, it was found that Woolworths sells products at a slightly lower price compared to coles online. From the t-test results, based on the p-value and 95% confidence interval, we tend to reject the null hypothesis Ho:μΔ = 0 and the test is found to be statistically significant.

#### Hypothesis Test

A paired t-test was chosen for hypothesis testing with H0:μΔ = 0 & HA:μΔ ≠ 0.Significance level is 5% or 0.05.

Levene's test is performed to check homogeneity of variance's of both the population samples. From the Levene's test, the p-value is found to be 0.3502, which is greater than 0.05 (the significance level). Hence we assume the variances to be equal and unknown. We also assume the population data to be normally distributed and the Alternate hypothesis (Ha) to be such that the price of products in Woolworths is less than that at Coles. A paired-sample t-test is carried out to check the hypotheses. 

#### Discussion 

Discuss the findings of your investigation. What did yu conclude? What were the strengths and limitations of your investigation? What improvements could be made or what would you do differently next time?

•Findings & Conclusion
Findings from the above test performed we have found that the p-value is less than 0.05 in the Levene's test and hence we assumed the homogeneity of the variances and also assumed the normality of distribution since the sample's size is greater than 30. From the results of paired sample t-test, we reject the null hypothesis because the p-value is less than the significance level and the 95% CI mean differences do not capture Ho:μΔ = 0. Thereby concluding that there is a significant difference between both stores. ie, the test is statistically significant. While there may be a significant price difference for the sample data collected but there are some limitations that need to be considered.

•Strengths
One of the strengths of investigation is the consistency and accuracy of the products used, the brand, product and size. this is also a limitation of the investigation. With this investigation, we were able to draw a rough view of products prices for customers who shopped online from these stores.

•Limitations: 
One of the main limitations was on the data collected. The data was collected from Coles and Woolworths online store than location based. Not every product that was in stock in Woolworths had stock in coles and vice-versa, so predicting a general trend in variation of price on daily items from each category was not precise

•Improvements:
One of the improvements that can be done for future investigations is to have a check at Coles and Woolworths own items like Milk, Dairy products, Eggs as there could be some price variation in own brand items. The data collected now had limited entries for each category, for more accuracy it would be best if more data are collected. Prepare a prices comparison of both these stores based on locations(Different suburbs and cities).
