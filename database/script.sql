Create table usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    email varchar(255) unique not null,
    password_hash varchar(255) not null,
    nombre_completo varchar(150) not null,
    rol varchar(20) not null check (rol IN ('estudiante', 'tutor', 'docente', 'tutor', 'admin' )),
    programa_formacion varchar(100),
    ficha INT,
    activo BOOLEAN default true,
    created_at TIMESTAMP default now()
);

CREATE TABLE materias (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre varchar(100) not null,
    trimestre int check (trimestre between 1 and 6),
    descripcion text
);

CREATE TABLE tutorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante UUID REFERENCES usuarios(id),
    id_tutor UUID REFERENCES usuarios(id),
    id_materia INT REFERENCES materias(id),
    tema VARCHAR(200) NOT NULL,
    descripcion TEXT,
    fecha_solicitada DATE NOT NULL,
    hora_solicitada TIME NOT NULL,
    modalidad VARCHAR(20) DEFAULT 'virtual' CHECK (modalidad IN ('virtual','presencial')),
    estado VARCHAR(20) DEFAULT 'solicitada' CHECK (estado IN ('solicitada','aceptada','reprogramada','confirmada','rechazada','finalizada')),
    motivo_rechazo TEXT,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE repositorio_documentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_docente UUID REFERENCES usuarios(id),
    id_materia INT REFERENCES materias(id),
    titulo VARCHAR(200) NOT NULL,
    url_archivo TEXT NOT NULL,
    tipo_archivo VARCHAR(20),
    embedding_vector TEXT, -- Aquí guardará los vectores la IA
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE notificaciones (
    id SERIAL PRIMARY KEY,
    id_usuario UUID REFERENCES usuarios(id),
    mensaje TEXT NOT NULL,
    leida BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO materias (nombre, trimestre, descripcion) VALUES
('Análisis y Desarrollo de Software', 1, 'Fundamentos de programación'),
('Base de Datos', 3, 'Modelado y SQL'),
('Programación Avanzada', 4, 'Backend con NestJS');

