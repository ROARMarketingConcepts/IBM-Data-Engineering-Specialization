# Import libraries required for connecting to mysql

import mysql.connector

# Import libraries required for connecting to DB2

import ibm_db

# Connect to MySQL

connection = mysql.connector.connect(user='root', password='MjQ0Njgta2VuMTIz',host='127.0.0.1',database='sales')
cursor = connection.cursor()

# Connect to DB2

dsn_hostname = "2f3279a5-73d1-4859-88f0-a6c3e6b4b907.c3n41cmd0nqnrk39u98g.databases.appdomain.cloud" # e.g.: "dashdb-txn-sbox-yp-dal09-04.services.dal.bluemix.net"
dsn_uid = "bds93024"        # e.g. "abc12345"
dsn_pwd = "7LhjPR0Xy7HrUblp"      # e.g. "7dBZ3wWt9XN6$o0J"
dsn_port = "30756"                # e.g. "50000" 
dsn_database = "bludb"            # i.e. "BLUDB"
dsn_driver = "{IBM DB2 ODBC DRIVER}" # i.e. "{IBM DB2 ODBC DRIVER}"           
dsn_protocol = "TCPIP"            # i.e. "TCPIP"
dsn_security = "SSL"              # i.e. "SSL"

#Create the dsn connection string
dsn = (
    "DRIVER={0};"
    "DATABASE={1};"
    "HOSTNAME={2};"
    "PORT={3};"
    "PROTOCOL={4};"
    "UID={5};"
    "PWD={6};"
    "SECURITY={7};").format(dsn_driver, dsn_database, dsn_hostname, dsn_port, dsn_protocol, dsn_uid, dsn_pwd, dsn_security)

# create connection
conn = ibm_db.connect(dsn, "", "")

def get_last_rowid():
    SQL = "SELECT MAX(row_id) FROM sales_data"
    stmt = ibm_db.exec_immediate(conn, SQL)
    res = ibm_db.fetch_both(stmt)
    print(res)
    return int(res[0])

last_row_id = get_last_rowid()
print("Last row id on production datawarehouse = ", last_row_id)

# List out all records in MySQL database with rowid greater than the one on the Data warehouse
# The function get_latest_records must return a list of all records that have a rowid greater than the last_row_id in the sales_data table in the sales database on the MySQL staging data warehouse.

def get_latest_records(row_id):
    
    SQL = "SELECT * FROM sales_data WHERE rowid > %s"
    cursor.execute(SQL, [row_id])
    new_recs = cursor.fetchall()
    return new_recs
	
new_records = get_latest_records(last_row_id)

print("New rows on staging datawarehouse = ", len(new_records))

# Insert the additional records from MySQL into DB2 data warehouse.
# The function insert_records must insert all the records passed to it into the sales_data table in IBM DB2 database.

def insert_records(records):
    SQL = "INSERT INTO sales_data(row_id,product_id,customer_id,quantity) VALUES(?,?,?,?);"
    stmt = ibm_db.prepare(conn, SQL)

    for record in records:
        ibm_db.execute(stmt, record)

insert_records(new_records)
print("New rows inserted into production datawarehouse = ", len(new_records))

# disconnect from mysql warehouse
connection.close()

# disconnect from DB2 data warehouse
ibm_db.close(conn)

# End of program