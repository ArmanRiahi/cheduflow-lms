CREATE TABLE users
(
    id            BIGSERIAL PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    email         VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name    VARCHAR(100) NOT NULL,
    last_name     VARCHAR(100) NOT NULL,
    enabled       BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles
(
    id   BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE user_roles
(
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,

    PRIMARY KEY (user_id, role_id),

    CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,

    CONSTRAINT fk_user_roles_role FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE CASCADE
);

CREATE TABLE courses
(
    id          BIGSERIAL PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    slug        VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
    status      VARCHAR(30)  NOT NULL DEFAULT 'DRAFT',
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE course_instructors
(
    course_id     BIGINT NOT NULL,
    instructor_id BIGINT NOT NULL,

    PRIMARY KEY (course_id, instructor_id),

    CONSTRAINT fk_course_instructors_course FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE,

    CONSTRAINT fk_course_instructors_instructor FOREIGN KEY (instructor_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE enrollments
(
    id           BIGSERIAL PRIMARY KEY,
    student_id   BIGINT      NOT NULL,
    course_id    BIGINT      NOT NULL,
    status       VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
    enrolled_at  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,

    CONSTRAINT uq_enrollment_student_course UNIQUE (student_id, course_id),

    CONSTRAINT fk_enrollments_student FOREIGN KEY (student_id) REFERENCES users (id) ON DELETE CASCADE,

    CONSTRAINT fk_enrollments_course FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE
);

CREATE TABLE lessons
(
    id          BIGSERIAL PRIMARY KEY,
    course_id   BIGINT       NOT NULL,
    title       VARCHAR(200) NOT NULL,
    description TEXT,
    content     TEXT,
    position    INTEGER      NOT NULL,

    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_lessons_course FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE,

    CONSTRAINT uq_lesson_course_position UNIQUE (course_id, position)
);