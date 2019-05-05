from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager 
from bs4 import BeautifulSoup 
import time 
import re
import datetime 
import pprint
import json

class Br(): 
    def __init__(self): 
        self.browser = webdriver.Chrome(ChromeDriverManager().install())
        self.url = "https://www.comptonfoundation.org/grants-awarded/schedule-of-grants/?pg="
        self.page = 1 
    def start(self): 
        self.browser.get(self.url) 
        time.sleep(1) 
    def next_page(self): 
        self.url = "https://www.comptonfoundation.org/grants-awarded/schedule-of-grants/?pg=" + str(self.page + 1)
        self.browser.get(self.url)
        self.page+=1 
        time.sleep(1) 
    def close_out(self): 
        self.browser.close()
    def process_results(self, last):
        results = []
        project_number = 2
        self.browser.get(self.url)
        if (last):
            for x in range(1,20):
                organization = self.browser.find_element_by_xpath("//*[@id='grants']/tbody/tr["+str(project_number)+"]/td[1]").text
                project = self.browser.find_element_by_xpath("//*[@id='grants']/tbody/tr["+str(project_number)+"]/td[2]").text
                grant_amount = self.browser.find_element_by_xpath("//*[@id='grants']/tbody/tr["+str(project_number)+"]/td[4]").text
                date = self.browser.find_element_by_xpath("//*[@id='grants']/tbody/tr["+str(project_number)+"]/td[3]").text
                results.append([organization, project, date, grant_amount])
                project_number+=1
        else:
            for x in range(1,21):
                organization = self.browser.find_element_by_xpath("//*[@id='grants']/tbody/tr["+str(project_number)+"]/td[1]").text
                project = self.browser.find_element_by_xpath("//*[@id='grants']/tbody/tr["+str(project_number)+"]/td[2]").text
                grant_amount = self.browser.find_element_by_xpath("//*[@id='grants']/tbody/tr["+str(project_number)+"]/td[4]").text
                date = self.browser.find_element_by_xpath("//*[@id='grants']/tbody/tr["+str(project_number)+"]/td[3]").text
                results.append([organization, project, date, grant_amount])
                project_number+=1
        print("Grant:" + str(project_number))
        return results


b = Br() 
b.start()
grants = [] 
for x in range(5):
    print("Page {}".format(b.page))
    if x < 4:
        grants += b.process_results(False)
        b.next_page()
    else:
        grants += b.process_results(True)
b.close_out() 

print("DONE")
print(len(grants))

with open('output.json', 'w') as outfile:
    json.dump(grants, outfile)