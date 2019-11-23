CREATE TABLE IF NOT EXISTS d_dates
(
    id      SERIAL PRIMARY KEY,
    date    DATE NOT NULL UNIQUE,
    year    SMALLINT CHECK (year >= 0),
    quarter SMALLINT CHECK (quarter >= 1 AND quarter <= 4),
    month   SMALLINT CHECK (month >= 1 AND month <= 12),
    day     SMALLINT CHECK (day >= 1 AND day <= 31)
);

CREATE OR REPLACE FUNCTION date_parts() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE d_dates
    SET year    = date_part('year', NEW.date),
        quarter = date_part('quarter', NEW.date),
        month   = date_part('month', NEW.date),
        day     = date_part('day', NEW.date)
    WHERE date = NEW.date;

    RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER date_parts
    AFTER INSERT
    ON d_dates
    FOR EACH ROW
EXECUTE PROCEDURE date_parts();

CREATE TABLE summary_levels
(
    id       SERIAL PRIMARY KEY,
    code     VARCHAR(3) NOT NULL UNIQUE,
    division TEXT       NOT NULL UNIQUE
);

INSERT INTO summary_levels (code, division)
VALUES ('040', 'State'),
       ('050', 'County'),
       ('061', 'Minor Civil Division'),
       ('071', 'Minor Civil Division place part'),
       ('157', 'County place part'),
       ('162', 'Incorporated place'),
       ('170', 'Consolidated city'),
       ('172', 'Consolidated city - place within consolidated city');


CREATE TABLE IF NOT EXISTS states
(
    id   SERIAL PRIMARY KEY,
    code VARCHAR(2) NOT NULL UNIQUE,
    name TEXT       NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS counties
(
    id       SERIAL UNIQUE,
    state_id INT REFERENCES states (id),
    code     VARCHAR(3) NOT NULL,
    name     TEXT       NOT NULL,
    UNIQUE (state_id, code)
);

CREATE TABLE IF NOT EXISTS d_subdivisions
(
    id         SERIAL PRIMARY KEY,
    id_sum_lev INT REFERENCES summary_levels (id),
    id_county  INT REFERENCES counties (id),
    code       VARCHAR(5) NOT NULL,
    name       TEXT       NOT NULL,
    UNIQUE (id_sum_lev, id_county, code)
);

CREATE TABLE d_age_groups
(
    id          SERIAL PRIMARY KEY,
    from_age    SMALLINT        NOT NULL,
    to_age      SMALLINT        NOT NULL DEFAULT 32767,
    UNIQUE (from_age, to_age)
);

CREATE TABLE d_sex
(
  id    SERIAL      PRIMARY KEY,
  sex   TEXT        NOT NULL UNIQUE
);

INSERT INTO d_sex (sex) VALUES ('male'), ('female');

CREATE TABLE IF NOT EXISTS f_population
(
    id_subdivision          INT REFERENCES d_subdivisions (id),
    id_date                 INT REFERENCES d_dates (id),
    id_age_group            INT REFERENCES d_age_groups (id),
    id_sex                  INT REFERENCES d_sex(id),
    f_census_pop            INT,
    f_est_base_pop          INT,
    f_est_pop               INT,
    f_est_county_pop        INT,
    f_est_county_pop_sex    INT,
    f_census_county_hu      INT,
    f_est_base_county_hu    INT,
    f_est_county_hu         INT,
    change_date             TIMESTAMP DEFAULT current_timestamp
);
