CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR
);

CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR,
    date_of_birth date
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT
);

CREATE TABLE invoices_items(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT
);

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR,
    name VARCHAR
);