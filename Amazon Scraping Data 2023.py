#!/usr/bin/env python
# coding: utf-8

# In[1]:


get_ipython().system('pip install bs4')


# In[2]:


get_ipython().system('pip install requests')


# In[3]:


get_ipython().system('pip install pandas')


# In[4]:


from bs4 import BeautifulSoup
import requests
import pandas as pd


# In[5]:


# URL Source

URL = "https://www.amazon.com.mx/s?k=navaja+victorinox&__mk_es_MX=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=1B0Z4GKIIQTKQ&sprefix=navaja+victorino%2Caps%2C204&ref=nb_sb_noss_2"


# In[12]:


# Headers for request

HEADERS = ({'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Accept-Language': 'en-US, en;q=0.5'})


# In[15]:


# HTTP Request

webpage = requests.get(URL, headers=HEADERS)


# In[16]:


webpage


# In[17]:


webpage.content


# In[19]:


type(webpage.content)


# In[21]:


# Soup Object with all the data

soup = BeautifulSoup(webpage.content, "html.parser")


# In[22]:


soup


# In[25]:


# Get links as list

links = soup.find_all("a", attrs={'class': 'a-link-normal s-underline-text s-underline-link-text s-link-style a-text-normal'})


# In[26]:


links


# In[30]:


link = links[0].get('href')


# In[31]:


link


# In[36]:


product_list = "https://amazon.com.mx" + link


# In[37]:


product_list


# In[38]:


new_webpage = requests.get(product_list, headers=HEADERS)


# In[39]:


new_webpage


# In[40]:


# 2 Soup Object with all the data

new_soup = BeautifulSoup(new_webpage.content, "html.parser")


# In[41]:


new_soup


# In[44]:


new_soup.find("span", attrs={"id": 'productTitle'}).text


# In[45]:


new_soup.find("span", attrs={"class": 'a-price-whole'}).text


# In[ ]:




