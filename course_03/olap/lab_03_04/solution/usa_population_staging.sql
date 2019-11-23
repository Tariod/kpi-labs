-- County subdivision Resident Population Estimates
CREATE TABLE sub_county_pop_stg
(
    sum_lev               VARCHAR(3) NOT NULL,
    state_code            VARCHAR(2) NOT NULL,
    county_code           VARCHAR(3) NOT NULL,
    place_code            VARCHAR(5),
    county_sub_code       VARCHAR(5),
    sub_name              TEXT       NOT NULL,
    state_name            TEXT       NOT NULL,
    census_tot_pop_2010   INT,
    est_base_tot_pop_2010 INT,
    year                  DATE       NOT NULL,
    est_tot_pop           INT
);

-- Annual Estimates of Housing Units for the United States, Regions, Divisions, States, and Counties
CREATE TABLE housing_units_stg
(
    sum_lev               VARCHAR(3) NOT NULL,
    state_code            VARCHAR(2) NOT NULL,
    county_code           VARCHAR(3) NOT NULL,
    county_name           TEXT       NOT NULL,
    state_name            TEXT       NOT NULL,
    census_hu_2010        INT,
    est_base_hu_2010      INT,
    year                  DATE       NOT NULL,
    est_hu                INT
);

-- Annual County Resident Population Estimates by Age, Sex
CREATE TABLE IF NOT EXISTS pop_char_stg
(
    sum_lev             VARCHAR(3) NOT NULL,
    state_code          VARCHAR(2) NOT NULL,
    county_code         VARCHAR(3) NOT NULL,
    state_name          TEXT       NOT NULL,
    county_name         TEXT       NOT NULL,
    year                DATE       NOT NULL,
    from_age            SMALLINT   NOT NULL,
    to_age              SMALLINT   NOT NULL DEFAULT 32767,
    est_tot_pop         INT,
    est_tot_male_pop    INT,
    est_tot_female_pop  INT
);

CREATE TABLE IF NOT EXISTS d_dates_stg
(
    date DATE NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS states_stg (
    code    VARCHAR(2)          NOT NULL UNIQUE,
    name    TEXT                NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS counties_stg (
    state_code      VARCHAR(2)          NOT NULL,
    code            VARCHAR(3)          NOT NULL,
    name            TEXT                NOT NULL,
    UNIQUE (state_code, code, name)
);

CREATE TABLE IF NOT EXISTS d_subdivisions_stg (
    sum_lev                 VARCHAR(3)          NOT NULL,
    state_code              VARCHAR(2)          NOT NULL,
    county_code             VARCHAR(3)          NOT NULL,
    code                    VARCHAR(5)          NOT NULL,
    name                    TEXT                NOT NULL,
    UNIQUE (sum_lev,state_code, county_code, code)
);

CREATE TABLE IF NOT EXISTS d_age_groups_stg
(
    from_age    SMALLINT    NOT NULL,
    to_age      SMALLINT    NOT NULL DEFAULT 32767,
    UNIQUE (from_age, to_age)
);

CREATE TABLE IF NOT EXISTS f_population_stg
(
    sum_lev                 VARCHAR(3)                      NOT NULL,
    state_code              VARCHAR(2)                      NOT NULL,
    county_code             VARCHAR(3)                      NOT NULL,
    code                    VARCHAR(5)                      NOT NULL,
    name                    TEXT                            NOT NULL,
    year                    DATE                            NOT NULL,
    f_census_pop            INT,
    f_est_base_pop          INT,
    f_est_pop               INT,
    f_census_county_hu      INT,
    f_est_base_county_hu    INT,
    f_est_county_hu         INT,
    UNIQUE (sum_lev, state_code, county_code, code, year)
);
