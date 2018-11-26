# Processamento de Pontuação

 O processamento das pontuações é realizado através da leitura dos arquivos .CSV contidos na pasta “arquivos” na raiz do projeto e armazenando os dados na tabela Ranks e na tabela Somas.
A tabela Ranks contem todas as pontuações inseridas, já a tabela Somas contem a soma de todas as pontuações por código de usuário.

A pasta "arquivos" presente na raiz do projeto, contem dois arquivos como exemplo (dados.csv e teste.csv).

A tela principal contem a lista de todos os usuarios com as somas das pontuações obtidas, dispostas em ordem decrescente.
### Versões

* Ruby: 2.3.3
* Rails: 5.1.6

## Considerações

Foi considerado que os arquivos com as pontuações, poderiam ter o número de pontos de qualquer valor, mas que a soma destes pontos teriam que ser no máximo 3126. Todas as pontuações são armazenadas no banco e podem ser vistas através do botão detalhar, que mostra as pontuações obtidas por cada usuário. 
