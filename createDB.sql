CREATE DATABASE IF NOT EXISTS chainforge;

USE chainforge;

CREATE TABLE users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(45) NOT NULL UNIQUE,
  password_ VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  created DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, password_, email) VALUES
('lcorrocher92','pR6#sL2*', 'lucacorrocher@ucdconnect.com'),
('jsmith76','fT9@kP4%', 'janesmith@tcd.ie'),
('ajohnson34','hD7%mW3$', 'alicejohnson@dcu.ie'),
('bwilliams18','gY2&pN8@', 'bobwillliams@belvedere.ie'),
('ncurry55','rF3^jK9#', 'nickcurry@blackrock.ie'),
('gcullen21','uL5$zQ1%', 'gavincullen@gonzaga.ie'),
('ngoode89','wA1#sE6*', 'niamhgoode@willowpark.edu'),
('hmalloy03','vB4@rT2*', 'harrymalloy@stannes.edu');


CREATE TABLE roles (
	role_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_type ENUM('pupil', 'undergrad student', 'postgrad student', 'teacher', 'researcher', 'lecturer', 'general staff') NOT NULL
);


INSERT INTO roles (staff_type) VALUES
('pupil'),
('undergrad student'),
('postgrad student'),
('teacher'),
('researcher'),
('lecturer'),
('general staff');


CREATE TABLE education (
	education_id INT PRIMARY KEY AUTO_INCREMENT,
    education_level ENUM('First','Second','Third') NOT NULL,
    institution_name VARCHAR(45) NOT NULL
);


INSERT INTO education (education_level, institution_name) VALUES
('Third', 'University College Dublin'),
('Third', 'Trinity College Dublin'),
('Third', 'Dublin City University'),
('Second', 'Belvedere College'),
('Second', 'Blackrock College'),
('Second', 'Gonzaga College'),
('First', 'Willow Park School'),
('First', "St. Anne's Primary School"),
('First', 'Sutton Park School');

CREATE TABLE user_info (
	user_info_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    forename VARCHAR(45) NOT NULL,
    surname VARCHAR(45) NOT NULL,
    date_of_birth DATE NOT NULL,
    role_id INT,
    education_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (education_id) REFERENCES education(education_id)
);


INSERT INTO user_info (user_id, forename, surname, date_of_birth, role_id, education_id) VALUES
(1, 'Luca', 'Corrocher', '1999-05-15', 3, 1),
(2, 'Jane', 'Smith', '2002-10-20', 2, 2),
(3, 'Alice', 'Johnson', '2002-02-28', 5, 3),
(4, 'Bob', 'Williams', '1995-08-10', 4, 4),
(5, 'Nick', 'Curry', '2008-08-10', 1, 5),
(6, 'Gavin', 'Cullen', '1996-08-10', 4, 6),
(7, 'Niamh', 'Goode', '1995-08-10', 6, 7),
(8, 'Harry', 'Malloy', '1985-08-10', 7, 8);


    -- ---------------SET UP WORKFLOW-------------------------------------

-- a user can only have ONE workflow, they are unique
CREATE TABLE workflows (
    workflow_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- creates three unique workflows for the first three users
INSERT INTO workflows (user_id) VALUES (1), (2), (3);


    -- ---------------SET UP CHAINS-------------------------------------

-- application wide table for chains
CREATE TABLE chains (
    chain_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    full_prompt_id INT,
    workflow_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (workflow_id) REFERENCES workflows(workflow_id)
);

-- creates 3 chains. Can have multiple chains in a workflow. Marks the date and time each chain was created.
INSERT INTO chains (user_id, workflow_id, full_prompt_id) VALUES
    (1, 1, 1), -- 1st chain - What country did the F1 driver Charles Leclerc win his first Grand Prix? Only respond with the country, nothing else.
    (1, 1, 7); -- 2nd chain - What country did the F1 driver Lewis Hamilton win his first Grand Prix? Only respond with the country, nothing else. 
	-- ... What nationality is the F1 driver Charles Leclerc Only respond with the nationality, nothing else....
    -- etc. 
   

-- ---------------GLOBAL NODE LOGIC-------------------------------------

-- application wide global nodes table. If anyone adds a global_node, a record will be added here.
CREATE TABLE global_nodes (
    global_node_id INT PRIMARY KEY AUTO_INCREMENT,
    workflow_id INT NOT NULL DEFAULT 1,
    chain_id INT,
    node_type ENUM('Input_Node', 'Tabular_Data_Node', 'Prompt_Node', 'Response_Node', 'LLM_Scorer_Prompt_Node', 'LLM_Scorer_Response_Node', 'LLM_Scorer_Evaluator_Node', 'Simple_Evaluator_Node', 'Code_Evaluator_Node', 'Viz_Node', 'x') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (workflow_id) REFERENCES workflows(workflow_id),
    FOREIGN KEY (chain_id) REFERENCES chains(chain_id)
);

INSERT INTO global_nodes (chain_id, node_type) VALUES
	(1, 'Tabular_Data_Node'), -- 1
    (1, 'Input_Node'), -- 2
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 5
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 10
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 15
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 20
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 25
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 30
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 35
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 
    (1, 'Prompt_Node'), -- 40
    (1, 'Response_Node'), -- 
    (1, 'Response_Node'), -- 
    (1, 'Response_Node'), -- 
    (1, 'Response_Node'), -- 
    (1, 'Response_Node'), -- 45
    (1, 'Response_Node'), --  
    (1, 'Response_Node'), -- 
    (1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), -- 50
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), -- 55
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), -- 60
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), -- 65
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), -- 70
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), -- 75
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
	(1, 'Response_Node'), --
    (1, 'Response_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), --  80
    (1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), -- 85
	(1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), -- 90
	(1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Prompt_Node'), --
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), -- 95
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), -- 100
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), --
	(1, 'LLM_Scorer_Response_Node'), -- 105
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), -- 110
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), -- 115
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
    (1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), -- 120
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), -- 125
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), -- 130
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), -- 135
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), -- 140 
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), --
	(1, 'LLM_Scorer_Evaluator_Node'), -- 143
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), -- 145
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), -- 150
	(1, 'Simple_Evaluator_Node'), --
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'),-- 
    (1, 'Simple_Evaluator_Node'), -- 155
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), -- 160
    (1, 'Simple_Evaluator_Node'), --
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), -- 165
	(1, 'Simple_Evaluator_Node'), --
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
    (1, 'Simple_Evaluator_Node'), -- 170
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), -- 175
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), --
    (1, 'Simple_Evaluator_Node'), --
	(1, 'Simple_Evaluator_Node'), -- 180
	(1, 'Simple_Evaluator_Node'), --
    (1, 'Simple_Evaluator_Node'), --
    (1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), -- 185
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), -- 190
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), -- 195
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), -- 200
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), -- 205
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
    (1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), -- 210
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), -- 215
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), --
	(1, 'Code_Evaluator_Node'), -- 220
	(1, 'Code_Evaluator_Node'), -- 221
    (2, 'x'), -- 
    (2, 'x'), -- 
    (2, 'x'), -- 
    (2, 'x'), -- 225
    (2, 'x'), -- 
    (2, 'x'), -- 
    (2, 'x'), -- 
    (2, 'x'), -- 
    (2, 'x'), -- 230
    (2, 'x'); -- 


    -- ---------------MODELS AND API KEYS-------------------------------------


CREATE TABLE models (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name ENUM('GPT3.5 Turbo', 'Gemini', 'Falcon.7B', 'GPT4') NOT NULL
);

INSERT INTO models (model_name) VALUES 
    ('GPT3.5 Turbo'),
    ('Gemini'),
    ('Falcon.7B'),
    ('GPT4');

CREATE TABLE api_keys (
    api_key_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    model_id INT,
    api_key VARCHAR(255) NOT NULL UNIQUE,
    temperature FLOAT DEFAULT 1 CHECK (temperature BETWEEN 0 AND 2),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (model_id) REFERENCES models(model_id)
);

