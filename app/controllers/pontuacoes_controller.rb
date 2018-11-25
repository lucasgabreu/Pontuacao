class PontuacoesController < ApplicationController

  def index
    Dir.foreach(Dir.pwd+"/tmp/arquivos/") { |nome|
      if nome.index(/.csv/)
        require 'csv'
        CSV.foreach(Dir.pwd+"/tmp/arquivos/"+nome, col_sep: ';') do |linha|
          if Rank.where(codigo: linha[2],data: linha[0]).empty?
            nova_pontuacao = Rank.new
            nova_pontuacao.data = linha[0]
            nova_pontuacao.nome = linha[1]
            nova_pontuacao.codigo = linha[2]
            nova_pontuacao.nota = linha[3]

            total_pontos = Soma.where(codigo_user: linha[2]).ids
#verifica se o registro é novo na tabela de somas.
            if total_pontos.empty?
              soma_pontuacao = Soma.new
              soma_pontuacao.codigo_user = linha[2]
              soma_pontuacao.nome = linha[1]
#verifica a nota se a mesma for menor que 3126 salvo na tablea total o valor, se for maior salvo na tabela total com o valor de 3126.
              if linha[3].to_i() < 3126
                soma_pontuacao.total = linha[3]
                soma_pontuacao.save
                nova_pontuacao.save
              else
                soma_pontuacao.total = 3126
                soma_pontuacao.save
                nova_pontuacao.save
              end
#Se o registro não é novo eu procuro ele na tabela soma apra somar o valor da nota ao valor ja obtido.
            else
              temp=Soma.find(total_pontos[0])
              if temp.total+linha[3].to_i() < 3126
                temp.total = temp.total+linha[3].to_i()
                temp.save
                nova_pontuacao.save
              else
                if temp.total != 3126
                  temp.total=3126
                  nova_pontuacao.save
                  temp.save
                else
                  nova_pontuacao.save
                end

              end

            end

          end

        end

      end
    }
#ordenação pela maior nota
    @total = Soma.order(total: :desc).page(params[:page]).per(10)
  end

  def detalhe
    codigo = params[:codigo_user]
    @notas=Rank.where(codigo: codigo).page(params[:page]).per(10)
    render :detalhar

  end

end
