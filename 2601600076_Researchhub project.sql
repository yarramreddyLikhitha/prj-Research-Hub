-- =========================================================
-- RESEARCHHUB - PostgreSQL Database
-- =========================================================

-- Run this after creating a database named: researchhub


-- =========================================================
-- 1. CREATE TABLES
-- =========================================================

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    affiliation VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE publications (
    publication_id SERIAL PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    abstract TEXT,
    publication_date DATE,
    journal VARCHAR(200),
    doi VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE publication_authors (
    publication_id INT NOT NULL,
    author_id INT NOT NULL,
    author_order INT CHECK (author_order > 0),

    PRIMARY KEY (publication_id, author_id),

    FOREIGN KEY (publication_id)
        REFERENCES publications(publication_id)
        ON DELETE CASCADE,

    FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
        ON DELETE CASCADE
);


CREATE TABLE documents (
    document_id SERIAL PRIMARY KEY,
    publication_id INT NOT NULL,
    document_type VARCHAR(50) NOT NULL
        CHECK (document_type IN ('PDF', 'THESIS', 'ARTICLE', 'REPORT')),
    file_path TEXT,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (publication_id)
        REFERENCES publications(publication_id)
        ON DELETE CASCADE
);


CREATE TABLE citations (
    citation_id SERIAL PRIMARY KEY,
    citing_document_id INT NOT NULL,
    cited_document_id INT NOT NULL,
    cited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (citing_document_id)
        REFERENCES documents(document_id)
        ON DELETE CASCADE,

    FOREIGN KEY (cited_document_id)
        REFERENCES documents(document_id)
        ON DELETE CASCADE,

    CHECK (citing_document_id <> cited_document_id),

    UNIQUE (citing_document_id, cited_document_id)
);


-- =========================================================
-- 2. INSERT AUTHORS
-- =========================================================

INSERT INTO authors (name, email, affiliation) VALUES
('Aarav Sharma', 'aarav.sharma@researchhub.edu', 'LPU Research Center'),
('Ananya Reddy', 'ananya.reddy@researchhub.edu', 'ANU Computer Science Department'),
('Rahul Verma', 'rahul.verma@researchhub.edu', 'IIT Research Lab'),
('Priya Nair', 'priya.nair@researchhub.edu', 'Tech Research Institute'),
('Kiran Kumar', 'kiran.kumar@researchhub.edu', 'LPU AI Lab'),
('Sneha Rao', 'sneha.rao@researchhub.edu', 'Data Science Institute'),
('Arjun Mehta', 'arjun.mehta@researchhub.edu', 'Cybersecurity Research Lab'),
('Meera Iyer', 'meera.iyer@researchhub.edu', 'Cloud Computing Lab'),
('Vikram Singh', 'vikram.singh@researchhub.edu', 'NLP Research Group'),
('Neha Patel', 'neha.patel@researchhub.edu', 'Computer Vision Lab');


-- =========================================================
-- 3. INSERT PUBLICATIONS
-- =========================================================

INSERT INTO publications
(title, abstract, publication_date, journal, doi)
VALUES
(
    'Artificial Intelligence in Healthcare',
    'A study of artificial intelligence applications in modern healthcare systems.',
    '2022-03-15',
    'International AI Journal',
    '10.1000/aihealth001'
),
(
    'Machine Learning Based Disease Prediction',
    'Machine learning techniques for predicting common diseases.',
    '2022-07-20',
    'Machine Learning Review',
    '10.1000/mlhealth002'
),
(
    'Cybersecurity Threat Detection Using AI',
    'An AI based approach for detecting cybersecurity threats.',
    '2023-01-12',
    'Cybersecurity Research Journal',
    '10.1000/cyber003'
),
(
    'Cloud Computing Resource Optimization',
    'Optimization of cloud computing resources using intelligent algorithms.',
    '2023-05-18',
    'Cloud Systems Journal',
    '10.1000/cloud004'
),
(
    'Natural Language Processing for Text Classification',
    'NLP techniques for automatic classification of large text datasets.',
    '2023-09-10',
    'NLP Research Journal',
    '10.1000/nlp005'
),
(
    'Computer Vision Based Object Detection',
    'A computer vision system for detecting objects in images.',
    '2024-02-25',
    'Computer Vision Journal',
    '10.1000/cv006'
),
(
    'Big Data Analytics for Research',
    'Methods for analysing large research datasets using big data technologies.',
    '2024-06-14',
    'Data Analytics Journal',
    '10.1000/data007'
),
(
    'Blockchain Based Academic Records',
    'Using blockchain technology to secure academic records.',
    '2024-10-05',
    'Blockchain Technology Review',
    '10.1000/block008'
),
(
    'Deep Learning for Image Recognition',
    'Deep learning approaches for image recognition applications.',
    '2025-03-22',
    'Deep Learning Journal',
    '10.1000/deep009'
),
(
    'AI Driven Research Analytics Dashboard',
    'An intelligent dashboard for analysing research publications and citations.',
    '2026-01-30',
    'Research Analytics Journal',
    '10.1000/research010'
);


-- =========================================================
-- 4. CONNECT AUTHORS WITH PUBLICATIONS
-- Many-to-Many Relationship
-- =========================================================

INSERT INTO publication_authors
(publication_id, author_id, author_order)
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 2, 1),
(2, 3, 2),
(3, 3, 1),
(3, 7, 2),
(4, 4, 1),
(4, 8, 2),
(5, 5, 1),
(5, 9, 2),
(6, 6, 1),
(6, 10, 2),
(7, 1, 1),
(7, 6, 2),
(8, 4, 1),
(8, 7, 2),
(9, 5, 1),
(9, 10, 2),
(10, 1, 1),
(10, 3, 2),
(10, 5, 3);


