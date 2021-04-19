
COPY staging_caers_event(report_id, created_date, event_date, product_type, product, product_code, description,
                         patient_age, age_units, sex, terms, outcomes)
    FROM 'C:\Users\Rodrigo''s Gaming PC\Dropbox\Data Management and Analysis\Homework 7\CAERS_ASCII_11_14_to_12_17.csv'
DELIMITER ','
CSV HEADER encoding 'windows-1251';