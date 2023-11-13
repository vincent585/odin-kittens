class KittensController < ApplicationController
  before_action :set_kitten, except: %i[index new create]
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:notice] = "Successfully added #{@kitten.name}"
      redirect_to @kitten
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @kitten.update(kitten_params)
      flash[:notice] = "Successfully updated #{@kitten.name}'s details"
      redirect_to @kitten
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten.destroy
    flash[:notice] = "Deleted #{@kitten.name} from records"

    redirect_to root_path
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end

  def set_kitten
    @kitten = Kitten.find(params[:id])
  end
end
