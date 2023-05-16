-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public."MyFactTrips"
(
    tripid serial,
    wastecollected float NOT NULL,
    wasteid integer NOT NULL,
    zoneid integer NOT NULL,
    dateid integer NOT NULL,
    PRIMARY KEY (tripid)
);

CREATE TABLE public."MyDimDate"
(
    dateid integer NOT NULL,
    date date NOT NULL,
    year integer NOT NULL,
    quarter integer NOT NULL,
    quartername varchar(2) NOT NULL,
    month integer NOT NULL,
    monthname varchar(10) NOT NULL,
    day, integer NOT NULL,
    weekdayname varchar(10) NOT NULL,
    PRIMARY KEY (dateid)
);

CREATE TABLE public."MyDimWaste"
(
    wasteid integer NOT NULL,
    wastetype varchar(10) NOT NULL,
    PRIMARY KEY (wasteid)
);

CREATE TABLE public."MyDimZone"
(
    zoneid integer NOT NULL,
    zone varchar(10) NOT NULL,
    city varchar(10) NOT NULL,
    PRIMARY KEY (zoneid)
);

ALTER TABLE public."MyFactTrips"
    ADD FOREIGN KEY (dateid)
    REFERENCES public."MyDimDate" (dateid)
    NOT VALID;


ALTER TABLE public."MyFactTrips"
    ADD FOREIGN KEY (zoneid)
    REFERENCES public."MyDimZone" (zoneid)
    NOT VALID;

ALTER TABLE public."MyFactWaste"
    ADD FOREIGN KEY (wasteid)
    REFERENCES public."MyDimZone" (wasteid)
    NOT VALID;

END;