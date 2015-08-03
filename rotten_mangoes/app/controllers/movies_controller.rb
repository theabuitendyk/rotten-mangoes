class MoviesController < ApplicationController

  def home
    @opening_soon = Movie.where('release_date > ?', Date.today).order(release_date: :asc).limit(4)

    @best_of_monthly = Movie.where(release_date: (Date.today - 1.month)..Date.today).sort_by{|movie| movie.review_average}.reverse!
    @best_of_monthly = @best_of_monthly[0,4]
    # TODO Why not limit(2)?

    @best_of_yearly = Movie.where(release_date: (Date.today - 1.month)..Date.today).sort_by{|movie| movie.review_average}.reverse!
    @best_of_yearly = @best_of_yearly[0,4]
    
    @best_of_forever = Movie.all.sort_by{|movie| movie.review_average}.reverse!
    @best_of_forever = @best_of_forever[0,4]
  end

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @show = true
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
      )
  end
  
end
