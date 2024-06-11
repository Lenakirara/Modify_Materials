# Boas vindas ao repositório de Modificação de Materiais
Projeto de atividade final do nível avançado [ABAP 4 Girls](https://abapforgirls.tech/)

<div align="center">
  
![image](https://github.com/Lenakirara/Modify_Materials/assets/45247383/8ade5ef7-fb8e-467f-8bbc-2d66d89e1cc9)


</div>

## Habilidades desenvolvidas:
1. Design e Modelagem de Banco de Dados
    - Criação de tabelas personalizadas no banco de dados.
    - Definição de campos chave e estrutura de dados.
2. Programação ABAP
    - Desenvolvimento de relatórios e programas em ABAP.
    - Utilização de funções de leitura e manipulação de dados de tabelas SAP (MARA, MAKT).
    - Implementação de lógica de validação de dados e tratamento de erros.
    - Uso de Call Transaction para atualização de registros via transação MM02.
3. Manipulação de Arquivos Excel
    - Leitura de dados de arquivos Excel para processamento em massa.
    - Exportação de dados para arquivos Excel.
4. Gerenciamento de Logs
    - Implementação de registro de logs de operações (criação/modificação de materiais).
    - Criação de relatórios de logs e exibição em ALV (ABAP List Viewer).
5. Interação com Usuário
    - Desenvolvimento de interfaces de usuário com campos de seleção.
    - Implementação de mensagens de status e feedback de execução.
6. Utilização de ALV OO (Object-Oriented)
    - Exibição de relatórios utilizando ALV OO para melhor apresentação e interação com dados.
7. Debugging e Testes
    - Teste e depuração de programas para garantir a correta execução e atualização de dados.
    - Verificação e correção de erros durante a execução de transações.
8. Gerenciamento de Transações SAP
    - Uso de SHDB para gravação de scripts de transações.
    - Automatização de processos transacionais em SAP.

## Objetivo do projeto
Desenvolver uma solução em ABAP para modificação em massa de materiais no SAP, incluindo a criação de uma tabela de logs para armazenar detalhes das alterações. O programa deve validar a existência dos materiais, realizar atualizações via transação MM02, e registrar logs de sucesso ou erro. Além disso, deve permitir a exportação e exibição de relatórios de log, facilitando o controle e monitoramento das modificações realizadas.

## Especificações do projeto
### 1. Tabela de log
   
| CAMPO | DESCRIÇÃO |
|------ | ----------|
| MATNR | Número do material (campo chave) |
| MAKTX | Descrição do material |
| DATA | Data de modificação |
| USER | Usuário de modifdicaçao |

![image](https://github.com/Lenakirara/Modify_Materials/assets/45247383/89659747-906c-4962-88ef-cee22249bb04)

### 2. Programa 1 - Programa de modificação do material
Desenvolver um report que faça modificação de materiais em massa. O programa irá receber um arquivo excel com as colunas MATNR e MATKL.
Selecionar o registro na tabela mara e verificar se o registro existe. Caso o material não exista, armazenar em uma tabela interna para exibição de log de erro. Se o material existir, fazer o call da transaction da transação MM02. Para fazer o call transaction, será utilizado os dados gravados no SHDB.
Se der erro no call transaction, incluir o material na tabela interna de log de erro. Senão der erro, o registro deverá ser gravado na nova tabela de log, onde todos os campos da tabela, deverão ser atualizados. Para isso, é necessário buscar os dados da tabela makt para atualizar o campo de descrição do material.

![image](https://github.com/Lenakirara/Modify_Materials/assets/45247383/9f288117-cc68-495c-b4f1-8e8405684a9f)


### 3. Programa 2 - Programa de log de modificação do material
Criar um programa de log de modificação, onde na tela contenha 
1. Dois radiobuttons com as opções:
    - **Exportar relatório**: o programa deverá selecionar os dados da tabela de log conforme material e data informados na tela de seleção e após isso, gravar em um arquivo excel a ser salvo na máquina do usuário. O arquivo excel deverá conter todos os campos da tabela de log.
    - **Exibir ALV**: o programa deverá exibir um relatório ALV, utilizando o ALV OO, com os dados da tabela de log, conforme material e data informados na tela de seleção. O relatório deverá conter todos os campos da tabela de log.

2. Na tela deverá ter os campos:
    - **MATERIAL**
    - **DATA**

![image](https://github.com/Lenakirara/Modify_Materials/assets/45247383/0bbb93ea-3275-4cf3-919c-a4668e9b0123)






