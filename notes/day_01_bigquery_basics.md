## Mistakes / Bugs I hit today:
- I learned that hidden folders like `.venv` do not show with normal `ls`; I need `ls -a`.
- I used the wrong activation path at first: `/intern/bin/activate` instead of `.venv/bin/activate`.
- I mixed up absolute paths and relative paths.
- I typed the requirements file wrong as `.text` / `.tex` instead of `.txt`.
- I forgot to save `requirements.txt` before running `pip install`.
- I learned that `.venv` is my project’s isolated Python environment.
- I learned that `pip install -r app/requirements.txt` installs the packages listed in that file.
- I learned that imports like pandas/sklearn can take a little time the first time.
- I accidentally wrote SQL practice inside the `.md` notes file instead of the `.sql` file.
- I learned that `.sql` files hold actual SQL queries, while `.md` files hold notes/documentation.
- I mixed pandas-style syntax like `.count()` and `.unique()` with SQL syntax.
- I learned SQL uses functions like `COUNT(*)` and `COUNT(DISTINCT user_id)`, not object methods.
- I confused tables with columns at first.
- I learned that BigQuery table names use the structure `project.dataset.table`.
- I learned that backticks `` `...` `` are for database identifiers, while single quotes `'...'` are for strings.

What is BigQuery? 
BigQuery is googles cloud's database system where you can run SQL queries on large datasets. 

What is a dataset? 
A dataset is a way to represent the structure of data this can be a table. 

What is GoogleSQL? 
GoogleSQL is the SQL syntax that google uses for BigQuery.

What does LIMIT do? 
It sets a limit on how many rows to extract on each table. 

What does COUNT(DISTINCT) do?
It counts the number of unique items. 

What is a fully qualified table name? 
`Project.Dataset.Table`

GROUP BY: Take rows that share the same value and put them into buckets.
If you use:

COUNT
SUM
AVG
MIN
MAX

then SQL needs to know:

“Grouped by WHAT?”

That’s what GROUP BY answers.
