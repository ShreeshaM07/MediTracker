
import re

def findFollowUpDate(extracted_text):
    follow_up_pattern = re.compile(r'Follow up: (\d{1,2}/\d{1,2}/\d{2,4})')
    follow_up_match = follow_up_pattern.search(extracted_text)
    follow_up_date = follow_up_match.group(1) if follow_up_match else None
    return follow_up_date

    
def extract_Tablets(extracted_text):
    sentences=list(extracted_text.split('\n'))
    #print(sentences)
    tablets_list=[]
    for i in range(len(sentences)):
        try:
            word_in_sentence=list(sentences[i].split())
            #print(word_in_sentence)
            if word_in_sentence[0]=='Tab,' or word_in_sentence[0]=='Cap,' or word_in_sentence[0]=='Ointment,' or word_in_sentence[0]=='Syp,' or word_in_sentence[0]=='TAB' or word_in_sentence[0]=='Tab' or word_in_sentence[0]=='Cap' or word_in_sentence[0]=='CAP' or word_in_sentence[0]=='OINTMENT' or word_in_sentence[0]=='Cream,' or word_in_sentence[0]=='CREAM' or word_in_sentence[0]=='Tablet' or word_in_sentence[0]=='tablet'   :
                tablets_list.append([sentences[i]])

        except Exception:
            continue
    follow_up_date = findFollowUpDate(extracted_text)
    for i in range(len(tablets_list)):
        before_after=0
        if 'before' in tablets_list[i][0] or 'Before' in tablets_list[i][0]:
            before_after=1
            #1 indicates before food
            #0 indicates after food
        else:
            before_after=0
        if 'morning' in tablets_list[i][0] or 'Morning' in tablets_list[i][0]:
            if(before_after==1):
                tablets_list[i].append('before morning')
            else:
                tablets_list[i].append('after morning')
        if 'afternoon' in tablets_list[i][0] or 'Afternoon' in tablets_list[i][0]:
            if(before_after==1):
                tablets_list[i].append('before afternoon')
            else:
                tablets_list[i].append('after afternoon')
        if 'evening' in tablets_list[i][0] or 'Evening' in tablets_list[i][0]:
            if(before_after==1):
                tablets_list[i].append('before evening')
            else:
                tablets_list[i].append('after evening')
        if 'night' in tablets_list[i][0] or 'Night' in tablets_list[i][0]:
            if(before_after==1):
                tablets_list[i].append('before night')
            else:
                tablets_list[i].append('after night')
        
        if 'days' in tablets_list[i][0] or 'day' in tablets_list[i][0]:
            len_days_string=len(tablets_list[i][0])
            no_days=tablets_list[i][0][len_days_string-6:len_days_string-4].strip()
            tablets_list[i].append(no_days)
    if follow_up_date!=None:    
        tablets_list.append(['Follow up date',follow_up_date])
    else:
        tablets_list.append(['Follow up date','01/01/2024'])
    print("Follow-up Date:", follow_up_date)
    print(tablets_list)
    return tablets_list

      
    

# Example usage
#extracted_text = "Hospital Name\n\nAFHJVN;BFOP;BGP;NGLJDFGLS;\n\nPhn:2389u4y0\n\nPatient Namezwipgths\nAge:s8\n\nSexson\n\nInvestigations: xray,dghibif\nDiagnosixifizhul\n\nMedication:\n\nMedicine name Dosage Duration\n\nTab, ibuprofen \u20181 morning, 1 night (Before food) 3 days\nCap, omez, 1 morning , 1 night (before food) 3 days\nOintment, Volini afternoon (after food) 2 days\n\nAdvice: take medicines on time\n\nFollow up: 12/01/22\n\n\n\n\n\n"


# def extractTablets(extracted_text):
#     #extracted_text="Hospital Name |\n\nAFHJVN;BFOP;BGP;NGLIDFGLS;\n\nPhn:2389u4y0\n\nPatient Name:ruipgthg\nAge:88\nsexim\nInvestigations: xray,dghibif\n\nDiagnosis:ifjighuj\n\nMedication:\n\nMedicine name Dosage Duration\nTab, ibuprofen \u20181 morning, 1 night (Before food) 3 days\nCap, omez \u2018L morning , 1 night (before food) 3 days\nOintment, Volini afternoon (after food) 2 days\n\nAdvice: take medicines on time\n\nFollow up: 12/01/22\n\nDname\n\njfapbgliabg\n"
#     sentences=list(extracted_text.split('\n'))
#     #print(sentences)
#     line_no=None
#     for i in range(len(sentences)):
#         if 'Medicine name Dosage' in sentences[i]:
#             line_no=i
#             break
#     tablets_arr=[]
#     line_no+=1
#     while(line_no<len(sentences)):
        
#         # if(sentences[line_no][0]!='Cap' or sentences[line_no][0]!='Capsule' or sentences[line_no][0]!='Tab' or sentences[line_no][0]!='Tablet' or sentences[line_no][0]!='ointment'):
#         #     break
#         tablets_arr.append(sentences[line_no])
#         line_no+=1
        

#     #print(tablets_arr)
#     #tab_list is the final list that will be sent back to the flutter
#     tab_list=[]
#     for i in range(len(tablets_arr)):
#         tab_sentence=[]
#         try:
#             word_in_line=list(tablets_arr[i].split())
#             #print(word_in_line)
#             if(word_in_line[0]=='Tab,' or word_in_line[0]=='Cap,' or word_in_line[0]=='Ointment,' ):
#                 word_in_line[0]+=word_in_line[1]
#                 #print(word_in_line)
#                 tab_sentence.append(word_in_line[0])
#                 if 'morning' in word_in_line or 'Morning' in word_in_line or 'morning,' in word_in_line or 'Morning,' in word_in_line:
#                     tab_sentence.append('morning')
#                 if 'afternoon' in word_in_line or 'Afternoon' in word_in_line or 'afternoon,' in word_in_line or 'Afternoon,' in word_in_line:
#                     tab_sentence.append('afternoon')
#                 if 'evening' in word_in_line or 'Evening' in word_in_line or 'evening,' in word_in_line or 'Evening,' in word_in_line:
#                     tab_sentence.append('evening')
#                 if 'night' in word_in_line or 'Night' in word_in_line or 'night,' in word_in_line or 'Night,' in word_in_line:
#                     tab_sentence.append('night')
#                 if '(before' in word_in_line or '(Before' in word_in_line or 'before' in word_in_line or 'Before' in word_in_line:
#                     tab_sentence.append('before')
#                 elif '(after' in word_in_line or '(After' in word_in_line or 'after' in word_in_line or 'After' in word_in_line:
#                     tab_sentence.append('after')
#                 for j in range(len(word_in_line)):
#                     if(word_in_line[j]=='days' or word_in_line[j]=='day'):
#                         tab_sentence.append(word_in_line[j-1])
                
                
                    

#             else:
#                 break
            
#         except Exception :
#             continue
            
#         #print(tab_sentence)
#         tab_list.append(tab_sentence)
#     follow_up_date = findFollowUpDate(extracted_text)

#     print("Follow-up Date:", follow_up_date)
    
#     tab_list.append(['Follow up date',follow_up_date])
#     print(tab_list)
#     return tab_list

    


    
     
# extractTablets(extracted_text)

