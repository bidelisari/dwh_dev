# CUSTOMER

## Overview

- This table stores customer information with their class information and any notes related to that. 

## Columns

| Name | Type | Nullable | Description |
| ---- | ---- | ------- | -------- |
| customer_key | integer | false | Surrogate Key |
| Customer No | varchar(15) | false | Customer No |
| Customer Name | varchar(65) | true | Customer Name |
| Customer Class | varchar(15) | true | Customer Class |
| Salesman ID | varchar(15) | true | FK to DimSalesperson |
| Branch ID | varchar(15) | true | FK to DimBranch |
| Divisi | nvarchar(100) | true | Divisi |
| Sub.Div | nvarchar(100) | true | Sub Divisi |
| Credit Limit | numeric(19, 5) | true | Credit Limit |
| Created | datetime | true | Created at |
| ACTIVE | varchar(3) | false | Flagging Active |
| Address | nvarchar(255) | true | Address |
| row_hash | binary(32) | false | Hash Value for Incremental |
| effective_ts | datetime2(0) | true | Load Timestamp |
| load_ts | datetime(7) | true | Load Timestamp |

## Sources

| Table | Description |
| ---- | ---- |
| RM00101 | Customer Master |
| RM00201 | Customer Class Master |
| SY03900 | Record Notes Master |