create table players (
    id bigint primary key GENERATED ALWAYS AS IDENTITY,
    name text not null,
    country text,
    rating int,
    pdga_number int unique
);

create table player_discs (
    id bigint primary key GENERATED ALWAYS AS IDENTITY,
    disc_id bigint references discs (id),
    country text,
    rating int,
    pdga_number int unique
);

create table courses (
    id bigint primary key GENERATED ALWAYS AS IDENTITY,
    name text not null,
    location text,
    number_of_holes int
);

create table tournaments (
    id bigint primary key GENERATED ALWAYS AS IDENTITY,
    name text not null,
    course_id bigint references courses (id),
    date date
);

create table player_statistics (
    id bigint primary key GENERATED ALWAYS AS IDENTITY,
    player_id bigint references players (id),
    tournament_id bigint references tournaments (id),
    score int,
    position int
);

create table disc_brands (
    id bigint primary key GENERATED ALWAYS AS IDENTITY,
    name text not null unique
);

create table discs (
    id bigint primary key GENERATED ALWAYS AS IDENTITY,
    name text not null,
    brand_id bigint references disc_brands (id),
    type text,
    speed int,
    glide int,
    turn int,
    fade int
);