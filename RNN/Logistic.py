#  Copyright (c) 2022. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#  Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
#  Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
#  Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
#  Vestibulum commodo. Ut rhoncus gravida arcu.

# !/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on   Apr 15 10:29:51 2022
# @Author:   Zening Ye
# @Email:    zening.ye@gmail.com
# @Project:  Neural Network
# @File:     Logistic.py
# @Software: PyCharm
"""

# Import Packages
from Data import get_data
import matplotlib.pyplot as plt
from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_auc_score, roc_curve,confusion_matrix,classification_report


# Read data
df = get_data(0)
df.head()

# split data
X = df.loc[:,range(32)]
y = df.behavior

X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.65,random_state=42)

# Construct logistic regression
logit = LogisticRegression()
logit.fit(X_train, y_train)
pred = logit.predict(X_test)

# accuracy rate in training data
logit.score(X_test, y_test)

# accuracy rate in testing data
a_s = accuracy_score(y_test,pred)

cm = confusion_matrix(y_test, pred)

logit_roc_auc = roc_auc_score(y_test, logit.predict(X_test))
fpr, tpr, thresholds = roc_curve(y_test, logit.predict_proba(X_test)[:,1])
plt.figure(figsize=(10,5))
plt.plot(fpr, tpr, label='Logistic Regression (area = %0.2f)' % logit_roc_auc)
plt.plot([0, 1], [0, 1],'r--')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic')
plt.legend(loc="lower right")
# plt.savefig('Log_ROC')
plt.show()

print('Accuracy score:', a_s)
print("Confusion Matrix : \n", cm)

print(classification_report(y_test, pred))