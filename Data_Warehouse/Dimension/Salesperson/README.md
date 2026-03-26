# SALESPERSON

## Overview

- This table stores salesperson information with their territory / region information. 
- Filter SLPRSNID <> 'QA-IT' and CONCAT(SLPRSNFN,SPRSNSMN,SPRSNSLN) <> ''

## Columns

| Name | Type | Nullable | Description |
| ---- | ---- | ------- | -------- |
| salesperson_key | integer | false | Surrogate Key |
| Salesman ID | varchar(15) | false | Salesman ID |
| Salesman | varchar(100) | false | Salesman Name|
| Cabang | varchar(100) | true | Cabang |
| Branch id | varchar(15) | false | FK to DimBranch |
| Region | varchar(21) | true | Region |
| Branch PIC | varchar(100) | false | Branch PIC |
| ACTIVE | varchar(3) | false | Flagging Active |
| Person Only | varchar(15) | false | Flagging Person |
| effective_from | datetime2(7) | false |  |
| effective_to | datetime2(7) | false |  |
| is_current | bit | false | Flagging Incremental |
| load_ts | datetime2(7) | false | Load Timestamp |

## Sources

| Table | Description |
| ---- | ---- |
| RM00301 | Salesperson Master |
| RM00303 | Sales Territory Master |