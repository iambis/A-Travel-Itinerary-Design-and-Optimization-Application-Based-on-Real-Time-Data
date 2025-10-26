-- Bảng Customers
CREATE TABLE customers (
  id INT IDENTITY(1,1) PRIMARY KEY,
  email NVARCHAR(255) UNIQUE NOT NULL,
  password NVARCHAR(255) NOT NULL,
  name NVARCHAR(255),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
  is_active BIT DEFAULT 1
);

-- Bảng Destinations
CREATE TABLE destinations (
  id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(255) NOT NULL,
  location GEOGRAPHY NOT NULL, -- Lưu tọa độ (lat, lng)
  description NVARCHAR(MAX),
  province NVARCHAR(100),
  category NVARCHAR(100),
  activities NVARCHAR(MAX), -- Lưu dạng JSON string
  estimated_cost DECIMAL(18,2),
  best_time_start INT,
  best_time_end INT,
  sustainability NVARCHAR(MAX), -- Lưu dạng JSON string
  images NVARCHAR(MAX), -- Lưu dạng JSON string
  rating DECIMAL(3,1),
  popularity INT,
  is_active BIT DEFAULT 1
);

-- Bảng Itineraries
CREATE TABLE itineraries (
  id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT FOREIGN KEY REFERENCES customers(id),
  group_id INT FOREIGN KEY REFERENCES groups(id),
  preferences NVARCHAR(MAX), -- Lưu JSON string cho sở thích
  start_date DATE,
  end_date DATE,
  total_cost DECIMAL(18,2),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
  is_active BIT DEFAULT 1
);

-- Bảng Itinerary_Destinations
CREATE TABLE itinerary_destinations (
  id INT IDENTITY(1,1) PRIMARY KEY,
  itinerary_id INT FOREIGN KEY REFERENCES itineraries(id),
  destination_id INT FOREIGN KEY REFERENCES destinations(id),
  visit_date DATE,
  duration INT,
  notes NVARCHAR(MAX)
);

-- Bảng Routes
CREATE TABLE routes (
  id INT IDENTITY(1,1) PRIMARY KEY,
  itinerary_id INT FOREIGN KEY REFERENCES itineraries(id),
  from_destination_id INT FOREIGN KEY REFERENCES destinations(id),
  to_destination_id INT FOREIGN KEY REFERENCES destinations(id),
  distance DECIMAL(18,2),
  duration INT,
  transport NVARCHAR(50)
);

-- Bảng Groups
CREATE TABLE groups (
  id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(255) NOT NULL,
  description NVARCHAR(MAX),
  creator_id INT FOREIGN KEY REFERENCES customers(id),
  itinerary_id INT FOREIGN KEY REFERENCES itineraries(id),
  invite_link NVARCHAR(255),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
  is_active BIT DEFAULT 1
);

-- Bảng Group_Members
CREATE TABLE group_members (
  id INT IDENTITY(1,1) PRIMARY KEY,
  group_id INT FOREIGN KEY REFERENCES groups(id),
  customer_id INT FOREIGN KEY REFERENCES customers(id),
  role NVARCHAR(50),
  joined_at DATETIME DEFAULT GETDATE()
);

-- Bảng Votes
CREATE TABLE votes (
  id INT IDENTITY(1,1) PRIMARY KEY,
  group_id INT FOREIGN KEY REFERENCES groups(id),
  destination_id INT FOREIGN KEY REFERENCES destinations(id),
  user_id INT FOREIGN KEY REFERENCES customers(id),
  vote NVARCHAR(20),
  created_at DATETIME DEFAULT GETDATE()
);

-- Chỉ mục để tối ưu truy vấn
CREATE INDEX idx_destinations_category ON destinations(category);
