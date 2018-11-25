Rails.application.routes.draw do
 get "notas/:codigo_user/detalhe" => "pontuacoes#detalhe" , :as => 'detalhar'
 root to: "pontuacoes#index"

end
