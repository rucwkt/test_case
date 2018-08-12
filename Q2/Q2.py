import pandas as pd
# filepath
file_path = "./"
file_name = "Q2.tsv"

# import data
data = pd.read_csv(file_path+file_name, delimiter='\t', header=0, encoding = 'utf-8')
print(data.head(10))

# select condition
data = data[(data['# date']>='2017-08-24')&(data['# date']<='2017-08-25')&(data['url'].str[-4:]=='.jpg')]
print(data.head(10))