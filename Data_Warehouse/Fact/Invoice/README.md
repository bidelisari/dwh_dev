# INVOICE

## Overview

- Stores all posted & unposted invoice and return transactions. 
- Union table between posted and unposted where filter SOPTYPE in (3,4) and VOIDSTTS = 0

## Columns

| Name | Type | Nullable | Description |
| ---- | ---- | ------- | -------- |
| sales_key | integer | false | Surrogate Key |
| Customer No | varchar(15) | false | FK to DimCustomer |
| Item No | varchar(31) | true | FK to DimItem |
| Trx No | varchar(21) | true | Transaction Number |
| Trx Date | datetime | true | Transaction Date |
| Trx Type | varchar(6) | true | Transaction Type |
| Invoice Amount | numeric(38, 7) | true | Invoice Amount |
| Disc Total Amount | numeric(38, 7) | true | Discount * Quantity |
| DPP Invoice | numeric(38, 7) | true | Invoice Amount / Tax |
| Sales Nett | numeric(38, 7) | true | DPP Invoice - Discount |
| Gross Profit | numeric(38, 7) | true | DPP Invoice - Cost |
| table_source | varchar(6) | true | Main Source Table |
| load_ts | datetime | true | Load Timestamp |

## Sources

| Table | Description |
| ---- | ---- |
| SOP30200 | Posted Header |
| SOP30300 | Posted Line |
| SOP10100 | Open Header |
| SOP10200 | Open Line |
| IV00101 | Item Master |