# SALESPERSON

## Overview

- This table stores customer information with their class information and any notes related to that. 

## Columns

| Name | Type | Nullable | Description |
| ---- | ---- | ------- | -------- |
| salesperson_key | integer | false | Surrogate Key |
| Salesman ID | varchar(31) | false | Salesman ID |
| selling_uom | varchar(11) | fal;se | Selling UOM |
| item_desc | varchar(100) | true | Item Description |
| item_class_cd | varchar(11) | true | Item Class Code |
| item_class_desc | varchar(31) | true | Item Class Description |
| uom_schedule | varchar(11) | true | UOM Schedule |
| base_uom | varchar(11) | true | UOM Base |
| equiv_qty | numeric(19, 5) | true | Equiv Quantity |
| is_active | bit | false | Flagging Active |
| load_ts | datetime2(7) | false | Load Timestamp |
| update_ts | datetime2(7) | false | Update Timestamp |

## Sources

| Table | Description |
| ---- | ---- |
| IV00101 | Item Master |
| IV40400 | Item Class Setup |
| IV40201 | U of M Schedule Setup (header) |
| IV40202 | U of M Schedule Detail Setup |