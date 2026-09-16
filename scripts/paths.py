import json
import os

project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

config_path = os.path.join(project_root, "config.json")

with open(config_path, "r") as f:
    config = json.load(f)

raw_customer_churn_path = os.path.join(project_root, config["Data"]["raw_data"])

clean_customer_churn_path = os.path.join(project_root, config["Data"]["clean_data"])

preprocessing_visuals_path = os.path.join(project_root, config["Visuals"]["preprocessing"])
os.makedirs(preprocessing_visuals_path, exist_ok=True)

clustering_visuals_path = os.path.join(project_root, config["Visuals"]["clustering"])
os.makedirs(clustering_visuals_path, exist_ok=True)

modeling_visuals_path = os.path.join(project_root, config["Visuals"]["modeling"])
os.makedirs(modeling_visuals_path, exist_ok=True)

if __name__ == "__main__":
    print(f"Raw Data Path: {raw_customer_churn_path}")
    print(f"Clean Data Path: {clean_customer_churn_path}")
    print(f"Preprocessing Visuals Path: {preprocessing_visuals_path}")
    print(f"Clustering Visuals Path: {clustering_visuals_path}")
    print(f"Modeling Visuals Path: {modeling_visuals_path}")