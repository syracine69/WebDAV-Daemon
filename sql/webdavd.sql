CREATE TABLE users(
	user_id  serial PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);

CREATE TABLE groups(
	group_id serial PRIMARY KEY,
	group_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE user_groups(
	user_id INT NOT NULL,
	group_id INT NOT NULL,
	grant_date TIMESTAMP,
	PRIMARY KEY (user_id, group_id),
	FOREIGN KEY (group_id)
		REFERENCES groups (group_id),
	FOREIGN KEY (user_id)
		REFERENCES users (user_id)
);
