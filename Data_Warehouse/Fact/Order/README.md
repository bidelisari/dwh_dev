# ORDER

## Overview

- Stores all unposted order transactions. 
- Filter SOPTYPE =2 and VOIDSTTS = 0

## Columns

| Name | Type | Nullable | Description |
| ---- | ---- | ------- | -------- |
| order_key | integer | false | Surrogate Key |
| Customer No | varchar(15) | false | FK to DimCustomer |
| Item No | varchar(31) | true | FK to DimItem |
| PO No | varchar(21) | true | Purchased Order Number |
| Site | char(11) | true | Location Code |
| Order Date | datetime | true | Order Date |
| Req.Ship Date | datetime | true | Requested Ship Date |
| Order Qty | numeric(38, 7) | true | Order Quantity |
| Fulfil Qty | numeric(38, 7) | true | Fulfil Quantity |
| Base Qty | numeric(38, 7) | true | UOM Quantity * Fulfil Quantity |
| Disc Amount | numeric(38, 7) | true | Discount * Quantity |
| Order Amount | numeric(38, 7) | true | Order Amount |
| table_source | varchar(6) | true | Main Source Table |
| load_ts | datetime | true | Load Timestamp |

## Sources

| Table | Description |
| ---- | ---- |
| SOP10100 | Open Header |
| SOP10200 | Open Line |
| IV00101 | Item Master |