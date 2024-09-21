import streamlit as st
import pandas as pd
from office365.runtime.auth.user_credential import UserCredential
from office365.sharepoint.client_context import ClientContext
import io
import os

# Title of the app
st.title("🔒 SAP Secure SSB UI5 Sheet")
st.sidebar.title("Navigation")
page = st.sidebar.radio("Go to", ["Login", "Matrix Sheet", "Change Log"])
df = None

if page == "Login":
    st.header("Login to SharePoint")
    username = st.text_input("Username")
    password = st.text_input("Password", type="password")
    
    if st.button("Login"):
        if username and password:
            try:
                # Use environment variables for sensitive information
                site_url = os.getenv("SHAREPOINT_SITE_URL")
                file_relative_url = os.getenv("SHAREPOINT_FILE_PATH")

                # Authenticate
                credentials = UserCredential(username, password)
                ctx = ClientContext(site_url).with_credentials(credentials)
                
                # Download the file
                file_stream = io.BytesIO()
                ctx.web.get_file_by_server_relative_url(file_relative_url).download(file_stream)  # Fixed line
                ctx.execute_query()
                
                # Load the file content
                file_stream.seek(0)  # Reset stream position
                cleaned_content = file_stream.read().decode('utf-8', errors='ignore')
                st.session_state.file_content = cleaned_content  # Save file content to session state
                st.success("File downloaded successfully!")
            except Exception as e:
                st.error(f"Login failed: {e}")
        else:
            st.error("Please enter both username and password.")

if page == "Matrix Sheet":
    if 'file_content' in st.session_state:
        df = pd.read_csv(io.StringIO(st.session_state.file_content))
    
    st.header("Matrix File for Tiles")
    uploaded_file = st.file_uploader("Choose a CSV file", type="csv")
    if uploaded_file is not None:
        df = pd.read_csv(uploaded_file)
        
    st.write("Data from the CSV file:")
    if df is not None:
        st.dataframe(df)

if page == "Change Log":
    if 'file_content' in st.session_state:
        df = pd.read_csv(io.StringIO(st.session_state.file_content))
    
    st.header("Change Log for SAP Roles")
    uploaded_file_stats = st.file_uploader("Choose a CSV file for changelog", type="csv")
    if uploaded_file_stats is not None:
        df_stats = pd.read_csv(uploaded_file_stats)
        st.write("Change Log Data:")
        st.dataframe(df_stats)
    else:
        st.write("Please upload a CSV file to view statistics.")
