### SecureFactsheet consuming data from SAP

This repo is an implementation of an idea that I had in my mind, to somehow use my skillset and combine those to make a particular sycle of an application.
It all started with my fascination for SSB Fiori apps, and their app id's if at all they are available somewhere else other than Fiori apps library, good part is 
that for SSB / KPI apps we have one CDS view, but for the other apps I didn't find any CDS which could give me this, I did dig into the UI5 uploader but playing with it 
in a corporate license didnt seem fair 😆. 

### How things are supposed to work 👨‍🔬

1. Firstly, things will start happening in SAP, when the batch job scheduled for our precious little file uploader will run. It will take data from the table functions and 
   CDS views we have created as part of this project and upload in the AL11 ( application layer ) directory.

2. Then I have uploaded one JIL file for Autosys job which will take the file from the AL11 folder and upload it to the sharepoint / network folder.
   
3. Once the autosys job for transfer has finished, the file will be there in the sharepoint folder, so users have to visit our little python app , and login to that sharepoint , after that the file will be automatically used, if users don't login they can make use of the uploaders nonetheless.
   
### How to run it on your own machine 🎰

1. Install the requirements

   ```bash
   $ pip install -r requirements.txt
   ```

2. Run the app

   ```bash
   $ streamlit run streamlit_app.py
   ```
