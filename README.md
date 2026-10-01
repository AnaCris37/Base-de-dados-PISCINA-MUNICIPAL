
# 🏊 Base de Dados – Piscina

Este projeto é uma base de dados em **SQL** para gerir uma piscina, com o registo de utentes, aulas, professores e inscrições. Foi desenvolvido em grupo na UC *Desenvolver uma base de dados com linguagem SQL*, do curso de Técnico de Desenvolvimento de Software. O objetivo foi organizar a informação em tabelas relacionadas e praticar consultas.

![Diagrama da base de dados](image.png)

> **Nota importante:** os dados usados neste projeto são fictícios e servem apenas para aprendizagem.

## Tecnologias

| Tecnologia | Versão | Utilização |
|:----------:|:------:|-----------:|
| MySQL | 8.0 | Base de dados |
| MySQL Workbench | 8.0 | Criar tabelas e diagramas |
| Visual Studio Code | 1.9x | Editar ficheiros |
| Git e GitHub | 2.4x | Controlo de versões |

## Estrutura da base de dados

- **utente**: dados das pessoas inscritas
- **professor**: dados dos professores
- **aula**: tipo de aula, horário e professor
- **inscricao**: liga os utentes às aulas

### Relações entre tabelas

Cada aula tem um professor, e cada utente pode estar inscrito em várias aulas através da tabela **inscricao**.

## Instalação

1. Instalar o MySQL e o MySQL Workbench.
2. Clonar este repositório.
3. Abrir o ficheiro `piscina.sql` no MySQL Workbench.
4. Executar o script para criar a base de dados e as tabelas.

### Exemplo de código SQL

```sql
CREATE TABLE utente (
    id_utente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    telefone VARCHAR(15)
);

SELECT u.nome, a.tipo
FROM utente u
JOIN inscricao i ON u.id_utente = i.id_utente
JOIN aula a ON i.id_aula = a.id_aula;
```

## Tarefas

- [x] Desenhar o diagrama de relações entre tabelas
- [x] Criar as tabelas em SQL
- [x] Inserir dados de teste
- [ ] Criar consultas para relatórios
- [ ] Adicionar controlo de pagamentos

## Autores

- **Ana Cristina Marques** – [Perfil no GitHub](https://github.com/AnaCris37)
- **Hugo Teixeira** -  [Perfil no GitHub] (https://github.com/Hugoteixeira566)
- **Jean Xavier** [Perfil no GitHub](https://github.com/jeanxavier2026)

Trabalho de grupo da UC02830 – *Desenvolver uma base de dados com linguagem SQL*.

Documentação do MySQL: [w3schools.com](https://www.w3schools.com/mysql/)
