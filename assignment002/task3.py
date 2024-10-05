import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt

from sklearn.neighbors import NearestNeighbors

from sklearn.preprocessing import MinMaxScaler



df_pid = pd.read_csv('diabetes.csv', header=0, na_values = ['na','','-','.'])
df_diabetes = df_pid[df_pid.columns[:-1]]



def plot_correlation(df_diabetes):
    # visual inpection 
    fig ,axs = plt.subplots(4)

    fig.subtitle('Inspect visually posible correlations')
    axs[0].scatter(df_diabetes['Pregnancies'], df_diabetes['Glucose'], linewidths=[0,0])
    axs[1].scatter(df_diabetes['Glucose'], df_diabetes['BloodPressure'], linewidths=[0,0])
    axs[2].scatter(df_diabetes['Glucose'], df_diabetes['SkinThickness'], linewidths=[0,0])
    axs[3].scatter(df_diabetes['Glucose'], df_diabetes['Insulin'], linewidths=[0,0])
    plt.show()


 
#Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin',
#       'BMI', 'DiabetesPedigreeFunction', 'Age'



corrV1 = df_diabetes.corr()
fig, ax = plt.subplots()
ax.matshow(corrV1,  cmap='coolwarm') 
dim = len(corrV1)
for i in range(dim):
    for j in range(dim):
        c =  '{:.2f}'.format(corrV1.iloc[i,j])
        ax.text(i,j,str(c), va='center', ha='center')
ax.xla(corrV1.columns)
# there are some positive and negative correlations 



# task pending : plot the correlatoon and use the indicator as size = magnitude or color= red negative
plt.scatter(correlation_table)



 # Need to remove the values that equal to 0 from columns BloodPressure, SkinThickness and BMI

blood_miss= df_diabetes["BloodPressure"]==0
skinth_miss = df_diabetes["SkinThickness"]==0
bmi_miss = df_diabetes["BMI"]==0

df_diabetes.loc[blood_miss, ["BloodPressure"]] = None
df_diabetes.loc[skinth_miss, ["SkinThickness"]] = None
df_diabetes.loc[bmi_miss, ["BMI"]] = None

# We will examinate the value distribution of missing value 

fig_dist ,axs_dist = plt.subplots(3)
fig.subtitle('Inspect visually distribution')
axs_dist[0].hist(df_diabetes['BloodPressure'], bins = 10)
axs_dist[0].hist(df_diabetes['SkinThickness'], bins = 10)
axs_dist[0].hist(df_diabetes['BMI'], bins = 10)




# Fill the cells with null using the mean values of the records that have the same class label.

'''
We will face this firtsly classifiying records according to its distance to their k neithbourds(excluding the column )
obtain the mean in the neightbords  

'''

#according to histogram all values are positive so safely we can scale to (0,1)


def all_cols_but_excluding(colname):
    return [c != colname  for c in df_diabetes.columns]




scaler = MinMaxScaler(feature_range=(0,1))
scaled_df =  scaler.fit_transform(df_diabetes)



#knn =  NearestNeighbors(n_neighbors=3).fit()
#knn