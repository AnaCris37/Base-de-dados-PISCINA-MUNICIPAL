# Apresentação do Projeto – Piscina Municipal

📄 Relatório completo: [relatorio-piscina.pdf](docs/UC02830_Relatorio_Piscina Municipal_Grupo 5.pdf)


## Estrutura da base de dados

A base de dados tem **16 tabelas**:

- **Pessoas:** `utente`, `monitor`, `funcionario`, `cargo`
- **Aulas:** `servico`, `aula`, `inscricao_aula`, `lista_espera`, `avaliacao`
- **Espaço e material:** `pista`, `equipamento`, `manutencao_pista`, `utilizacao_livre`
- **Gestão:** `pagamento`, `contrato_trabalho`, `ficha_medica`

### Principais relações

- Um monitor dá várias aulas; cada aula tem um só monitor (1:N).
- Cada aula pertence a um serviço e decorre numa pista (1:N).
- Utentes e aulas têm uma relação de muitos-para-muitos, resolvida com a tabela `inscricao_aula`, que também regista as presenças.

## Consultas SQL

| Nº | Tipo | Pergunta |
|:--:|:-----|:---------|
| 1 | Critérios (uma tabela) | Utentes com 65 ou mais anos |
| 2 | Critérios (N tabelas) | Aulas na pista de competição |
| 3 | Group By (Distinct) | Utentes distintos por serviço |
| 4 | Group By (critérios) | Monitores com mais de 2 aulas |
| 5 | NOT IN | Utentes sem inscrições |
| 6 | Subquery | Aulas com capacidade acima da média |
| 7 | Máximo/Mínimo | Mensalidade mais cara e mais barata |
| 8 | UNION | Contactos de utentes e monitores |
| 9 | IF | Aulas lotadas ou com vagas |
| 10 | Subquery + Cálculo | Taxa de assiduidade por utente |
| 11 | Extra | Aulas sem utentes inscritos |
| 12 | Extra | Monitor com mais aulas |
| 13 | Extra | Lista de espera em aulas lotadas |
| 14 | Extra | Utentes com pagamentos em dívida |

### Exemplo – Consulta 9 (IF)

```sql
SELECT a.id_aula, s.nome_servico, a.capacidade_max,
       COUNT(ia.id_inscricao) AS total_inscritos,
       IF(COUNT(ia.id_inscricao) >= a.capacidade_max, 'Lotada', 'Com vagas') AS estado
FROM aula a
JOIN servico s ON s.id_servico = a.id_servico
LEFT JOIN inscricao_aula ia ON ia.id_aula = a.id_aula
GROUP BY a.id_aula, s.nome_servico, a.capacidade_max
ORDER BY a.id_aula;
```

[⬅ Voltar ao README](../README.md)