-- =========================================================
-- 5. INSERT DOCUMENTS
-- =========================================================

INSERT INTO documents
(publication_id, document_type, file_path)
VALUES
(1, 'PDF', '/researchhub/papers/ai_healthcare.pdf'),
(2, 'ARTICLE', '/researchhub/papers/disease_prediction.pdf'),
(3, 'PDF', '/researchhub/papers/cybersecurity_ai.pdf'),
(4, 'REPORT', '/researchhub/reports/cloud_optimization.pdf'),
(5, 'PDF', '/researchhub/papers/nlp_classification.pdf'),
(6, 'ARTICLE', '/researchhub/papers/object_detection.pdf'),
(7, 'PDF', '/researchhub/papers/big_data.pdf'),
(8, 'THESIS', '/researchhub/thesis/blockchain_records.pdf'),
(9, 'PDF', '/researchhub/papers/deep_learning.pdf'),
(10, 'REPORT', '/researchhub/reports/research_dashboard.pdf');


-- =========================================================
-- 6. INSERT CITATIONS
-- =========================================================

INSERT INTO citations
(citing_document_id, cited_document_id)
VALUES
(2, 1),
(3, 1),
(3, 2),
(4, 2),
(4, 3),
(5, 1),
(5, 2),
(6, 5),
(7, 1),
(7, 4),
(8, 3),
(8, 7),
(9, 6),
(9, 1),
(10, 7),
(10, 9),
(10, 3);


-- =========================================================
-- 7. VERIFY THE DATA
-- =========================================================

SELECT * FROM authors;

SELECT * FROM publications;

SELECT * FROM publication_authors;

SELECT * FROM documents;

SELECT * FROM citations;


-- =========================================================
-- 8. USEFUL JOIN QUERY
-- Show publications with their authors
-- =========================================================

SELECT
    p.publication_id,
    p.title,
    a.name AS author,
    pa.author_order
FROM publications p
JOIN publication_authors pa
    ON p.publication_id = pa.publication_id
JOIN authors a
    ON pa.author_id = a.author_id
ORDER BY p.publication_id, pa.author_order;


-- =========================================================
-- 9. SHOW CITATIONS
-- =========================================================

SELECT
    c.citation_id,
    p1.title AS citing_publication,
    p2.title AS cited_publication
FROM citations c
JOIN documents d1
    ON c.citing_document_id = d1.document_id
JOIN documents d2
    ON c.cited_document_id = d2.document_id
JOIN publications p1
    ON d1.publication_id = p1.publication_id
JOIN publications p2
    ON d2.publication_id = p2.publication_id;

EXPLAIN ANALYZE
SELECT *
FROM publications
WHERE publication_date >= '2024-01-01';	
CREATE INDEX idx_publications_date
ON publications(publication_date);

CREATE INDEX idx_publication_authors_author
ON publication_authors(author_id);

CREATE INDEX idx_documents_publication
ON documents(publication_id);

CREATE INDEX idx_citations_citing
ON citations(citing_document_id);

CREATE INDEX idx_citations_cited
ON citations(cited_document_id);

EXPLAIN ANALYZE
SELECT *
FROM publications
WHERE publication_date >= '2024-01-01';
EXPLAIN ANALYZE
SELECT *
FROM publications
WHERE publication_date >= '2024-01-01';

