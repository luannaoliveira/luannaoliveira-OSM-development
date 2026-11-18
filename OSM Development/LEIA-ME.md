# OSM Development

Aplicativo que roda no seu computador e gera a página de repasse de uma demanda: explicação, fluxos dos processos, componentes, commits e código. Nada é enviado para fora da sua máquina.

## O que precisa

- **Python 3.8 ou mais novo** (https://www.python.org/downloads/). Na instalação, marque **"Add python.exe to PATH"**.
- Nenhum pacote extra.

## Como abrir

Dê dois cliques em **Abrir OSM Development.bat** (ou direto em **OSM Development.pyw**). Abre uma janela.

## Usar o logo da empresa

O aplicativo usa um logo próprio se você colocar o arquivo oficial na pasta do aplicativo:

| Arquivo | Onde aparece |
|---|---|
| `icone.png` | Na janela do aplicativo e no topo das páginas geradas |
| `icone.ico` | Na barra de título e na barra de tarefas do Windows, e no atalho da área de trabalho |

Use os arquivos dos materiais de marca oficiais da empresa e siga as regras de uso da marca. Para o `.ico`, converta o PNG (há conversores no próprio Windows/Paint ou peça ao time de design). Depois, rode **Criar atalho na area de trabalho.bat** para ter um atalho "OSM Development" com o ícone.

O ícone do arquivo `OSM Development.pyw` no Explorer é definido pelo Windows (é o do Python) e não muda; por isso o atalho.

## Transformar em executável (.exe)

Com o `.exe`, o ícone aparece também no arquivo e na barra de tarefas, e **quem for usar não precisa ter o Python instalado**.

1. Dê dois cliques em **Gerar executavel.bat**. Na primeira vez ele instala o PyInstaller (precisa de internet; se a rede usar proxy, o script mostra o comando).
2. Espere de 1 a 3 minutos. No fim, abre a pasta `dist\OSM Development`.
3. Abra **OSM Development.exe**. Para compartilhar, compacte a pasta `OSM Development` inteira (o `.exe` sozinho não funciona: ele precisa da pasta `_internal` ao lado).

Ao lado do `.exe` ficam as pastas e arquivos que você edita: `explicacoes`, `icone.ico`/`icone.png`, `config.exemplo.json` e, depois de usar, `preferencias.json`. Para trocar o ícone do próprio `.exe`, troque o `icone.ico` na pasta do aplicativo e rode o script de novo.

Se o antivírus ou a política da empresa bloquear o `.exe` (é comum com executáveis gerados localmente, sem assinatura digital), continue usando **Abrir OSM Development.bat** e o atalho, ou peça liberação ao time de TI.

## Tamanho da letra

O tamanho da letra fica no começo do `OSM Development.pyw`, na linha `TAMANHO_FONTE = 12`. Troque o número (por exemplo, 13 ou 14) e gere o executável de novo. As janelas acompanham o tamanho e, se o conteúdo não couber na tela, a janela principal ganha barra de rolagem.

## Versão, autoria e copyright

O rodapé da janela, o botão **Sobre** e as propriedades do `.exe` (botão direito → Propriedades → Detalhes) mostram nome, versão, data de criação, autoria e copyright. Tudo vem do arquivo **`sobre.py`**: edite ali (por exemplo, `VERSAO` e `DATA_VERSAO` a cada nova versão) e gere o executável de novo.

## Como gerar uma página

1. **Arquivo de diff:** clique em **Procurar…** e escolha o diff (bruto ou compactado). Se ele começar com `Demanda: <nome>`, o nome é preenchido sozinho.
2. **Nome da demanda:** confira ou digite. É o nome que aparece na página e nos arquivos.
3. **Salvar em:** escolha a pasta de saída. O aplicativo lembra a última pasta usada.
4. **Explicação:** deixe na primeira opção para usar a explicação salva da demanda, ou a automática se não houver. Ou escolha um arquivo `.md`/`.html`.
5. Clique em **Gerar página**.

Na pasta de saída ficam três arquivos:

| Arquivo | Para que serve |
|---|---|
| `OSM Development - <demanda>.html` | A página, que abre em qualquer navegador e pode ser compartilhada |
| `DEM-<demanda> - diff.txt` | O diff compactado, para a pasta da demanda no SharePoint (agente do Copilot) |
| `DEM-<demanda> - para o Copilot.txt` | Versão menor do diff, do tamanho certo para anexar no Copilot |

## Explicação completa com o Copilot

Depois de gerar, clique em **Explicação com o Copilot…**:

1. **Copiar prompt** e cole no Copilot.
2. Na mesma mensagem, anexe o arquivo `DEM-<demanda> - para o Copilot.txt` (o botão **Abrir pasta** mostra onde ele está).
3. Copie a resposta inteira do Copilot, cole no campo da janela e clique em **Aplicar resposta**.

A explicação fica salva em `explicacoes/<demanda>.md` e a página é refeita na hora. Nas próximas vezes que gerar a mesma demanda, ela é usada automaticamente. Revise os itens marcados com **A CONFIRMAR** antes de repassar.

## Revisar os itens A CONFIRMAR

Quando a explicação tem itens marcados com **A CONFIRMAR**, o app pergunta, logo depois de aplicar a resposta do Copilot, se você quer revisá-los. Também dá para abrir a revisão a qualquer momento pelo botão **Revisar A CONFIRMAR (N)…** no cartão do resultado.

Na janela de revisão aparece a lista dos itens. Para cada um, escolha:

- **Confirmar**: o item continua na página, com a etiqueta verde **Confirmado** no lugar de A CONFIRMAR.
- **Descartar**: o item sai da página (a linha da lista, a linha da tabela ou o parágrafo).
- **Manter pendente**: nada muda; o item continua como A CONFIRMAR.

Antes de confirmar, dá para corrigir o texto do item no campo à direita. **Confirmar todos** marca a lista inteira de uma vez. No fim, clique em **Aplicar decisões**: a explicação salva é atualizada e a página é refeita. Os itens que ficaram pendentes podem ser revisados depois, do mesmo jeito.

A revisão funciona com explicações em Markdown (`.md`), que é o formato salvo pelo app.

## Gerar o diff

Pelo Git Bash, na pasta do repositório (troque o nome e o primeiro commit da demanda):

```bash
{
  echo "Demanda: Nome da Demanda"
  echo
  echo "== Commits =="
  git --no-pager log --oneline <primeiro-commit>^1..HEAD
  echo
  echo "== Diff da demanda =="
  git --no-pager diff <primeiro-commit>^1 -- . ':(exclude)**/.buildNumber'
} > ../diff-bruto.txt
```

Se a branch saiu do master e só tem commits da demanda, dá para trocar `<primeiro-commit>^1` por `origin/master`. Confira antes com `git log --oneline origin/master..HEAD`.

## Explicações salvas

- Ficam na pasta `explicacoes`, uma por demanda, com o **nome da demanda no nome do arquivo** (ex.: `Upgrade Fibra X.md`).
- Para mudar um texto, edite o arquivo e gere a página de novo. Um diff novo **não** muda a explicação.
- Em Markdown:
  - cada `## Título` vira um bloco da página; a seção `## Resumo` também aparece na Visão geral;
  - `A CONFIRMAR` vira etiqueta amarela e `CORRIGIDO` vira etiqueta verde;
  - `[texto](arquivo:OI_OSM_COM_FIBRA/caminho/do/arquivo)` cria um link que abre o arquivo na aba Código.
- Arquivos que começam com `MODELO` são ignorados.
- Sem explicação salva, a página monta uma **explicação automática** a partir do diff (componentes, orquestração, status, dicionário, integrações). Ela lista o que mudou, sem interpretar as regras de negócio.

## Versão no navegador (alternativa)

**Abrir versao navegador.bat** abre a mesma ferramenta no navegador, com uma opção a mais: gerar o diff direto do repositório Git, escolhendo o primeiro commit numa lista. Precisa do Git instalado.

## IA por API (opcional, para o futuro)

Se um dia houver um endpoint de IA aprovado (Azure OpenAI ou compatível com a API da OpenAI), copie `config.exemplo.json` para `config.json`, preencha e use `"ativo": true`. O aplicativo passa a oferecer **Gerar com IA**, que escreve a explicação sozinho. Coloque a chave na variável de ambiente `REPASSE_IA_KEY`. Sem essa configuração, nada muda.

## Arquivos

| Arquivo | O que é |
|---|---|
| `Abrir OSM Development.bat` / `OSM Development.pyw` | O aplicativo de janela |
| `Criar atalho na area de trabalho.bat` | Cria um atalho com o ícone `icone.ico` |
| `Gerar executavel.bat` | Gera o `OSM Development.exe` com o ícone, na pasta `dist` |
| `sobre.py` / `gerar_versao.py` | Nome, versão, autoria e copyright do aplicativo e do `.exe` |
| `caminhos.py` | Define onde ficam os arquivos (pasta do script ou ao lado do `.exe`) |
| `Abrir versao navegador.bat` / `app.py` / `app.html` | A versão no navegador |
| `nucleo.py` | A geração, usada pela janela |
| `compactar_diff.py` | Remove do diff o ruído do Design Studio (também funciona sozinho) |
| `gerar_pagina.py` / `template.html` | Montagem da página |
| `ia.py` / `config.exemplo.json` | IA por API, opcional |

## Problemas comuns

- **O ícone não aparece na janela:** veja o arquivo `repasse.log` ao lado do aplicativo, que registra o motivo. O `icone.ico` precisa ter as imagens internas no formato BMP (o `.ico` que acompanha o aplicativo já está assim).

- **Nada acontece ao abrir:** confira se o Python está instalado com "Add python.exe to PATH". Para ver a mensagem de erro, abra um terminal nesta pasta e rode `python "OSM Development.pyw"`.
- **Aparece a explicação automática em vez da escrita:** o nome da demanda precisa ser igual ao nome do arquivo em `explicacoes` (maiúsculas e minúsculas não importam).
- **O Copilot não aceita o arquivo:** use o `para o Copilot.txt`, que é menor. Se ainda for grande, anexe o diff na pasta da demanda no SharePoint e peça a explicação ao agente.
