import pandas as pd
import math

def convert_size(size_bytes):
   if size_bytes == 0:
       return "0B"
   size_name = ("B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB")
   i = int(math.floor(math.log(size_bytes, 1024)))
   p = math.pow(1024, i)
   s = round(size_bytes / p, 2)
   return "%s %s" % (s, size_name[i])

# filepath
file_path = "./"
file_name = "Q2.tsv"
date_start = '2017-08-24'
date_end = '2017-08-25'

# import data
data = pd.read_csv(file_path+file_name, delimiter='\t', header=0, encoding = 'utf-8')
data.columns = ['# date','time','size','url'] #in case with different header
print('Top 10 Raw Data Records: \n', data.head(10), '\n')

# select condition
data = data[(data['# date']>=date_start)&(data['# date']<=date_end)&(data['url'].str[-4:]=='.jpg')]


print('Top 10 Filtered Records: \n', data.head(10), '\n')
print('Total JPG file size from',date_start, 'to',date_end,':', convert_size(data['size'].sum()) , '\n')
