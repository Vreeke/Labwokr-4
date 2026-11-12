CREATE TABLE users (
    user_id INTEGER NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email_addr VARCHAR(100) NOT NULL,
    user_role_status VARCHAR(20) NOT NULL,
    CONSTRAINT pk_users PRIMARY KEY (user_id),
    CONSTRAINT uk_users_email UNIQUE (email_addr),
    CONSTRAINT chk_users_full_name CHECK (
        full_name ~ '^[A-ZА-ЯІЇЄ][a-zа-яіїє]+(\s[A-ZА-ЯІЇЄ][a-zа-яіїє]+)+$'
    ),
    CONSTRAINT chk_users_email_addr CHECK (
        email_addr ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    )
);

CREATE TABLE dbms_components (
    component_id INTEGER NOT NULL,
    component_name VARCHAR(50) NOT NULL,
    component_type_name VARCHAR(50) NOT NULL,
    description_text VARCHAR(255),
    CONSTRAINT pk_dbms_components PRIMARY KEY (component_id)
);

CREATE TABLE ar_markers (
    marker_id INTEGER NOT NULL,
    component_id INTEGER NOT NULL,
    marker_code VARCHAR(30) NOT NULL,
    pattern_file_addr VARCHAR(200) NOT NULL,
    CONSTRAINT pk_ar_markers PRIMARY KEY (marker_id),
    CONSTRAINT uk_ar_markers_code UNIQUE (marker_code),
    CONSTRAINT fk_ar_markers_components FOREIGN KEY (
        component_id
    ) REFERENCES dbms_components (component_id)
);

CREATE TABLE training_sessions (
    session_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    start_timestamp TIMESTAMP NOT NULL,
    session_status VARCHAR(20) NOT NULL,
    CONSTRAINT pk_training_sessions PRIMARY KEY (session_id),
    CONSTRAINT fk_training_sessions_users FOREIGN KEY (
        user_id
    ) REFERENCES users (user_id)
);

CREATE TABLE setup_steps (
    step_id INTEGER NOT NULL,
    session_id INTEGER NOT NULL,
    component_id INTEGER NOT NULL,
    step_seq_num INTEGER NOT NULL,
    is_completed_status INTEGER NOT NULL,
    CONSTRAINT pk_setup_steps PRIMARY KEY (step_id),
    CONSTRAINT fk_setup_steps_sessions FOREIGN KEY (
        session_id
    ) REFERENCES training_sessions (session_id),
    CONSTRAINT fk_setup_steps_components FOREIGN KEY (
        component_id
    ) REFERENCES dbms_components (component_id)
);
