# Relational Database Design and SQL Programming with MySQL

Relational Database Design and SQL Programming with MySQL is a structured collection of seventeen independent exercises that demonstrates how relational data models can be designed, populated, queried, and automated across a range of realistic domains. The work progresses from foundational schemas and data analysis to reusable database operations, derived information, consistency rules, and transactional workflows. Each exercise includes its own sample data and executable statements, making the repository both a practical study resource and a complete portfolio project focused on database engineering.

## Overview

The exercises translate business requirements into relational schemas and then use SQL to answer increasingly complex questions. The collection covers employee management, transport incidents, cinema programming, professional qualifications, motor racing, catering, banking, public health, and academic publishing.

Every script is self-contained and creates one primary database. Two exercises also include an additional schema-design case study. The scripts can therefore be executed individually for focused study or sequentially to reproduce the complete work.

## Objectives

- Model entities, attributes, and relationships for distinct application domains.
- Enforce entity and referential integrity with primary keys, foreign keys, composite keys, indexes, and nullability rules.
- Populate schemas with representative data suitable for repeatable demonstrations.
- Retrieve and analyse information with filtering, joins, subqueries, grouping, aggregation, and temporal conditions.
- Encapsulate database operations through stored procedures and views.
- Maintain derived values and business rules through triggers.
- Apply transaction control to operations that must be completed atomically.

## Exercise Catalogue

| Exercise | Domain | Main focus |
| --- | --- | --- |
| `exercise_01.sql` | Companies and employees | Relational modelling, reporting relationships, joins, and nested queries |
| `exercise_02.sql` | Employees and departments | Aggregation, grouping, filtering, and implicit and explicit joins |
| `exercise_03.sql` | Vehicles and road incidents | Ownership and participation relationships, reporting queries, and data deletion |
| `exercise_04.sql` | Cinema programming | Multi-table analysis, aggregates, subqueries, and inclusive query results |
| `exercise_05.sql` | Cinema analytics | Parameterised stored procedures and statistical views |
| `exercise_06.sql` | Road-incident analytics | Procedures, views, temporary results, tax calculations, and yearly statistics |
| `exercise_07.sql` | Skills and qualifications | Temporal analysis, reusable procedures, views, and automatic counters |
| `exercise_08.sql` | Motor racing and video rental | Championship analytics, automated standings, and an additional rental-chain schema |
| `exercise_09.sql` | Catering management | Menu and event analysis with procedures and trigger-maintained totals |
| `exercise_10.sql` | Accounts and payment cards | Atomic transfers, account analytics, and balance automation |
| `exercise_11.sql` | Qualification usage | Competency analysis, temporal reporting, views, and validation triggers |
| `exercise_12.sql` | Certificates and qualifications | Year-based reporting, qualification views, and usage validation |
| `exercise_13.sql` | Vaccination and disease tracking | Vaccination analytics, contagion analysis, views, and automatic counters |
| `exercise_14.sql` | Vaccine effectiveness | Comparative health analysis, risk rules, procedures, and views |
| `exercise_15.sql` | Vaccination constraints | Risk-based analysis, usage statistics, and preventive validation |
| `exercise_16.sql` | Qualifications, billing, and banking | Temporal qualification analysis, fee calculation, automation, and an additional banking schema |
| `exercise_17.sql` | Academic publishing | Authorship analytics and automatically maintained publication summaries |

## Technical Scope

The implementation uses MySQL with the InnoDB storage engine. Across the collection, it demonstrates:

- Database and table definition statements.
- Primary, foreign, and composite keys.
- Supporting indexes and cascading updates where required by the model.
- Data insertion, selection, update, and deletion.
- Inner and outer joins, correlated and uncorrelated subqueries, grouping, and aggregate functions.
- Date-based and string-based filtering.
- Stored procedures with input parameters and local calculations.
- Views for reusable analytical results.
- Triggers for validation, counters, balances, totals, and summary data.
- Explicit transaction control and temporary tables.

## Prerequisites

To run the complete collection, the following components are required:

- MySQL Server.
- The MySQL command-line client or MySQL Workbench.
- A MySQL account permitted to create databases, tables, views, stored procedures, and triggers, and to read and modify data.

No external datasets, application runtime, package manager, or build process is required. All demonstration data is included in the SQL scripts.

## Running the Complete Collection

The same MySQL commands are used on Windows, macOS, and Linux. Only the command used to enter the repository directory differs.

### 1. Start MySQL

Install MySQL Server and a compatible client for the operating system, start the server service, and confirm that the command-line client is available:

```text
mysql --version
```

### 2. Open the repository root

On Windows PowerShell:

```powershell
Set-Location "C:\path\to\repository"
```

On macOS or Linux:

```bash
cd "/path/to/repository"
```

### 3. Connect to MySQL

Run the following command and enter the password when prompted:

```text
mysql --user=YOUR_USERNAME --password
```

For a reproducible full run, use a MySQL instance that does not already contain the databases or program objects created by these scripts.

### 4. Execute every script

From the MySQL prompt, load the scripts in numerical order:

```sql
SOURCE exercise_01.sql;
SOURCE exercise_02.sql;
SOURCE exercise_03.sql;
SOURCE exercise_04.sql;
SOURCE exercise_05.sql;
SOURCE exercise_06.sql;
SOURCE exercise_07.sql;
SOURCE exercise_08.sql;
SOURCE exercise_09.sql;
SOURCE exercise_10.sql;
SOURCE exercise_11.sql;
SOURCE exercise_12.sql;
SOURCE exercise_13.sql;
SOURCE exercise_14.sql;
SOURCE exercise_15.sql;
SOURCE exercise_16.sql;
SOURCE exercise_17.sql;
```

Each script creates and selects its own database before defining objects, inserting sample records, and running its demonstrations. Result sets are printed directly in the client as the statements execute. The scripts that define procedures also include representative calls, while views and triggers remain available in their respective databases for further inspection.

### 5. Verify the result

List the databases created during execution:

```sql
SHOW DATABASES;
```

Inspect the objects from any exercise by selecting its database. For example:

```sql
USE n33_20_dicembre_2023;
SHOW TABLES;
SHOW PROCEDURE STATUS WHERE Db = 'n33_20_dicembre_2023';
SHOW TRIGGERS;
```

Exit the client after verification:

```sql
EXIT;
```

## Running a Single Exercise

To work with one topic only, connect from the repository root and source the corresponding file. For example:

```sql
SOURCE exercise_09.sql;
```

This creates the schema, loads its data, defines its database objects, and executes its included examples without requiring any other exercise.

## Running with MySQL Workbench

The complete collection can also be executed through the graphical client on any supported operating system:

1. Start MySQL Workbench and connect to the target MySQL server.
2. Open an exercise script in the SQL editor.
3. Execute the entire script so that delimiter changes, stored programs, triggers, and example statements are processed together.
4. Repeat for the remaining files in numerical order.
5. Refresh the Schemas panel to inspect the databases and their objects.

## Expected Outcome

After the full sequence has completed, the MySQL instance contains the schemas, tables, relationships, sample records, routines, views, triggers, and query demonstrations defined by all seventeen exercises. The resulting environment can be used to review relational design decisions, inspect database automation, rerun analytical queries, and extend the supplied scenarios with additional data or requirements.
