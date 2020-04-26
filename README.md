# O que é este projeto?

Este App com o com o intuito de captar doações para projetos vinculados ao [COVIDZERO](https://covidzero.com.br). 

## Stack utilizada 
 * Ruby 2.5.1
 * Rails versão 6 
 * Banco de dados Postgres

## Como rodar o app
- `bundle install`
- `yarn install`
- `rake db:create`
- `rake db:migrate`

## Modulo de admin
Foi criado um modulo de ADMIN para que possam ser cadastrados novos projetos a serem apresentados na Home do APP. 


## Modelagem do projeto
- name: Nome do projeto
- photo: Imagem do projeto
- banner: Imagem de fundo do projeto
- goal: Valor total a ser captado
- video_url: URL do youtube para embedar no site
- quota_value: Valor minimo da doação
- slug: nome curto para referenciar projeto
- about: Texto sobre o Projeto.  
