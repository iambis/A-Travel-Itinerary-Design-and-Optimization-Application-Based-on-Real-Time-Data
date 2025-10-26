CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE destinations (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  location POINT NOT NULL,
  description TEXT,
  province VARCHAR(100),
  category VARCHAR(100),
  activities TEXT[],
  estimated_cost NUMERIC,
  best_time_start INTEGER,
  best_time_end INTEGER,
  sustainability JSONB,
  images TEXT[],
  rating NUMERIC,
  popularity INTEGER,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE itineraries (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES customers(id),
  group_id INTEGER REFERENCES groups(id),
  preferences JSONB,
  start_date DATE,
  end_date DATE,
  total_cost NUMERIC,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE itinerary_destinations (
  id SERIAL PRIMARY KEY,
  itinerary_id INTEGER REFERENCES itineraries(id),
  destination_id INTEGER REFERENCES destinations(id),
  visit_date DATE,
  duration INTEGER,
  notes TEXT
);

CREATE TABLE routes (
  id SERIAL PRIMARY KEY,
  itinerary_id INTEGER REFERENCES itineraries(id),
  from_destination_id INTEGER REFERENCES destinations(id),
  to_destination_id INTEGER REFERENCES destinations(id),
  distance NUMERIC,
  duration INTEGER,
  transport VARCHAR(50)
);

CREATE TABLE groups (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  creator_id INTEGER REFERENCES customers(id),
  itinerary_id INTEGER REFERENCES itineraries(id),
  invite_link VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE group_members (
  id SERIAL PRIMARY KEY,
  group_id INTEGER REFERENCES groups(id),
  customer_id INTEGER REFERENCES customers(id),
  role VARCHAR(50),
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE votes (
  id SERIAL PRIMARY KEY,
  group_id INTEGER REFERENCES groups(id),
  destination_id INTEGER REFERENCES destinations(id),
  user_id INTEGER REFERENCES customers(id),
  vote VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_destinations_category ON destinations(category);
