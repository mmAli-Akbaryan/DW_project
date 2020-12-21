if exists(select * from sys.schemas where [name]='src') drop schema src;
go
create schema src;
go



CREATE TABLE src.employees (
	employee_id int IDENTITY(1, 1) PRIMARY KEY,
	f_name VARCHAR(25),
	l_name VARCHAR(25),
	gender_key int,
	national_code VARCHAR (10),
	identity_serial VARCHAR(10),
	photo VARCHAR(100),
	bank_acc_key int,
	job_degree_key int,
	cv_degree_key int,
	education_degree_key int,
	cv_outside VARCHAR(255),
	cv_inside VARCHAR(255),
	employment_date DATE,
	employment_type_key int,
	address_key int,
	branch_key int,
);

CREATE TABLE src.genders (
	gender_key int IDENTITY(1, 1) PRIMARY KEY,
	title VARCHAR(25)
);

CREATE TABLE src.bank_accounts (
	bank_acc_key int IDENTITY(1, 1) PRIMARY KEY,
	acc_number VARCHAR(25),
	acc_name VARCHAR(50),
	bank_key int,
	bank_branch_code VARCHAR(25)
);

CREATE TABLE src.banks (
	bank_key int IDENTITY(1, 1) PRIMARY KEY,
	bank_name varchar(25)
);

CREATE TABLE src.job_degrees (
	job_degree_key int IDENTITY(1, 1) PRIMARY KEY,
	degree_name VARCHAR(25),
	details VARCHAR(255),
	monthly_salary_base money
);

CREATE TABLE src.cv_degrees (
	cv_degree_key int IDENTITY(1, 1) PRIMARY KEY,
	cv_name VARCHAR(25),
	details VARCHAR(255),
	min_experience int,
	max_experience int,
	salary_increase_coefficient real
);

CREATE TABLE src.education_degrees (
	education_degree_key int IDENTITY(1, 1) PRIMARY KEY,
	edu_name VARCHAR(25),
	details VARCHAR(255),
	salary_increase_coefficient real
);

CREATE TABLE src.employment_types (
	employment_type_key int IDENTITY(1, 1) PRIMARY KEY,
	emp_name VARCHAR(25),
	details VARCHAR(255),
	term_of_contract real
);

CREATE TABLE src.addresses (
	address_key int IDENTITY(1, 1) PRIMARY KEY,
	first_line VARCHAR(255),
	second_line VARCHAR(255),
	city_key int
);

CREATE TABLE src.cities (
	city_key int IDENTITY(1, 1) PRIMARY KEY,
	city_name VARCHAR(25),
	province_key int
);

CREATE TABLE src.provinces (
	province_key int IDENTITY(1, 1) PRIMARY KEY,
	province_name VARCHAR(25)
);

CREATE TABLE src.branches (
	branch_key int IDENTITY(1, 1) PRIMARY KEY,
	branch_name VARCHAR(25),
	address_key int,
	establish_date DATE
);

CREATE TABLE src.leaves (
	leave_key int IDENTITY(1, 1) PRIMARY KEY,
	employee_id int,
	leave_date DATE,
	hour_count TINYINT
);

----------------------------------------------------------
CREATE TABLE src.contracts (
	contract_key int IDENTITY(1, 1) PRIMARY KEY,
	customer_key int,
	service_key int,
	register_date DATE,
	starting_date DATE,
	tracking_code VARCHAR(25),
	contract_picture VARCHAR(255),
	branch_key int,
	payment_key int,
);

CREATE TABLE src.customers (
	customer_key int IDENTITY(1, 1) PRIMARY KEY,
	fname VARCHAR(25),
	lname VARCHAR(25),
	national_code VARCHAR(10),	
	identity_serial VARCHAR(10),
	id_card_picture VARCHAR(255),
	phone_number VARCHAR(25),
	address_key int,
	register_date DATE
);

CREATE TABLE src.services (
	service_key int IDENTITY(1, 1) PRIMARY KEY,
	title VARCHAR(25),
	details VARCHAR(255),
	duration TINYINT, --month count
	traffic int, --by GB
	speed int, --Kbps
	price MONEY
);