INSERT INTO api_keys (user_id, model_id, api_key, temperature) VALUES
    (1, 1, '78d9a45b-87e1-4c7d-bf6d-9a3f8e2c1a21', 1.0),
    (1, 2, 'e2b3108f-6713-4b90-8bb3-37fa524e2c6', 1.0),
    (1, 3, 'a7f6b85c-9234-4e23-a981-6d6f9b7c1e4d', 1.0),
    (2, 1, '1e6dc93a-4b20-4f17-bca4-0ef2d834f9f7', 1.1),
    (2, 2, '5cdea18d-95e8-4cf6-8d3a-1e42cb83fd8b', 1.1),
    (2, 3, 'daf23827-2e17-4a92-b76e-6fb36cda15c8', 1.1),
    (3, 1, '9b5d6a84-5c3e-47d9-b2c4-0f18e791ac12', 1.2),
    (3, 2, '4f9e7d3a-9823-4fb2-9e7c-618d4e92f512', 1.2),
    (3, 3, '6dfe1e97-4d30-476f-aa4b-1c665c68e4d7', 1.2),
    (4, 1, '4a5fd4fb-cd72-4ad5-9b58-dfd89164f666', 1.0),
    (4, 2, 'dc1558d4-41d9-4e1e-8a8e-ec7fb1cb4883', 1.0),
    (4, 3, 'fdaae7d5-fc87-40c6-98ed-2217689bb56c', 1.0),
    (5, 1, 'd821564f-25b7-40e5-b4f6-8dbdf2b3d3a1', 1.1),
    (5, 2, 'e0fd2d1b-4780-4a68-aa35-df9f0b4d2ebd', 1.1),
    (5, 3, '0ac4f08e-d5c4-44a4-9679-8567e2025cf9', 1.1),
    (6, 1, '7484df69-fa1c-4947-8da1-8a21e9bb0057', 1.2),
    (6, 2, '618b9f42-04b0-4b7d-94af-1d2c8b05c1fd', 1.2),
    (6, 3, 'd7c0c65c-0a0e-4a4f-9d0a-07b19896db1e', 1.2),
    (7, 1, '99b653b4-95b7-48f1-b479-5c5d1f19fb50', 1.3),
    (7, 2, 'd19ac24b-b8e3-479b-aa4b-79c3de54a287', 1.3),
    (7, 3, '5c8e0b4c-0b19-4687-a4d5-8e84a61c1aa3', 1.3),
    (8, 1, '6c74f0d5-65ff-4d2b-a0cc-35dc97a1eb44', 1.4),
    (8, 2, 'f57bdf8c-4896-4ec1-814d-65b5cc5f671d', 1.4),
    (8, 3, '497c22d5-fb21-4188-8816-34681deae6a8', 1.4);

    
-------------------- COMPANY OF THE MODELS------------------
CREATE TABLE model_company (
    model_id INT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    established_date DATE NOT NULL,
    company_address VARCHAR(255) NOT NULL,
    company_country VARCHAR(45) NOT NULL,
    ceo VARCHAR(45) NOT NULL,
    FOREIGN KEY (model_id) REFERENCES models(model_id)
);

INSERT INTO model_company (model_id, company_name, established_date, company_address, company_country, ceo)
	VALUES 
		(1, 'OpenAI', '2015-12-11', 'San Francisco, California', 'United States of America', 'Sam Altman'),
        (2, 'Google', '1998-09-04', 'Menlo Park, California', 'United States of America', 'Sundar Pichai'),
        (3, 'Technology Innovation Institute', '2020-05-05','Masdar City, Abu Dhabi', 'United Arab Emirates','Ray O.Johnson'),
		(4, 'OpenAI', '2015-12-11', 'San Francisco, California', 'United States of America', 'Sam Altman');

 
-- STORES THE RECORDS FROM sendAllRegistrationEmails FUNCTION ---
CREATE TABLE registration_emails (
    email_id INT AUTO_INCREMENT PRIMARY KEY,
    email_address VARCHAR(255),
    Email_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    email_content TEXT,
    Model_Name ENUM('GPT3.5 Turbo','Gemini','Falcon.7B','GPT4')
);


-- ---- FUNCTION WHICH SENDS A REGISTRATION EMAIL TO ALL EMAILS IN THE DATABASE----
-- -------------------FOR EVERY MODEL THEY ARE LINKED TO---------------------------
-- -------------USES HTML ITALICS TO SHOW THE VARIABLES IN EMAIL------------------
DELIMITER //
CREATE PROCEDURE sendBulkRegistrationEmails()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    DECLARE username VARCHAR(45);
    DECLARE forename VARCHAR(45);
    DECLARE surname VARCHAR(45);
    DECLARE password_ VARCHAR(45);
    DECLARE email VARCHAR(255);
    DECLARE registration_date DATETIME;
    DECLARE date_of_birth DATE;
    DECLARE role VARCHAR(50);
    DECLARE api_key VARCHAR(255);
    DECLARE model_name ENUM('GPT3.5 Turbo','Gemini','Falcon.7B','GPT4');
    DECLARE ceo VARCHAR(45);
    DECLARE company VARCHAR(255);
    DECLARE email_content TEXT;

    DECLARE cur_user CURSOR FOR 
        SELECT 
            u.user_id,
            u.username,
            ui.forename,
            ui.surname,
            u.password_,
            u.email,
            u.created AS registration_date,
            ui.date_of_birth,
            r.staff_type AS role,
            ak.api_key,
            m.model_name,
            mc.ceo AS ceo,
            mc.company_name AS company
        FROM users u
        JOIN user_info ui ON u.user_id = ui.user_id
        JOIN roles r ON ui.role_id = r.role_id
        LEFT JOIN api_keys ak ON u.user_id = ak.user_id
        LEFT JOIN models m ON ak.model_id = m.model_id
        LEFT JOIN model_company mc ON m.model_id = mc.model_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_user;
    user_loop: LOOP
        FETCH cur_user INTO user_id, username, forename, surname, password_, email, registration_date, date_of_birth, role, api_key, model_name, ceo, company;
        IF done THEN
            LEAVE user_loop;
        END IF;
        SET email_content = CONCAT(
			'Dear ', username, ',\n\n',
			'Thank you for registering for ', company, '\'s ', model_name, ' model.\n\n',
			'You signed up on ', DATE_FORMAT(registration_date, '%Y-%m-%d %H:%i:%s'), '.\n\n',
			'Your API Key is: ', api_key, '.\n\n',
			'You are using the ', model_name, ' model developed by ', company, '.\n\n',
			'You are a ', role, ' so you have been granted access to the ',
			CASE 
				WHEN role IN ('pupil', 'undergrad student', 'postgrad student') THEN 'Academic package.'
				WHEN role IN ('teacher', 'lecturer', 'researcher') THEN 'Premium package.'
				ELSE 'Standard package.'
			END,
			'\n\nPlease click on the link to confirm your account!',
			'\n\nBest regards,\n\n',
			ceo, '\n',
			'CEO, ', company, '.');

        INSERT INTO registration_emails (email_address, Model_Name, email_content) VALUES (email, model_name, email_content);
    END LOOP;
    CLOSE cur_user;
END//
DELIMITER ;


-- ---------------TABULAR DATA NODE LOGIC/ JSON OBJECT-------------------------------------

CREATE TABLE tabular_data_node (
    tabular_data_id INT PRIMARY KEY AUTO_INCREMENT,
    global_node_id INT,
    records JSON, -- Storing records as JSON with order
    FOREIGN KEY (global_node_id) REFERENCES global_nodes(global_node_id)
);


INSERT INTO tabular_data_node (global_node_id, records) VALUES
(1,
 '[
   {
      "order": 1,
      "driver": "Charles Leclerc",
      "first win": "Belgium",
      "first win year": 2019,
      "last win": "Austria",
      "last win year": 2022,
      "nationality": "Monegasque"
   },
   {
      "order": 2,
      "driver": "Lewis Hamilton",
      "first win": "Canada",
      "first win year": 2007,
      "last win": "Saudi Arabia",
      "last win year": 2021,
      "nationality": "British"
   },
   {
      "order": 3,
      "driver": "Ayrton Senna",
      "first win": "Portugal",
      "first win year": 1985,
      "last win": "Australia",
      "last win year": 1993,
      "nationality": "Brazilian"
   },
   {
      "order": 4,
      "driver": "Michael Schumacher",
      "first win": "Belgium",
      "first win year": 1992,
      "last win": "China",
      "last win year": 2006,
      "nationality": "German"
   },
   {
      "order": 5,
      "driver": "Nico Rosberg",
      "first win": "China",
      "first win year": 2012,
      "last win": "Japan",
      "last win year": 2016,
      "nationality": "German"
   },
   {
      "order": 6,
      "driver": "Fernando Alonso",
      "first win": "Hungary",
      "first win year": 2003,
      "last win": "Spain",
      "last win year": 2013,
      "nationality": "Spanish"
   }
]');

    -- ---------------MAPPING DRIVER TO ARRAY FOR JSON VALUE RETRIEVAL-------------------------------------

CREATE TABLE driver_index_mapping (
    driver VARCHAR(50) PRIMARY KEY,
    array_index INT NOT NULL
);

INSERT INTO driver_index_mapping (driver, array_index) VALUES
    ('Charles Leclerc', 0),
    ('Lewis Hamilton', 1),
    ('Ayrton Senna', 2),
    ('Michael Schumacher', 3),
    ('Nico Rosberg', 4),
    ('Fernando Alonso', 5);
    
    
	-- ---------------INPUT NODE LOGIC/CREATING TEMPLATE PROMPTS AND GENERATING FULL PROMPTS BY INSERTING DRIVERS INTO TEMPLATE PROMPT-------------------------------------
	-- -------------------------------CURRENTLY 6 DRIVERS, 4 TEMPLATE PROMPTS, SO 6x4 = 24 FULL PROMPTS-------------------------------------

    
 -- full name, nationality, fathers name
CREATE TABLE input_node (
    input_node_id INT PRIMARY KEY AUTO_INCREMENT,
    global_node_id INT,
    tabular_data_id INT,
    included_columns JSON,
    FOREIGN KEY (global_node_id) REFERENCES global_nodes(global_node_id),
    FOREIGN KEY (tabular_data_id) REFERENCES tabular_data_node(tabular_data_id)
);


