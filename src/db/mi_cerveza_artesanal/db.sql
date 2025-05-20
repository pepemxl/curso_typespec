create table beer_users (
  id bigint primary key GENERATED ALWAYS AS IDENTITY,
  username text not null unique
);

create table beer_brands (
  id bigint primary key GENERATED ALWAYS AS IDENTITY,
  name text not null
);

create table beer_types (
  id bigint primary key GENERATED ALWAYS AS IDENTITY,
  type_name text not null
);

create table beers (
  id bigint primary key GENERATED ALWAYS AS IDENTITY,
  brand_id bigint references beer_brands (id),
  type_id bigint references beer_types (id),
  description text,
  photo_url text
);

create table beer_ratings (
  id bigint primary key GENERATED ALWAYS AS IDENTITY,
  user_id bigint references users (id),
  beer_id bigint references beers (id),
  rating int check (
    rating >= 1
    and rating <= 5
  )
);