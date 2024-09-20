import streamlit as st 
import pandas as pd
# Title of the app
st.title("🔒 SAP Secure SSB UI5 sheet")
st.sidebar.title("Navigation")
page = st.sidebar.radio("Go to", ["Matrix Sheet", "Change Log"])
df = None
if page == "Matrix Sheet":
    st.header("Matrix File for tiles")
    uploaded_file = st.file_uploader("Choose a CSV file", type="csv")
    if uploaded_file is not None:
        df = pd.read_csv(uploaded_file)
    st.write("Data from the CSV file:")
    if df is not None:
        st.dataframe(df)
if page == "Change Log":
    st.header("Change Log for SAP Roles")
    uploaded_file_stats = st.file_uploader("Choose a CSV file for changelog", type="csv")
    if uploaded_file_stats is not None:
        df_stats = pd.read_csv(uploaded_file_stats)
        st.write("Change Log Data:")
        st.dataframe(df_stats)
    else:
        st.write("Please upload a CSV file to view statistics.")
