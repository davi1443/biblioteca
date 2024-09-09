create database biblioteca;
use biblioteca;

create table Autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

create table Livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(300) NOT NULL,
    autor_id INT,
    preco DECIMAL(10, 2),
    FOREIGN KEY (autor_id) 
    REFERENCES Autores(id)
);

create table Emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT,
    aluno_id INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (livro_id) 
    REFERENCES Livros(id)
);

SELECT L.titulo
FROM Livros L
LEFT JOIN Emprestimos E ON L.id = E.livro_id AND E.data_devolucao IS NULL
WHERE E.livro_id IS NULL;

SELECT DISTINCT A.nacionalidade
FROM Autores A
JOIN Livros L ON A.id = L.autor_id
JOIN Emprestimos E ON L.id = E.livro_id
WHERE E.data_devolucao IS NULL;

SELECT L.titulo
FROM Livros L
JOIN Emprestimos E ON L.id = E.livro_id
WHERE E.aluno_id = 101;

SELECT AVG(L.preco) AS preco_medio
FROM Livros L
JOIN Emprestimos E ON L.id = E.livro_id
WHERE E.data_devolucao IS NULL;

SELECT L.titulo
FROM Livros L
JOIN Emprestimos E ON L.id = E.livro_id
WHERE E.data_emprestimo BETWEEN '2024-09-01' AND '2024-09-10';

SELECT A.nome, L.preco
FROM Autores A
JOIN Livros L ON A.id = L.autor_id
JOIN Emprestimos E ON L.id = E.livro_id
WHERE E.data_devolucao IS NULL
ORDER BY L.preco DESC
LIMIT 1;

SELECT COUNT(*) AS total_emprestimos
FROM Emprestimos
WHERE data_devolucao IS NOT NULL;

SELECT aluno_id, COUNT(*) AS total_emprestimos
FROM Emprestimos
GROUP BY aluno_id;

SELECT L.titulo, E.data_devolucao
FROM Livros L
JOIN Emprestimos E ON L.id = E.livro_id
WHERE E.data_devolucao IS NOT NULL;

SELECT AVG(DATEDIFF(E.data_devolucao, E.data_emprestimo)) AS media_tempo_emprestimo
FROM Emprestimos E
WHERE E.data_devolucao IS NOT NULL;

SELECT A.nome
FROM Autores A
JOIN Livros L ON A.id = L.autor_id
JOIN Emprestimos E ON L.id = E.livro_id
WHERE E.data_devolucao IS NULL
GROUP BY A.id
HAVING COUNT(L.id) > 1;

SELECT SUM(L.preco) AS total_arrecadado
FROM Livros L
JOIN Emprestimos E ON L.id = E.livro_id
WHERE E.data_devolucao IS NOT NULL;