CREATE TABLE src.payments (
	payment_key int IDENTITY(1, 1) PRIMARY KEY,
	payment_method_key int,
	payment_date DATE,
	tracking_code VARCHAR(25)
);

CREATE TABLE src.payment_methods (
	payment_method_key int IDENTITY(1, 1) PRIMARY KEY,
	method_name VARCHAR(25)
);

CREATE TABLE src.installers (
	installer_key int IDENTITY(1, 1) PRIMARY KEY,
	fname VARCHAR(25),
	lname VARCHAR(25),
	city_key int,
	national_code VARCHAR(10),
	identity_serial VARCHAR(10),
	id_card_picture VARCHAR(255),
	phone_number VARCHAR(25),
	fee MONEY
);

CREATE TABLE src.installations (
	installation_key int IDENTITY(1, 1) PRIMARY KEY,
	installer_key int,
	contract_key int
);

--------------------------------------------
CREATE TABLE src.connections (
	connection_key int IDENTITY(1, 1) PRIMARY KEY,
	contract_key int,
	connect_time DATETIME,
	disconnec_time DATETIME,
	upload_count int, --Kb
	download_count int,
	assigned_ip VARCHAR(15)
);

-----------------------------------------------
ALTER TABLE src.employees
ADD FOREIGN KEY (gender_key) REFERENCES src.genders(gender_key)

ALTER TABLE src.employees
ADD FOREIGN KEY (bank_acc_key) REFERENCES src.bank_accounts(bank_acc_key)

ALTER TABLE src.employees
ADD FOREIGN KEY (job_degree_key) REFERENCES src.job_degrees(job_degree_key)

ALTER TABLE src.employees
ADD FOREIGN KEY (cv_degree_key) REFERENCES src.cv_degrees(cv_degree_key)

ALTER TABLE src.employees
ADD FOREIGN KEY (education_degree_key) REFERENCES src.education_degrees(education_degree_key)

ALTER TABLE src.employees
ADD FOREIGN KEY (employment_type_key) REFERENCES src.employment_types(employment_type_key)

ALTER TABLE src.employees
ADD FOREIGN KEY (address_key) REFERENCES src.addresses(address_key)

ALTER TABLE src.employees
ADD FOREIGN KEY (branch_key) REFERENCES src.branches(branch_key)

ALTER TABLE src.bank_accounts
ADD FOREIGN KEY (bank_key) REFERENCES src.banks(bank_key)

ALTER TABLE src.addresses
ADD FOREIGN KEY (city_key) REFERENCES src.cities(city_key)

ALTER TABLE src.cities
ADD FOREIGN KEY (province_key) REFERENCES src.provinces(province_key)

ALTER TABLE src.branches
ADD FOREIGN KEY (address_key) REFERENCES src.addresses(address_key)

ALTER TABLE src.leaves
ADD FOREIGN KEY (employee_id) REFERENCES src.employees(employee_id)

ALTER TABLE src.contracts
ADD FOREIGN KEY (customer_key) REFERENCES src.customers(customer_key)

ALTER TABLE src.contracts
ADD FOREIGN KEY (service_key) REFERENCES src.services(service_key)

ALTER TABLE src.contracts
ADD FOREIGN KEY (branch_key) REFERENCES src.branches(branch_key)

ALTER TABLE src.contracts
ADD FOREIGN KEY (payment_key) REFERENCES src.payments(payment_key)

ALTER TABLE src.customers
ADD FOREIGN KEY (address_key) REFERENCES src.addresses(address_key)

ALTER TABLE src.payments
ADD FOREIGN KEY (payment_method_key) REFERENCES src.payment_methods(payment_method_key)

ALTER TABLE src.installers
ADD FOREIGN KEY (city_key) REFERENCES src.cities(city_key)

ALTER TABLE src.installations
ADD FOREIGN KEY (installer_key) REFERENCES src.installers(installer_key)

ALTER TABLE src.installations
ADD FOREIGN KEY (contract_key) REFERENCES src.contracts(contract_key)

ALTER TABLE src.connections
ADD FOREIGN KEY (contract_key) REFERENCES src.contracts(contract_key)