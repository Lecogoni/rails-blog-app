class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new #cet ligne permet de ne pas affichier le message d'erreur lorsque l'on charge pour la première fois la page new, prevent contre errors messages == nill
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
       @article = Article.new(params.require(:article).permit(:title, :description)) #article is the top level key de notre form puis on spécifies les keys que l'on veut permettre :title et :description. C'est une meusre de sécu qui nous force a spécifier ce qui doit être importés
       #render plain: @article.inspect
       if @article.save #a la finn de cette action rails ne sais pas ou aller, donc il est bon de le rediriger vers par ex. la page du nouvel article
        # si successully saved on utilise un flash helper pour avertir avec un msg
        flash[:notice] = "Article saved"
        redirect_to article_path(@article) # rails récupere seul l'id de @article // peut remplacer article_path(@article) >> @article
       else
        render 'new' # if save ne marche pas on render a nouveau la view de new
       end
    end

    def update
        @article = Article.find(params[:id]) # en 1 pour update il faut pointer vers l'article a updater
        if @article.update(params.require(:article).permit(:title, :description)) #ici on update
            flash[:notice] = "Article was updated succesfully"
            redirect_to @article
        else
            render 'new' 
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

end