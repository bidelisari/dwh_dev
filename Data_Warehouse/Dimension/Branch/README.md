# BRANCH

## Overview

- This table stores territory / region information used in Receivables Management (RM). 

## Columns

| Name | Type | Nullable | Description |
| ---- | ---- | ------- | -------- |
| branch_sk | integer | false | Surrogate Key |
| Branch ID | varchar(15) | false | Branch ID |
| Cabang | varchar(31) | true | Cabang |
| Region | varchar(21) | true | Region |
| Lead Time | varchar(15) | true | Lead Time |
| is_active | bit | false |  |
| effective_from | datetime2(7) | true |  |
| effective_to | datetime2(7) | true |  |
| load_ts | datetime | true | Load Timestamp |

## Sources

| Table | Description |
| ---- | ---- |
| RM00303 | Sales Territory Master |