### SecureFactsheet consuming data from SAP
Link - [SecureFactsheet](https://securefactsheet.streamlit.app/) - you can access the app from here


This repo is an implementation of an idea that I had in my mind, to somehow use my skillset and combine those to make a particular sycle of an application.
It all started with my fascination for SSB Fiori apps, and their app id's if at all they are available somewhere else other than Fiori apps library, good part is 
that for SSB / KPI apps we have one CDS view, but for the other apps I didn't find any CDS which could give me this, I did dig into the UI5 uploader but playing with it 
in a corporate license didnt seem fair 😆. 

### How things are supposed to work 👨‍🔬

1. Firstly, things will start happening in SAP, when the batch job scheduled for our precious little file uploader will run. It will take data from the table functions and 
   CDS views we have created as part of this project and upload in the AL11 ( application layer ) directory.

2. Then I have uploaded one JIL file for Autosys job which will take the file from the AL11 folder and upload it to the sharepoint / network folder.
   
3. Once the autosys job for transfer has finished, the file will be there in the sharepoint folder, so users have to visit our little python app , and login to that sharepoint , after that the file will be automatically used, if users don't login they can make use of the uploaders nonetheless.

### How things look and feel 🪄

1. SAP File uploader

<img width="607" alt="image" src="https://github.com/user-attachments/assets/3a4d9cd2-b73d-4c32-b17d-ae2280042c42">

2. It does make the file in the AL11 path

![image](https://github.com/user-attachments/assets/a6dcb4b0-fed2-430e-987b-8c3224c8066b)

3. The python app -

- Login page

![image](https://github.com/user-attachments/assets/08c01fd0-36f7-465c-9809-df53fcc70719)

- File uploader

![image](https://github.com/user-attachments/assets/04bd8134-ceb5-43a0-94e1-ccf59b8c66b2)

### Note 

The default share point uploader can be used locally for both pages separately, but for now globally it's taking only one file, 
as my requirement was that user will have access to either of that, and determination will be done via DB ( which I am not using here 😄 )

### How to run it on your own machine 🎰

1. Install the requirements

   ```bash
   $ pip install -r requirements.txt
   ```

2. Run the app

   ```bash
   $ streamlit run streamlit_app.py
   ```
