# Nome da Demanda

Explicação escrita a partir do diff. Itens marcados com A CONFIRMAR são interpretações que o diff não deixa explícitas. Itens marcados com CONFIRMADO foram confirmados por quem gerou o repasse.

## Resumo
2 a 4 linhas, em linguagem de negócio: o que a demanda resolve e o que passa a acontecer com a ordem.

## Entrada da ordem
Bullets curtos sobre como a ordem passa a ser reconhecida e roteada:
- **Sequência de orquestração** ([OrchestrationSequence](arquivo:<caminho>)): quais order_type/sub_type vão para qual fulfillment mode, e como era antes.
- **Campos novos**: campos adicionados ao dicionário de dados, à regra de reconhecimento e às tasks de entrada.
- Outras mudanças na entrada, se houver.

> **Impacto:** uma frase sobre o que muda para ordens que já existiam (por exemplo, sub_types que deixam de usar um modo antigo).

## Plano de orquestração
Uma frase dizendo em qual product spec e fulfillment mode está o plano. Depois, uma lista numerada com as etapas NA ORDEM em que acontecem, uma etapa por item, sempre neste formato:
1. **Nome da etapa em português**: NomeDaFunction → NomeDoProcesso · condição ou o que a etapa espera
Etapas que rodam em paralelo podem ficar no mesmo item, separadas por " | ".

## Processos novos
Para cada processo novo, um subtítulo com o nome de exibição e um parágrafo curto:
### Nome de exibição do processo
[NomeDoProcesso](arquivo:<caminho>): o que ele faz, a sequência principal de tasks, as decisões (regras) e para onde vão os retornos (sucesso, pendência, reagendamento, erro técnico).

## Cancelamento
Como o cancelamento funciona na demanda, inclusive plugins Java e ordens de reversão, se houver. Se não houver nada de cancelamento no diff, omita esta seção.

## Integrações
| Sistema | Serviço | Usado para |
|---|---|---|

## Outras alterações
Bullets curtos com o que mudou em componentes existentes (tasks, functions, dicionário de dados, build).

## Pontos de atenção
Bullets com riscos, possíveis erros no código e mudanças de comportamento. Comece com A CONFIRMAR o que for interpretação.
