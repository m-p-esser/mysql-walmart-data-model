""" Prepare Data to be uploaded to MySQL tables """

import pandas as pd
import pathlib


def prepare_customer_data(sales_df: pd.DataFrame, target_data_dir: pathlib.Path):
    columns = [
        "customer_name",
        "customer_age",
        "customer_segment",
        "city",
        "zip_code",
        "state",
        "region",
    ]
    customer_df = sales_df.loc[:, columns]
    columns_renamed = [col.replace("customer_", "") for col in customer_df.columns]
    customer_df.columns = columns_renamed
    customer_df.drop_duplicates(inplace=True, keep="last")
    customer_df.to_csv(
        target_data_dir / "customer.csv", index=False, sep=";", na_rep="NULL"
    )
    return customer_df


def prepare_product_data(sales_df: pd.DataFrame, target_data_dir: pathlib.Path):
    columns = [
        "product_name",
        "product_container",
        "product_sub_category",
        "product_category",
        "product_base_margin",
    ]
    product_df = sales_df.loc[:, columns]
    columns_renamed = [col.replace("product_", "") for col in product_df.columns]
    product_df.columns = columns_renamed
    product_df.drop_duplicates(inplace=True, keep="last")
    product_df.to_csv(
        target_data_dir / "product.csv", index=False, sep=";", na_rep="NULL"
    )
    return product_df


def prepare_order_data(
    sales_df: pd.DataFrame,
    product_df: pd.DataFrame,
    customer_df: pd.DataFrame,
    target_data_dir: pathlib.Path,
):
    columns = [
        "order_id",
        "order_priority",
        "order_quantity",
        "unit_price",
        "sales",
        "shipping_cost",
        "discount",
        "profit",
        "order_date",
        "ship_date",
        # The following columns are needed for looking up Customer ID
        "customer_name",
        "city",
        "zip_code",
        "state",
        "region",
        # The following columns are needed for looking up Product ID
        "product_name",
        "product_container",
        "product_sub_category",
        "product_category",
        "product_base_margin",
    ]
    order_df = sales_df.loc[:, columns]
    columns_renamed = [col.replace("order_", "") for col in order_df.columns]
    order_df.columns = columns_renamed
    order_df.rename(columns={"id": "order_id"}, inplace=True)

    # TO-DO: Lookup Customer ID (from customer.csv) and Product ID (from product.csv)

    order_df.to_csv(target_data_dir / "order.csv", index=False, sep=";", na_rep="NULL")


if __name__ == "__main__":
    data_dir = pathlib.Path.cwd() / "data"

    source_data_dir = data_dir / "raw"
    source_file_path = source_data_dir / "walmart_sales.csv"
    sales_df = pd.read_csv(source_file_path)

    target_data_dir = data_dir / "final"

    customer_df = prepare_customer_data(sales_df, target_data_dir)
    product_df = prepare_product_data(sales_df, target_data_dir)
    prepare_order_data(sales_df, product_df, customer_df, target_data_dir)
