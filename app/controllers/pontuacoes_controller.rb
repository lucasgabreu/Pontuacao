class PontuacoesController < ApplicationController

  def index
    Dir.foreach(Dir.pwd+"/tmp/arquivos/") { |nome|
      p nome
      if nome.index(/.csv/)
        require 'csv'
        CSV.foreach(Dir.pwd+"/tmp/arquivos/"+nome, col_sep: ';') do |linha|
          p Rank.where(codigo: linha[2])
          if Rank.where(codigo: linha[2],data: linha[0]).empty?
            nova_pontuacao = Rank.new
            nova_pontuacao.data = linha[0]
            nova_pontuacao.nome = linha[1]
            nova_pontuacao.codigo = linha[2]
            nova_pontuacao.nota = linha[3]

            total_pontos = Soma.where(codigo_user: linha[2]).ids

            if total_pontos.empty?
              soma_pontuacao = Soma.new
              soma_pontuacao.codigo_user = linha[2]
              soma_pontuacao.nome = linha[1]

              if linha[3].to_i() < 3126
                soma_pontuacao.total = linha[3]
                soma_pontuacao.save
                nova_pontuacao.save
              end
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
                end
              end
            end
          end
        end
      end
    }

  #@total =  Soma.page(params[:page]).per(10)
  @notas =  Rank.order(:codigo).page(params[:page]).per(10)

    @total = Soma.order(total: :desc)
  #  @notas = Rank.order(nota: :desc)
  end

end