INSERT INTO input_node (global_node_id, included_columns)
VALUES (2, '{
    "drivers": [
        {"order": 1, "driver": "Charles Leclerc"},
        {"order": 2, "driver": "Lewis Hamilton"},
        {"order": 3, "driver": "Ayrton Senna"},
        {"order": 4, "driver": "Michael Schumacher"},
        {"order": 5, "driver": "Nico Rosberg"},
        {"order": 6, "driver": "Fernando Alonso"}
    ]
}');


CREATE TABLE templates (
	template_id INT PRIMARY KEY AUTO_INCREMENT,
    template_prompt VARCHAR(255) NOT NULL
);

    
CREATE TABLE full_prompts (
    full_prompt_id INT PRIMARY KEY AUTO_INCREMENT,
    template_id INT,
    driver_name VARCHAR(255) NOT NULL,
    full_prompt VARCHAR(255) NOT NULL,
    FOREIGN KEY (template_id) REFERENCES templates(template_id)
);


-- TRIGGER FUNCTION WHICH CHECKS IF ANY TEMPLATE PROMPTS HAVE BEEN ADDED IN TEMPLATES TABLE AND LOOPS OVER THE DRIVER VALUES IN THE 
-- JSON OBJECT INPUT NODE (TABULAR_NODE_ID 1) TO REPLACE THE DRIVER VARIABLE WITH ACTUAL DRIVERS (6).
DELIMITER $$
CREATE TRIGGER generate_full_prompts AFTER INSERT ON templates
FOR EACH ROW
BEGIN
    DECLARE driver_name VARCHAR(255);
    DECLARE driver_order INT;
    DECLARE done INT DEFAULT FALSE;
        DECLARE driver_cursor CURSOR FOR
        SELECT JSON_UNQUOTE(JSON_EXTRACT(included_columns, CONCAT('$.drivers[', idx, '].driver'))) AS driver,
               JSON_UNQUOTE(JSON_EXTRACT(included_columns, CONCAT('$.drivers[', idx, '].order'))) AS `order`
        FROM input_node, 
		(SELECT 0 AS idx UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS indices
        WHERE input_node_id = 1; 
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN driver_cursor;
        driver_loop: LOOP
        FETCH driver_cursor INTO driver_name, driver_order;
		IF done THEN
            LEAVE driver_loop;
        END IF;
		IF driver_name IS NOT NULL THEN
            INSERT INTO full_prompts (template_id, driver_name, full_prompt)
            VALUES (NEW.template_id, driver_name, REPLACE(NEW.template_prompt, '{driver}', driver_name));
        END IF;
		END LOOP driver_loop;
	CLOSE driver_cursor;
END$$
DELIMITER ;

-- ---------------- REPLACES {driver} WITH ACTUAL DRIVER
--  e.g. What country did the F1 driver Charles Leclerc win his first Grand Prix? Only respond with the country, nothing else.
INSERT INTO templates(template_prompt) VALUES
	('What country did the F1 driver {driver} win his first Grand Prix? Only respond with the country, nothing else.'),
    ('What year did the F1 driver {driver} win his last Grand Prix? Only respond with the year, nothing else.'),
    ('What nationality is the F1 driver {driver} Only respond with the nationality, nothing else.'),
    ("What country did the F1 driver {driver} win his last Grand Prix? Only respond with the country, nothing else");

-- individual records for model to query. Contains a full prompt per prompt node
CREATE TABLE prompt_node (
    prompt_node_id INT PRIMARY KEY AUTO_INCREMENT,
    global_node_id INT,
    model_id INT NOT NULL,
    full_prompt_id INT NOT NULL, 
    num_responses_per_prompt INT NOT NULL, -- Number of responses expected for each prompt
    FOREIGN KEY (global_node_id) REFERENCES global_nodes(global_node_id),
	FOREIGN KEY (model_id) REFERENCES models(model_id),
    FOREIGN KEY (full_prompt_id) REFERENCES full_prompts(full_prompt_id)
);
    
    
-- -------------ALLOWS FOR CONVERGING AND DIVERGING OF NODE RECORDS--------------
-- --------------------SHOWS THE SOURCE VERTEX AND NEXT VERTEX ---------------------
-- e.g. if you have a prompt node chained to another prompt node chained to the next node.
CREATE TABLE chain_node_connections (
    connection_id INT AUTO_INCREMENT PRIMARY KEY,
    chain_id INT,
    prompt_node_id INT,
    source_node_id INT,
    next_node_id INT,
    FOREIGN KEY (prompt_node_id) REFERENCES global_nodes(global_node_id),
    FOREIGN KEY (source_node_id) REFERENCES global_nodes(global_node_id),
    FOREIGN KEY (next_node_id) REFERENCES global_nodes(global_node_id)
);


INSERT INTO chain_node_connections(chain_id, prompt_node_id, source_node_id, next_node_id) VALUES
    -- chain id 1, graph for full prompt id 1: What country did the F1 driver Charles Leclerc win his first Grand Prix? Only respond with the country, nothing else.
    (1, 1, 3, 41), -- Prompt node diverging to response node 1
    (1, 1, 3, 42), -- Prompt node diverging to response node 2
    (1, 1, 3, 43), -- Prompt node diverging to response node 3
    (1, 1, 3, 80), -- Prompt node going to LLM scorer prompt node
    (1, 1, 80, 93), -- LLM scorer prompt node going to LLM scorer response node
    (1, 1, 93, 106), -- LLM scorer response node going to LLM scorer evaluator node
    (1, 1, 41, 106), -- Response node 1 going to LLM scorer evaluator node
    (1, 1, 42, 107), -- Response node 2 going to LLM scorer evaluator node
    (1, 1, 43, 108), -- Response node 3 going to LLM scorer evaluator node
    -- Global Node IDs for Simple Evaluator Nodes
    (1, 1, 41, 144), -- Response Node 1 to Simple Evaluator Node 1
    (1, 1, 42, 145), -- Response Node 2 to Simple Evaluator Node 2
    (1, 1, 43, 146), -- Response Node 3 to Simple Evaluator Node 3
    -- Global Node IDs for Code Evaluator Nodes
    (1, 1, 41, 183), -- Response Node 1 to Code Evaluator Node 1
    (1, 1, 42, 184), -- Response Node 2 to Code Evaluator Node 2
    (1, 1, 43, 185), -- Response Node 3 to Code Evaluator Node 3
-- chain id 2, graph for full prompt id 2: What country did the F1 driver Lewis Hamilton win his first Grand Prix? Only respond with the country, nothing else.
    (2, 2, 6, 44), -- Prompt node diverging to response node 1
    (2, 2, 6, 45), -- Prompt node diverging to response node 2
    (2, 2, 6, 46), -- Prompt node diverging to response node 3
    (2, 2, 6, 82), -- Prompt node going to LLM scorer prompt node
    (2, 2, 82, 94), -- LLM scorer prompt node going to LLM scorer response node
    (2, 2, 94, 107), -- LLM scorer response node going to LLM scorer evaluator node
    (2, 2, 44, 107), -- Response node 1 going to LLM scorer evaluator node
    (2, 2, 45, 107), -- Response node 2 going to LLM scorer evaluator node
    (2, 2, 46, 107), -- Response node 3 going to LLM scorer evaluator node
    -- Global Node IDs for Simple Evaluator Nodes
    (2, 2, 44, 147), -- Response Node 1 to Simple Evaluator Node 1
    (2, 2, 45, 148), -- Response Node 2 to Simple Evaluator Node 2
    (2, 2, 46, 149), -- Response Node 3 to Simple Evaluator Node 3
    -- Global Node IDs for Code Evaluator Nodes
    (2, 2, 44, 186), -- Response Node 1 to Code Evaluator Node 1
    (2, 2, 45, 187), -- Response Node 2 to Code Evaluator Node 2
    (2, 2, 46, 188); -- Response Node 3 to Code Evaluator Node 3
    
    
    
-- EACH RECORD QUERIES A DIFFERENT MODEL. ONLY 3 MODELS IN DATABASE SO FAR.
INSERT INTO prompt_node (global_node_id, model_id, full_prompt_id, num_responses_per_prompt) VALUES
    (3, 1, 1, 1), --  What country did the F1 driver Charles Leclerc win his first Grand Prix? Only respond with the country, nothing else. BELGIUM
    (4, 2, 1, 1), -- ""
    (5, 3, 1, 1), -- ""
    (6, 1, 2, 1), -- What country did the F1 driver Lewis Hamilton win his first Grand Prix? Only respond with the country, nothing else. CANADA
    (7, 2, 2, 1),  -- ""
    (8, 3, 2, 1),
    (9, 1, 4, 1), -- What country did the F1 driver Michael Schumacher win his first Grand Prix? Only respond with the country, nothing else. BELGIUM
    (10, 2, 4, 1), 
    (11, 3, 4, 1),
    (12, 1, 6, 1), -- What country did the F1 driver Fernando Alonso win his first Grand Prix? Only respond with the country, nothing else. HUNGARY
    (13, 2, 6, 1), 
    (14, 3, 6, 1),
    (15, 1, 8, 1), --  What year did the F1 driver Lewis Hamilton win his last Grand Prix? Only respond with the year, nothing else. 2007
    (16, 2, 8, 1), 
    (17, 3, 8, 1),
    (17, 1, 10, 1), -- What year did the F1 driver Michael Schumacher win his last Grand Prix? Only respond with the year, nothing else. 1992
    (18, 2, 10, 1), 
    (19, 3, 10, 1),
    (20, 1, 12, 1), -- What year did the F1 driver Fernando Alonso win his last Grand Prix? Only respond with the year, nothing else. 2003
    (21, 2, 12, 1), 
    (22, 3, 12, 1),
    (23, 1, 14, 1), -- What nationality is the F1 driver Lewis Hamilton Only respond with the nationality, nothing else. BRITISH
    (24, 2, 14, 1),
    (25, 3, 14, 1),
    (26, 1, 16, 1), -- What nationality is the F1 driver Michael Schumacher Only respond with the nationality, nothing else. GERMAN
    (27, 2, 16, 1),
    (28, 3, 16, 1),
    (29, 1, 18, 1), -- What nationality is the F1 driver Fernando Alonso Only respond with the nationality, nothing else. SPANISH 
    (30, 2, 18, 1),
    (31, 3, 18, 1),
    (32, 1, 20, 1),  -- What country did the F1 driver Lewis Hamilton win his last Grand Prix? Only respond with the country, nothing else. Saudi Arabia
    (33, 2, 20, 1),
    (34, 3, 20, 1),
    (35, 1, 22, 1), -- What country did the F1 driver Michael Schumacher win his last Grand Prix? Only respond with the country, nothing else. CHINA
    (36, 2, 22, 1),
    (37, 3, 22, 1),
    (38, 1, 23, 1), -- What country did the F1 driver Nico Rosberg win his last Grand Prix? Only respond with the country, nothing else. JAPAN
    (39, 2, 23, 1),
    (40, 3, 23, 1);
    
    
-- PLSQL
-- METHOD TO EXTRACT DRIVER INFORMATION FROM JSON OBJECT BASED ON THE TABULAR NODE ID, DRIVER NAME, KEY.
-- Extract THE SPECIFIED KEY FOR THE DRIVER USING THE INDEX BASED ON NAME MAPPING TO JSON ARRAY 
-- example to return what country charles leclerc had his first win (uncomment following line to test:)
-- SELECT GetDriverInfo(1, 'Charles Leclerc', 'first win') AS charles_leclerc_first_win_country;
DELIMITER $$
CREATE FUNCTION GetDriverInfo(
    tabular_data_id_param INT,
    driver_param VARCHAR(255),
    key_param VARCHAR(255)
) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE driver_index INT;
    DECLARE result VARCHAR(255);

    SET driver_index := (
        SELECT array_index 
        FROM driver_index_mapping 
        WHERE driver = driver_param
    );

    SET result := (
        SELECT JSON_EXTRACT(JSON_EXTRACT(records, CONCAT('$[', driver_index, ']')), CONCAT('$."', key_param, '"'))
        FROM tabular_data_node
        WHERE tabular_data_id = tabular_data_id_param);

    RETURN REPLACE(result, '"', '');
END$$
DELIMITER ;

-- SAMPLE FUNCTION IMPLEMENTATION 
SELECT getDriverInfo(1, "Charles Leclerc", 'nationality');


-- CAN BE MANY TO 1 WITH REPECT TO PROMPT_NODE_ID. IF NUMBER OF RESPONSES IS 2 THEN 2 RESPONSES PER PROMPT NODE RECORD, MORE RESPONSES GIVES BETTER MODEL ACCURACY.
CREATE TABLE response_node (
response_node_id INT PRIMARY KEY AUTO_INCREMENT,
global_node_id INT,
prompt_node_id INT,
model_id INT,
response VARCHAR(255),
FOREIGN KEY (global_node_id) REFERENCES global_nodes(global_node_id),
FOREIGN KEY (prompt_node_id) REFERENCES prompt_node(prompt_node_id),
FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- -------------- LIST OF SIMULATED RESPONSES OF MODELS BASED ON MODEL ID --------------------
INSERT INTO response_node (global_node_id, prompt_node_id, model_id, response) VALUES
	(41, 1, 1, 'Belgium'), 
	(42, 1, 2, 'Belgium'), 
	(43, 1, 3, 'Belgium'), 
    (44, 2, 1, 'Canada'),
    (45, 2, 2, 'Canada'), 
    (46, 2, 3, 'Quebec'), -- wrong 3 for simple evaluator, llm_evaluator
    (47, 4, 1, 'Belgium'), 
    (48, 4, 2, 'Belgium'), 
    (49, 4, 3, 'Spa'), -- wrong 3 for simple evaluator, llm_evaluator
    (50, 6, 1, 'Hungery'), -- wrong 1 simple, llm_evaluator, correct code
    (51, 6, 2, 'Hungary'), 
    (52, 6, 3, 'Hungary'),
    (53, 8, 1, '2021'), 
	(54, 8, 2, '2021'), 
	(55, 8, 3, '2011'),  -- wrong 3 simple, llm_evaluator, correct for code evaluator -15
    (56, 10, 1, '2006'), 
    (57, 10, 2, '2006'),  
    (58, 10, 3, '2006'),
    (59, 12, 1, '2013'),
    (60, 12, 2, '2003'),  -- wrong 2 simple, llm_evaluator, correct for code_evaluator
    (61, 12, 3, '2013'), 
    (62, 14, 1, 'English'), -- wrong 1 for simple, llm_evaluator,correct for code
    (63, 14, 2, 'British'), 
    (64, 14, 3, 'British'),
    (65, 16, 1, 'German'), 
	(66, 16, 2, 'German'), 
	(67, 16, 3, 'Australian'), -- wrong for simple, llm_evaluator, wrong for code
    (68, 18, 1, 'Spanish'), 
    (69, 18, 2, 'Spanish'), 
    (70, 18, 3, 'Spanish'),
    (71, 20, 1, 'Saudi Arabia'), 
    (72, 20, 2, 'Saudi Arabia'), 
    (73, 20, 3, 'Saudi Arabia'), 
    (74, 22, 1, 'China'), 
    (75, 22, 2, 'China'), 
    (76, 22, 3, 'China'),
    (77, 23, 1, 'Corean'),  -- wrong 1 for simple, llm_evaluator, and code
	(78, 23, 2, 'Japan'), 
	(79, 23, 3, 'Japan');

 --  --------------------DEFAULT MODEL LOGIC-------------------------------------
 -- REFERENCES THE model_id 4 (gpt4) FROM models TABLE. 
 -- THIS TABLE WAS CREATED FOR SCALABILITY AND CUSTOMIZABILITY. 
 -- THERE MAY BE FUTURE DEFAULT MODELS OR THERE MAY BE A NEED TO ADD MORE OR UPDATE THE CURRENT ONE
CREATE TABLE default_model (
    default_model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT,
    temperature FLOAT DEFAULT 0 NOT NULL,
    FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- default temperature setting of 0
INSERT INTO default_model (model_id) VALUES 
	(4);


--  --------------------LLM SCORER PROMPT NODE LOGIC-------------------------------------
-- queries the default llm model with a temperature 0 for accurate answer to prompt.
CREATE TABLE llm_scorer_prompt_node (
    llm_scorer_prompt_node_id INT PRIMARY KEY AUTO_INCREMENT,
    global_node_id INT,
    prompt_node_id INT,
    default_model_id INT,
    FOREIGN KEY (global_node_id) REFERENCES global_nodes(global_node_id),
    FOREIGN KEY (prompt_node_id) REFERENCES prompt_node(prompt_node_id),
    FOREIGN KEY (default_model_id) REFERENCES models(model_id)
);

INSERT INTO llm_scorer_prompt_node (global_node_id, default_model_id, prompt_node_id) VALUES
	(80, 1, 1),
    (81, 1, 2),
    (82, 1, 4),
	(83, 1, 6),
    (84, 1, 8),
    (85, 1, 10),
    (86, 1, 12),
	(87, 1, 14),
    (88, 1, 16),
    (89, 1, 18),
    (90, 1, 20),
	(91, 1, 22),
    (92, 1, 23);

--  -----------------------------LLM SCORER PROMPT RESPONSE NODE -----------------------------
-- SIMULATED A RETURN OF CORRECT ACCURATE VALUES FROM DEFAULT LLM TO USE AS LLM SCORER (GPT4)
CREATE TABLE llm_scorer_response_node (
	llm_scorer_response_id INT PRIMARY KEY AUTO_INCREMENT,
    global_node_id INT,
    llm_scorer_prompt_node_id INT,
    default_model_id INT ,
    response VARCHAR(45),
    FOREIGN KEY (global_node_id) REFERENCES global_nodes(global_node_id),
    FOREIGN KEY (llm_scorer_prompt_node_id) REFERENCES llm_scorer_prompt_node(llm_scorer_prompt_node_id),
    FOREIGN KEY (default_model_id) REFERENCES default_model(default_model_id)
);

-- correct answers to prompt node ids
INSERT INTO llm_scorer_response_node (global_node_id, llm_scorer_prompt_node_id, default_model_id, response) VALUES
	(93, 1, 1, 'Belgium'),
    (94, 2, 1, 'Canada'),
    (95, 3, 1, 'Belgium'),
	(96, 4, 1, 'Hungary'),
    (97, 5, 1, '2021'),
    (98, 6, 1, '2006'),
    (99, 7, 1, '2013'),
	(100, 8, 1, 'British'),
    (101, 9, 1, 'German'),
    (102, 10, 1, 'Spanish'),
    (103, 11, 1, 'Saudi Arabia'),
	(104, 12, 1, 'China'),
    (105, 13, 1, 'Japan');
    
    
-- ---------------LLM SCORER EVAULATOR LOGIC-------------------------------------
-- STORES THE RESULT OF COMPARISON BETWEEN CORRECT llm_scorer_response_node.response AND response_node.response 
CREATE TABLE llm_scorer_evaluator_node (
    llm_scorer_evaluator_id INT PRIMARY KEY AUTO_INCREMENT,
    global_node_id INT,
    response_node_id INT NOT NULL,
    llm_scorer_response_id INT NOT NULL,
    result BOOLEAN NOT NULL,
	FOREIGN KEY (global_node_id) REFERENCES global_nodes(global_node_id),
    FOREIGN KEY (response_node_id) REFERENCES response_node(response_node_id),
    FOREIGN KEY (llm_scorer_response_id) REFERENCES llm_scorer_response_node(llm_scorer_response_id)
);

-- TABLE USED TO DEBUG ERRORS IN PLSQL FUNCTIONS. 
CREATE TABLE debug (
	message VARCHAR(255)
);


-- COMPARES llm_scorer_response_node.response AND response_node.response 
-- RETURNS 1 IF THEY ARE EQUAL, 0 OTHERWISE
DELIMITER //
CREATE FUNCTION isDefaultLLMEvalComparison(response_node_id INT, llm_scorer_response_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE result BOOLEAN;

    SELECT CASE WHEN EXISTS (
        SELECT 1
        FROM response_node re
        JOIN llm_scorer_response_node lsr ON re.response = lsr.response
        WHERE re.response_node_id = response_node_id
		AND lsr.llm_scorer_response_id = llm_scorer_response_id
    ) THEN TRUE ELSE FALSE END INTO result;

    RETURN result;
END//
DELIMITER ;

SELECT isDefaultLLMEvalComparison(1, 1);

-- instead of this:
-- true is 1 and false is 0\
-- INSERT INTO llm_scorer_evaluator_node (global_node_id, response_node_id, llm_scorer_response_id, result) VALUES
-- 		   (11, 1, 1, 0),
--         (12, 2, 1, 0),
--         (13, 3, 1, 0);
-- we can call the isDefaultLLMEvalComparison method which returns a boolean result based on comparison of the reponses 
-- the reponses from the model responses and the default (correct) model response (temperature 0)

INSERT INTO llm_scorer_evaluator_node (global_node_id, response_node_id, llm_scorer_response_id, result)
VALUES
    (106, 1, 1, isDefaultLLMEvalComparison(1, 1)),
    (107, 2, 1, isDefaultLLMEvalComparison(2, 1)),
    (108, 3, 1, isDefaultLLMEvalComparison(3, 1)),
    (109, 4, 2, isDefaultLLMEvalComparison(4, 2)),
    (110, 5, 2, isDefaultLLMEvalComparison(5, 2)),
    (111, 6, 2, isDefaultLLMEvalComparison(6, 2)),
    (112, 7, 3, isDefaultLLMEvalComparison(7, 3)),
    (113, 8, 3, isDefaultLLMEvalComparison(8, 3)),
    (114, 9, 3, isDefaultLLMEvalComparison(9, 3)),
    (115, 10, 4, isDefaultLLMEvalComparison(10, 4)),
    (116, 11, 4, isDefaultLLMEvalComparison(11, 4)),
    (117, 12, 4, isDefaultLLMEvalComparison(12, 4)),
    (118, 13, 5, isDefaultLLMEvalComparison(13, 5)),
    (119, 14, 5, isDefaultLLMEvalComparison(14, 5)),
    (120, 15, 5, isDefaultLLMEvalComparison(15, 5)),
    (121, 16, 6, isDefaultLLMEvalComparison(16, 6)),
    (121, 17, 6, isDefaultLLMEvalComparison(17, 6)),
    (122, 18, 6, isDefaultLLMEvalComparison(18, 6)),
    (123, 19, 7, isDefaultLLMEvalComparison(19, 7)),
    (124, 20, 7, isDefaultLLMEvalComparison(20, 7)),
    (125, 21, 7, isDefaultLLMEvalComparison(21, 7)),
    (126, 22, 8, isDefaultLLMEvalComparison(22, 8)),
    (127, 23, 8, isDefaultLLMEvalComparison(23, 8)),
    (128, 24, 8, isDefaultLLMEvalComparison(24, 8)),
    (129, 25, 9, isDefaultLLMEvalComparison(25, 9)),
    (130, 26, 9, isDefaultLLMEvalComparison(26, 9)),
    (131, 27, 9, isDefaultLLMEvalComparison(27, 9)),
    (132, 28, 10, isDefaultLLMEvalComparison(28, 10)),
    (133, 29, 10, isDefaultLLMEvalComparison(29, 10)),
    (134, 30, 10, isDefaultLLMEvalComparison(30, 10)),
    (135, 31, 11, isDefaultLLMEvalComparison(31, 11)),
    (136, 32, 11, isDefaultLLMEvalComparison(32, 11)),
    (127, 33, 11, isDefaultLLMEvalComparison(33, 11)),
    (138, 34, 12, isDefaultLLMEvalComparison(34, 12)),
    (139, 35, 12, isDefaultLLMEvalComparison(35, 12)),
    (140, 36, 12, isDefaultLLMEvalComparison(36, 12)),
    (141, 37, 13, isDefaultLLMEvalComparison(37, 13)),
    (142, 38, 13, isDefaultLLMEvalComparison(38, 13)),
    (143, 39, 13, isDefaultLLMEvalComparison(39, 13));


-- INSERTION OF ALL THE CONNECTIONS TO FORM THE GRAPH IN EACH CHAIN.
-- RECORDS CAN CONVERGE AND DIVERGE TO NEXT RECORD/NODE_ID
INSERT INTO chain_node_connections(chain_id, prompt_node_id, source_node_id, next_node_id) VALUES
	-- What country did the F1 driver Charles Leclerc win his first Grand Prix? Only respond with the country, nothing else.
    (1, 1, 3, 41), -- prompt node diverging to response nodes
    (1, 1, 3, 42),
    (1, 1, 3, 43), -- ""
    (1, 1, 3, 80), -- prompt node going to llm_scorer_prompt_node
	(1, 1, 80, 93), --  llm_scorer_prompt_node going to llm scorer response node
    (1, 1, 93, 106), -- llm scorer response node going to llm scorer evaluator node
    (1, 1, 41, 106), -- response nodes going to llm scorer evaluator node
    (1, 1, 42, 106),
    (1, 1, 43, 106), -- ""
    -- What country did the F1 driver Lewis Hamilton win his first Grand Prix? Only respond with the country, nothing else.
    (2, 2, 6, 44),
    (2, 2, 6, 45),
    (2, 2, 6, 46),
    (2, 2, 6, 82),
    (2, 2, 82, 94),
    (2, 2, 94, 107),
    (2, 2, 44, 107),
    (2, 2, 45, 107),
    (2, 2, 46, 107);
    

 
-- -------------------------SIMPLE EVAULATOR NODE LOGIC-------------------------------------

CREATE TABLE simple_evaluator_node (
    simple_evaluator_id INT PRIMARY KEY AUTO_INCREMENT,
    global_node_id INT,
    response_node_id INT NOT NULL,
    tabular_data_id INT NOT NULL,
    result BOOLEAN NOT NULL,
	FOREIGN KEY (global_node_id) REFERENCES global_nodes(global_node_id),
    FOREIGN KEY (response_node_id) REFERENCES response_node(response_node_id),
    FOREIGN KEY (tabular_data_id) REFERENCES tabular_data_node(tabular_data_id)
);
-- used to compare varchars
ALTER TABLE response_node ADD FULLTEXT(response);


-- CHECK FOR SIMPLE EVALUATOR RESPONSES
-- COMPARES the respones_node.response with VARCHAR driver_info FOR EVERY RESPONSE, DEPENDS ON THE reponse_id (primary superkey) and
-- RETURNS 1 IF THE ITEMS ARE EQUAL, 0 OTHERWISE
DELIMITER $$
CREATE FUNCTION simple_eval(response_node_id INT, driver_info VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE result BOOLEAN;
    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM response_node
        WHERE response_node.response_node_id = response_node_id
		AND MATCH(response_node.response) AGAINST (driver_info)
    ) THEN TRUE ELSE FALSE END INTO result;

    RETURN result;
END$$
DELIMITER ;

SELECT simple_eval(1, "China");
SELECT simple_eval(1, "Belgium");


SELECT getDriverInfo(1, "Charles Leclerc", 'first win');

-- COMPARES THE RESPONSE WITH THE CORRECT ANSWER FROM THE JSON OBJECT THE DATABASE.
-- DEPENDS ON response_node_id, tabular_data_node_id, driver and specific key.
-- INTEGRATES THE METHOD GetDriverInfo and checkLength FUNCTIONS AND RETURNS A BOOLEAN RESULT, 1 IF CORRECT, 0 IF FALSE.
DELIMITER $$
CREATE FUNCTION isSimpleEvalComparison(
    response_node_id INT,
    tabular_data_node_id INT,
    driver VARCHAR(255),
    key_param VARCHAR(255)
) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE driver_info VARCHAR(255);
    DECLARE result BOOLEAN;

    SET driver_info := GetDriverInfo(tabular_data_node_id, driver, key_param);
	INSERT INTO debug VALUES (driver_info);
    SET result := simple_eval(response_node_id, driver_info);

    RETURN result;
END$$
DELIMITER ;

-- SAMPLE FUNCTION IMPLEMENTATION
SELECT isSimpleEvalComparison(1, 1, 'Charles Leclerc', 'first win');


INSERT INTO simple_evaluator_node (global_node_id, response_node_id, tabular_data_id, result)
VALUES
    (144, 1, 1, isSimpleEvalComparison(1, 1, 'Charles Leclerc', 'first win')),
    (145, 2, 1, isSimpleEvalComparison(2, 1, 'Charles Leclerc', 'first win')),
    (146, 3, 1, isSimpleEvalComparison(3, 1, 'Charles Leclerc', 'first win')),
	(147, 4, 1, isSimpleEvalComparison(4, 1, 'Lewis Hamilton', 'first win')),
    (148, 5, 1, isSimpleEvalComparison(5, 1, 'Lewis Hamilton', 'first win')),
    (149, 6, 1, isSimpleEvalComparison(6, 1, 'Lewis Hamilton', 'first win')),
    (150, 7, 1, isSimpleEvalComparison(7, 1, 'Michael Schumacher', 'first win')),
    (151, 8, 1, isSimpleEvalComparison(8, 1, 'Michael Schumacher', 'first win')),
    (152, 9, 1, isSimpleEvalComparison(9, 1, 'Michael Schumacher', 'first win')),
    (153, 10, 1, isSimpleEvalComparison(10, 1, 'Fernando Alonso', 'first win')),
    (154, 11, 1, isSimpleEvalComparison(11, 1, 'Fernando Alonso', 'first win')),
    (155, 12, 1, isSimpleEvalComparison(12, 1, 'Fernando Alonso', 'first win')),
    (156, 13, 1, isSimpleEvalComparison(13, 1, 'Lewis Hamilton', 'last win year')),
    (157, 14, 1, isSimpleEvalComparison(14, 1, 'Lewis Hamilton', 'last win year')),
    (158, 15, 1, isSimpleEvalComparison(15, 1, 'Lewis Hamilton', 'last win year')),
    (159, 16, 1, isSimpleEvalComparison(16, 1, 'Michael Schumacher', 'last win year')),
    (160, 17, 1, isSimpleEvalComparison(17, 1, 'Michael Schumacher', 'last win year')),
    (161, 18, 1, isSimpleEvalComparison(18, 1, 'Michael Schumacher', 'last win year')),
    (162, 19, 1, isSimpleEvalComparison(19, 1, 'Fernando Alonso', 'last win year')),
    (163, 20, 1, isSimpleEvalComparison(20, 1, 'Fernando Alonso', 'last win year')),
    (164, 21, 1, isSimpleEvalComparison(21, 1, 'Fernando Alonso', 'last win year')),
    (165, 22, 1, isSimpleEvalComparison(22, 1, 'Lewis Hamilton', 'nationality')),
    (166, 23, 1, isSimpleEvalComparison(23, 1, 'Lewis Hamilton', 'nationality')),
    (167, 24, 1, isSimpleEvalComparison(24, 1, 'Lewis Hamilton', 'nationality')),
    (168, 25, 1, isSimpleEvalComparison(25, 1, 'Michael Schumacher', 'nationality')),
    (169, 26, 1, isSimpleEvalComparison(26, 1, 'Michael Schumacher', 'nationality')),
    (170, 27, 1, isSimpleEvalComparison(27, 1, 'Michael Schumacher', 'nationality')), -- 16
    (171, 28, 1, isSimpleEvalComparison(28, 1, 'Fernando Alonso', 'nationality')),
    (172, 29, 1, isSimpleEvalComparison(29, 1, 'Fernando Alonso', 'nationality')),
    (173, 30, 1, isSimpleEvalComparison(30, 1, 'Fernando Alonso', 'nationality')),
 	(174, 31, 1, isSimpleEvalComparison(31, 1, 'Lewis Hamilton', 'last win')), -- 20 country of last win
    (175, 32, 1, isSimpleEvalComparison(32, 1, 'Lewis Hamilton', 'last win')),
    (176, 33, 1, isSimpleEvalComparison(33, 1, 'Lewis Hamilton', 'last win')),
    (177, 34, 1, isSimpleEvalComparison(34, 1, 'Michael Schumacher', 'last win')), -- 22
    (178, 35, 1, isSimpleEvalComparison(35, 1, 'Michael Schumacher', 'last win')),
    (179, 36, 1, isSimpleEvalComparison(36, 1, 'Michael Schumacher', 'last win')),
    (180, 37, 1, isSimpleEvalComparison(37, 1, 'Nico Rosberg', 'last win')), -- 23
    (181, 38, 1, isSimpleEvalComparison(38, 1, 'Nico Rosberg', 'last win')),
    (182, 39, 1, isSimpleEvalComparison(39, 1, 'Nico Rosberg', 'last win'));



-- ---------------CODE EVAULATOR NODE LOGIC-------------------------------------
    
CREATE TABLE code_evaluator_node (
    code_evaluator_id INT PRIMARY KEY AUTO_INCREMENT,
    global_node_id INT,
    response_node_id INT NOT NULL,
    tabular_data_id INT NOT NULL,
    result BOOLEAN NOT NULL,
	FOREIGN KEY (global_node_id) REFERENCES global_nodes(global_node_id),
    FOREIGN KEY (response_node_id) REFERENCES response_node(response_node_id),
    FOREIGN KEY (tabular_data_id) REFERENCES tabular_data_node(tabular_data_id)
);


-- BASIC EVALUATION, THIS SHOULD RETURN TRUE IF:
-- THE LENGTH OF EACH STRING IS EQUAL,
-- OTHERWISE FALSE
DELIMITER $$
CREATE FUNCTION checkLength(response_node_id INT, driver_info VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE result BOOLEAN;

    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM response_node re
        WHERE re.response_node_id = response_node_id
		AND LENGTH(re.response) = LENGTH(driver_info)
    ) THEN TRUE ELSE FALSE END INTO result;

    RETURN result;
END$$
DELIMITER ;

SELECT checkLength(1, "ahre");
SELECT checkLength(1, "asmgome");
SELECT checkLength(1, "Belgium");


-- COMPARES THE RESPONSE WITH THE CORRECT ANSWER FROM THE JSON OBJECT THE DATABASE.
-- DEPENDS ON response_node_id, tabular_data_node_id, driver and specific key.
-- INTEGRATES THE METHOD GetDriverInfo and checkLength FUNCTIONS AND RETURNS A BOOLEAN RESULT
DELIMITER $$
CREATE FUNCTION isCodeEvalComparison(
    response_node_id INT,
	tabular_data_node_id INT,
	driver VARCHAR(255),
	key_param VARCHAR(255)
) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE driver_info VARCHAR(255);
    DECLARE result BOOLEAN;

    SET driver_info := GetDriverInfo(tabular_data_node_id, driver, key_param);
    SET result := checkLength(response_node_id, driver_info);

    RETURN result;
END$$
DELIMITER ;

-- -----------INSERTING VALUES INTO THE TABLE FOR VISUALISATION LATER -----------
INSERT INTO code_evaluator_node (global_node_id, response_node_id, tabular_data_id, result)
VALUES
    (183, 1, 1, isCodeEvalComparison(1, 1, 'Charles Leclerc', 'first win')),
    (184, 2, 1, isCodeEvalComparison(2, 1, 'Charles Leclerc', 'first win')),
    (185, 3, 1, isCodeEvalComparison(3, 1, 'Charles Leclerc', 'first win')),
	(186, 4, 1, isCodeEvalComparison(4, 1, 'Lewis Hamilton', 'first win')),
    (187, 5, 1, isCodeEvalComparison(5, 1, 'Lewis Hamilton', 'first win')),
    (188, 6, 1, isCodeEvalComparison(6, 1, 'Lewis Hamilton', 'first win')),
    (189, 7, 1, isCodeEvalComparison(7, 1, 'Michael Schumacher', 'first win')),
    (190, 8, 1, isCodeEvalComparison(8, 1, 'Michael Schumacher', 'first win')),
    (191, 9, 1, isCodeEvalComparison(9, 1, 'Michael Schumacher', 'first win')),
    (192, 10, 1, isCodeEvalComparison(10, 1, 'Fernando Alonso', 'first win')),
    (193, 11, 1, isCodeEvalComparison(11, 1, 'Fernando Alonso', 'first win')),
    (194, 12, 1, isCodeEvalComparison(12, 1, 'Fernando Alonso', 'first win')),
    (195, 13, 1, isCodeEvalComparison(13, 1, 'Lewis Hamilton', 'last win year')), -- 
    (196, 14, 1, isCodeEvalComparison(14, 1, 'Lewis Hamilton', 'last win year')),
    (197, 15, 1, isCodeEvalComparison(15, 1, 'Lewis Hamilton', 'last win year')),
    (198, 16, 1, isCodeEvalComparison(16, 1, 'Michael Schumacher', 'last win year')),
    (199, 17, 1, isCodeEvalComparison(17, 1, 'Michael Schumacher', 'last win year')),
    (200, 18, 1, isCodeEvalComparison(18, 1, 'Michael Schumacher', 'last win year')),
    (201, 19, 1, isCodeEvalComparison(19, 1, 'Fernando Alonso', 'last win year')),
    (202, 20, 1, isCodeEvalComparison(20, 1, 'Fernando Alonso', 'last win year')),
    (203, 21, 1, isCodeEvalComparison(21, 1, 'Fernando Alonso', 'last win year')), -- 
    (204, 22, 1, isCodeEvalComparison(22, 1, 'Lewis Hamilton', 'nationality')),
    (205, 23, 1, isCodeEvalComparison(23, 1, 'Lewis Hamilton', 'nationality')),
    (206, 24, 1, isCodeEvalComparison(24, 1, 'Lewis Hamilton', 'nationality')),
    (207, 25, 1, isCodeEvalComparison(25, 1, 'Michael Schumacher', 'nationality')),
    (208, 26, 1, isCodeEvalComparison(26, 1, 'Michael Schumacher', 'nationality')),
    (209, 27, 1, isCodeEvalComparison(27, 1, 'Michael Schumacher', 'nationality')), -- 16
    (210, 28, 1, isCodeEvalComparison(28, 1, 'Fernando Alonso', 'nationality')),
    (211, 29, 1, isCodeEvalComparison(29, 1, 'Fernando Alonso', 'nationality')),
    (212, 30, 1, isCodeEvalComparison(30, 1, 'Fernando Alonso', 'nationality')),
 	(213, 31, 1, isCodeEvalComparison(31, 1, 'Lewis Hamilton', 'last win')), -- country of last win 
    (214, 32, 1, isCodeEvalComparison(32, 1, 'Lewis Hamilton', 'last win')),
    (215, 33, 1, isCodeEvalComparison(33, 1, 'Lewis Hamilton', 'last win')),
    (216, 34, 1, isCodeEvalComparison(34, 1, 'Michael Schumacher', 'last win')), -- 22
    (217, 35, 1, isCodeEvalComparison(35, 1, 'Michael Schumacher', 'last win')),
    (218, 36, 1, isCodeEvalComparison(36, 1, 'Michael Schumacher', 'last win')),
    (219, 37, 1, isCodeEvalComparison(37, 1, 'Nico Rosberg', 'last win')), -- 23
    (220, 38, 1, isCodeEvalComparison(38, 1, 'Nico Rosberg', 'last win')),
    (221, 39, 1, isCodeEvalComparison(39, 1, 'Nico Rosberg', 'last win'));


SELECT isSimpleEvalComparison(1, 1, 'Charles Leclerc', 'first win');
SELECT isCodeEvalComparison(1, 1, 'Charles Leclerc', 'first win');



SELECT * FROM debug;

-- -----------------------VIEWS---------------------------------


-- -----------------SHOW PERFORMANCE ACCURACY PER MODEL-----------------
CREATE VIEW viz_llm_scorer_evaluator_node_with_company AS
    SELECT mc.model_id AS model_id,
        mc.company_name AS Company_Name,
        mc.established_date AS Company_Established_Date,
        mc.company_address AS Company_Address,
        mc.ceo AS CEO,
        m.model_name AS Model_Name,
        CONCAT(ROUND((COUNT(CASE WHEN lse.result = TRUE THEN 1 END) / COUNT(*)) * 100, 2),'%') AS Model_Accuracy
    FROM response_node re
    JOIN llm_scorer_evaluator_node lse ON re.response_node_id = lse.response_node_id
    JOIN models m ON re.model_id = m.model_id
    JOIN model_company mc ON m.model_id = mc.model_id
    GROUP BY mc.model_id
    ORDER BY model_id ASC;

CREATE VIEW viz_simple_evaluator_node_with_company AS
   SELECT mc.model_id AS model_id,
        mc.company_name AS Company_Name,
        mc.established_date AS Company_Established_Date,
        mc.company_address AS Company_Address,
        mc.ceo AS CEO,
        m.model_name AS Model_Name, CONCAT(ROUND((COUNT(CASE WHEN se.result = TRUE THEN 1 END) / COUNT(*)) * 100, 2),'%') AS Model_Accuracy
    FROM response_node re
    JOIN simple_evaluator_node se ON re.response_node_id = se.response_node_id
    JOIN models m ON re.model_id = m.model_id
    JOIN model_company mc ON m.model_id = mc.model_id
    GROUP BY mc.model_id
    ORDER BY model_id ASC;

CREATE VIEW viz_code_evaluator_node_with_company AS
    SELECT mc.model_id AS model_id,
        mc.company_name AS Company_Name,
        mc.established_date AS Company_Established_Date,
        mc.company_address AS Company_Address,
        mc.ceo AS CEO,
        m.model_name AS Model_Name,
        CONCAT(ROUND((COUNT(CASE WHEN ce.result = TRUE THEN 1 END) / COUNT(*)) * 100, 2),'%') AS Model_Accuracy
    FROM response_node re
    JOIN code_evaluator_node ce ON re.response_node_id = ce.response_node_id
    JOIN models m ON re.model_id = m.model_id
    JOIN model_company mc ON m.model_id = mc.model_id
    GROUP BY mc.model_id
    ORDER BY model_id ASC;
    	
    
-- -----------------SHOW THE PERFORMANCE OF MODEL ACCURACY BY INDIVIDUAL PROMPTS-----------------
CREATE VIEW viz_llm_scorer_evaluator_node_per_prompt AS
    SELECT pn.full_prompt_id AS Prompt_ID,
        m.model_name AS Model_Name,
        re.model_id AS model_id,
        CONCAT(ROUND((COUNT(CASE WHEN lse.result = TRUE THEN 1 END) / COUNT(*)) * 100, 2),'%') AS Model_Accuracy
    FROM response_node re
    JOIN prompt_node pn ON re.prompt_node_id = pn.prompt_node_id
    JOIN llm_scorer_evaluator_node lse ON re.response_node_id = lse.response_node_id
    JOIN models m ON re.model_id = m.model_id
    GROUP BY pn.full_prompt_id, re.model_id
    ORDER BY Model_Accuracy = 0 DESC, Model_Accuracy DESC;
    
    
    
CREATE VIEW viz_simple_evaluator_node_per_prompt AS
    SELECT pn.full_prompt_id AS Prompt_ID,
        m.model_name AS Model_Name,
        re.model_id AS model_id,
        CONCAT(ROUND((COUNT(CASE WHEN se.result = TRUE THEN 1 END) / COUNT(*)) * 100, 2),'%') AS Model_Accuracy
    FROM response_node re
    JOIN prompt_node pn ON re.prompt_node_id = pn.prompt_node_id
    JOIN simple_evaluator_node se ON re.response_node_id = se.response_node_id
    JOIN models m ON re.model_id = m.model_id
    GROUP BY pn.full_prompt_id, re.model_id
    ORDER BY Model_Accuracy = 0 DESC, Model_Accuracy DESC;


CREATE VIEW viz_code_evaluator_node_per_prompt AS
    SELECT pn.full_prompt_id AS Prompt_ID,
        m.model_name AS Model_Name,
        re.model_id AS model_id,
        CONCAT(ROUND((COUNT(CASE WHEN ce.result = TRUE THEN 1 END) / COUNT(*)) * 100, 2),'%') AS Model_Accuracy
    FROM response_node re
    JOIN prompt_node pn ON re.prompt_node_id = pn.prompt_node_id
    JOIN code_evaluator_node ce ON re.response_node_id = ce.response_node_id
    JOIN models m ON re.model_id = m.model_id
    GROUP BY pn.full_prompt_id, re.model_id
    ORDER BY Model_Accuracy = 0 DESC, Model_Accuracy DESC;
  
-- ------------------------SIGN UP VIEW. ------------------------
-- gathers the information for a resgistration email to be sent to user.
CREATE VIEW sign_up_view AS
	SELECT 
		u.user_id,
		u.username,
		ui.forename,
		ui.surname,
		u.password_,
		u.email,
		u.created AS registration_date,
		ui.date_of_birth,
		r.staff_type AS role,
		ak.api_key,
		m.model_name,
		mc.company_name AS company
	FROM users u
	JOIN user_info ui ON u.user_id = ui.user_id
	JOIN roles r ON ui.role_id = r.role_id
	LEFT JOIN api_keys ak ON u.user_id = ak.user_id
	LEFT JOIN models m ON ak.model_id = m.model_id
	LEFT JOIN model_company mc ON m.model_id = mc.model_id;

    
-- -----------------SHOW PERFORMANCE ACCURACY PER MODEL WITH COMPANY INFORMATION-----------------
SELECT * FROM viz_llm_scorer_evaluator_node_with_company;
SELECT * FROM viz_simple_evaluator_node_with_company;
SELECT * FROM viz_code_evaluator_node_with_company;
    
    
-- -----------------SHOW THE PERFORMANCE OF MODEL ACCURACY BY INDIVIDUAL PROMPTS-----------------
SELECT * FROM viz_llm_scorer_evaluator_node_per_prompt;
SELECT * FROM viz_simple_evaluator_node_per_prompt;
SELECT * FROM viz_code_evaluator_node_per_prompt;
 
 -- ---------------SHOW VIEW WHEN YOU SIGN UP FOR A MODEL ACCOUNT------------------------
SELECT * FROM sign_up_view;

   
-- ---- FUNCTION WHICH SENDS A REGISTRATION EMAIL TO THE EMAIL ADDRESS OF THE USER -----
CALL sendBulkRegistrationEmails();




-- --------------------------------------------------------------QUERIES------------------------------------------------------------
-- --------------------------------------------------------------QUERY 1------------------------------------------------------------
-- --------------------SHOWS AN OVERVIEW OF ALL THE SPECIFIC NODE IDS WHICH ARE ASSOCIATED WITH ONE PROMPT NODE ID------------------
-- ------------------------------EACH PROMPT NODE ID IS A SPECIFIC QUESTION ASKED --------------------------------------------------
-- ---------------------------------------------E.G. PROMPT_NODE_ID 12:------------------------------------------------------------- 
-- -------"What year did the F1 driver Fernando Alonso win his last Grand Prix? Only respond with the year, nothing else".---------
SELECT
    pn1.prompt_node_id AS prompt_node_id,
    pn1.global_node_id AS prompt_global_node_id,
    GROUP_CONCAT(DISTINCT rn1.response_node_id ORDER BY rn1.response_node_id) AS response_node_ids,
    GROUP_CONCAT(DISTINCT rn1.global_node_id ORDER BY rn1.response_node_id) AS response_global_node_ids,
    GROUP_CONCAT(DISTINCT sen1.simple_evaluator_id ORDER BY sen1.simple_evaluator_id) AS simple_evaluator_node_ids,
    GROUP_CONCAT(DISTINCT sen1.global_node_id ORDER BY sen1.simple_evaluator_id) AS simple_evaluator_global_node_ids,
    GROUP_CONCAT(DISTINCT cen1.code_evaluator_id ORDER BY cen1.code_evaluator_id) AS code_evaluator_node_ids,
    GROUP_CONCAT(DISTINCT cen1.global_node_id ORDER BY cen1.code_evaluator_id) AS code_evaluator_global_node_ids,
    GROUP_CONCAT(DISTINCT lsn1.llm_scorer_prompt_node_id ORDER BY lsn1.llm_scorer_prompt_node_id) AS llm_scorer_prompt_node_ids,
    GROUP_CONCAT(DISTINCT lsn1.global_node_id ORDER BY lsn1.llm_scorer_prompt_node_id) AS llm_scorer_prompt_global_node_ids,
    GROUP_CONCAT(DISTINCT lsrn1.llm_scorer_response_id ORDER BY lsrn1.llm_scorer_response_id) AS llm_scorer_response_node_ids,
    GROUP_CONCAT(DISTINCT lsrn1.global_node_id ORDER BY lsrn1.llm_scorer_response_id) AS llm_scorer_response_global_node_ids,
    GROUP_CONCAT(DISTINCT lsen1.llm_scorer_evaluator_id ORDER BY lsen1.llm_scorer_evaluator_id) AS llm_scorer_evaluator_node_ids,
    GROUP_CONCAT(DISTINCT lsen1.global_node_id ORDER BY lsen1.llm_scorer_evaluator_id) AS llm_scorer_evaluator_global_node_ids
FROM prompt_node pn1
JOIN response_node rn1 ON pn1.prompt_node_id = rn1.prompt_node_id
JOIN simple_evaluator_node sen1 ON rn1.response_node_id = sen1.response_node_id
JOIN code_evaluator_node cen1 ON rn1.response_node_id = cen1.response_node_id
JOIN llm_scorer_prompt_node lsn1 ON pn1.prompt_node_id = lsn1.prompt_node_id
JOIN llm_scorer_response_node lsrn1 ON lsn1.llm_scorer_prompt_node_id = lsrn1.llm_scorer_prompt_node_id
JOIN llm_scorer_evaluator_node lsen1 ON rn1.response_node_id = lsen1.response_node_id
WHERE pn1.prompt_node_id BETWEEN 1 AND 24
GROUP BY pn1.prompt_node_id;


-- --------------------------------QUERY 2--------------------------------------
-- ------- SHOWS THE SPECIFIC NODE ID, ITS TYPE AND ITS GLOBAL NODE ID------------------
-- -------------------------235 GLOBAL NODES IN TOTAL-----------------------------------
SELECT
CASE
	WHEN gn.node_type = 'Input_Node' THEN inp.input_node_id
	WHEN gn.node_type = 'Tabular_Data_Node' THEN tn.tabular_data_id
	WHEN gn.node_type = 'Prompt_Node' THEN pn.prompt_node_id
	WHEN gn.node_type = 'Response_Node' THEN rn.response_node_id
	WHEN gn.node_type = 'LLM_Scorer_Prompt_Node' THEN lsn.llm_scorer_prompt_node_id
	WHEN gn.node_type = 'LLM_Scorer_Response_Node' THEN lsrn.llm_scorer_response_id
	WHEN gn.node_type = 'LLM_Scorer_Evaluator_Node' THEN lsen.llm_scorer_evaluator_id
	WHEN gn.node_type = 'Simple_Evaluator_Node' THEN sen.simple_evaluator_id
	WHEN gn.node_type = 'Code_Evaluator_Node' THEN cen.code_evaluator_id
	ELSE NULL
END AS specific_node_id,
    gn.node_type,
	gn.global_node_id
FROM global_nodes gn
LEFT JOIN input_node inp ON gn.global_node_id = inp.global_node_id
LEFT JOIN tabular_data_node tn ON gn.global_node_id = tn.global_node_id
LEFT JOIN prompt_node pn ON gn.global_node_id = pn.global_node_id
LEFT JOIN response_node rn ON gn.global_node_id = rn.global_node_id
LEFT JOIN llm_scorer_prompt_node lsn ON gn.global_node_id = lsn.global_node_id
LEFT JOIN llm_scorer_response_node lsrn ON gn.global_node_id = lsrn.global_node_id
LEFT JOIN llm_scorer_evaluator_node lsen ON gn.global_node_id = lsen.global_node_id
LEFT JOIN simple_evaluator_node sen ON gn.global_node_id = sen.global_node_id
LEFT JOIN code_evaluator_node cen ON gn.global_node_id = cen.global_node_id
ORDER BY specific_node_id;


-- -------------------------------QUERY 3--------------------------------------
-- --------- SHOWS THE GRAPH LIKE CONVERGING/DIVERGING NATURE OF THE NODE RECORDS---------
SELECT
    cn.chain_id,
    cn.source_node_id,
    gn.node_type AS source_node_type,
    GROUP_CONCAT(cn.next_node_id ORDER BY cn.prompt_node_id) AS connected_nodes,
	GROUP_CONCAT(gn_next.node_type ORDER BY cn.prompt_node_id) AS connected_node_types
FROM chain_node_connections cn
LEFT JOIN global_nodes gn ON cn.source_node_id = gn.global_node_id
LEFT JOIN global_nodes gn_next ON cn.next_node_id = gn_next.global_node_id
GROUP BY cn.chain_id, cn.source_node_id, gn.node_type;


-- --------------------------------------QUERY 4--------------------------------------
-- -------------------PREDICTIVE ANALYSIS ON MODEL ACCURACY BASED ON FUNCTION
SELECT
    m.model_name,
    mc.company_name,
    YEAR(mc.established_date) AS Year_Established,
    ROUND(DATEDIFF(CURRENT_DATE(), mc.established_date) / 365) AS Years_of_Experience,
    -- Model_Accuracy
    CONCAT( 
        ROUND((COUNT(CASE WHEN lse.result = TRUE THEN 1 END) / COUNT(*)) * 100, 2),'%') AS Model_Accuracy,
	-- Projected_Accuracy_Gain_2025
    CONCAT(
        ROUND((0.2)*((100 - (COUNT(CASE WHEN lse.result = TRUE THEN 1 END) / COUNT(*)) * 100) * (0.5 ^ (1 / (ROUND(DATEDIFF(CURRENT_DATE(), mc.established_date) / 365) + 1)))), 2),
        '%') AS Projected_Accuracy_Gain_2025,
   -- Model_Accuracy + Projected_Accuracy_Gain_2025 = Projected_Cumulative_Accuracy_2025
    CONCAT(
        ROUND(
            ((100 - (COUNT(CASE WHEN lse.result = TRUE THEN 1 END) / COUNT(*)) * 100) * (0.5 ^ (1 / (ROUND(DATEDIFF(CURRENT_DATE(), mc.established_date) / 365) + 1))) / 5 +
                (COUNT(CASE WHEN lse.result = TRUE THEN 1 END) / COUNT(*)) * 100), 2
                ),'%') AS Projected_Cumulative_Accuracy_2025
FROM model_company mc
JOIN models m ON mc.model_id = m.model_id
JOIN response_node re ON m.model_id = re.model_id
JOIN llm_scorer_evaluator_node lse ON re.response_node_id = lse.response_node_id
GROUP BY mc.model_id
ORDER BY mc.model_id;



-- DROP DATABASE IF EXISTS chainforge;
