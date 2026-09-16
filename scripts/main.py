from paths import raw_customer_churn_path, clean_customer_churn_path
from preprocessing import inspect_data, clean_data,load_data

def main():
    #Load raw data 
    raw_df = load_data(raw_customer_churn_path)

    # Inspect Raw Data 
    inspect_data(raw_df)

    # Clean Raw Data
    df_clean = clean_data(raw_df, ['TotalCharges'])

    # Inspect After Cleaning
    inspect_data(df_clean)

    # Save Cleaned Data
    df_clean.to_csv(clean_customer_churn_path, index = False)

if __name__ == "__main__":
    main()