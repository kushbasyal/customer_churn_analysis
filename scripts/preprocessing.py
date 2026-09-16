from paths import raw_customer_churn_path, clean_customer_churn_path
import pandas as pd

def load_data(file_path):
    try:
        df = pd.read_csv(file_path)
        print("========== Data Load Sucessfully ==========")
        return df

    except FileNotFoundError:
        print("File Path Not Found")
        return None

def inspect_data(df):

    print("===== First Five Rows =====")
    print(df.head())

    print("\n===== Shape =====")
    print(df.shape)

    print("\n ===== Info =====")
    df.info()

    print("\n ===== Describe =====")
    print(df.describe())

    print("\n ===== Missing Values =====")
    print(df.isna().sum())

    print("\n ===== Duplicate Rows =====")
    print(df.duplicated().sum())

    print("\n ===== Data Types =====")
    print(df.dtypes)

def clean_data(df, numeric_cols = None):
    df = df.copy()

    # Clean Column Names
    df.columns = df.columns.str.strip()

    # Strip White Spaces for categorical Columns
    cat_cols = df.select_dtypes(include =['object']).columns
    for col in cat_cols:
        df[col] = df[col].str.strip()

    # Convert Selected Columns to numeric
    if numeric_cols:
        for col in numeric_cols:
            numeric_col = pd.to_numeric(df[col], errors='coerce')

            invalid_rows = df[numeric_col.isna()]

            if not invalid_rows.empty:
                print(f"===== Invalid Rows in {col}=====")
                print(invalid_rows)

            df[col] = numeric_col
            # Fill missing TotalCharges with 0 because customers with tenure of 0 have no accumulated charges
            
            if df[col].isna().sum() > 0:
                df[col] = df[col].fillna(0)

    # For Categorical Missing values with mode
    for col in cat_cols:
        if df[col].isna().sum() > 0:
            df[col] = df[col].fillna(df[col].mode()[0])

    # filling remaining numerical columns into median
    num_cols = df.select_dtypes(include =['number']).columns
    for col in num_cols:
        if df[col].isna().sum() > 0:
            df[col] = df[col].fillna(df[col].median())

    return df

if __name__ == "__main__":
    raw_df = load_data(raw_customer_churn_path)
    inspect_data(raw_df)

    df = clean_data(raw_df,['TotalCharges'])
    #print(df)
    inspect_data(df)
