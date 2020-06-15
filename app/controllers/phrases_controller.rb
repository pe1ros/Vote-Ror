class PhrasesController < ApplicationController
  before_action :set_phrase!, only: [:edit, :update, :destroy, :show, :vote]
  before_action :check_user_before_example_deletion!, only: [:delete_example]

  def index
    @phrases = Phrase.includes(:user).paginate(:page => params[:page]) 
  end

  def new
    @phrase = Phrase.new
    @phrase.examples.build(:user_id => current_user.id)
  end

  def show
    @examples = @phrase.examples.includes(:user).paginate(:page => params[:page])
    @example = @phrase.examples.build(:user_id => current_user.id)
  end

  def update
    if @phrase.update_attributes(phrase_params)
      flash[:notice] = 'Phrase has been updated!'
      redirect_to user_path(@phrase.user)
    else
      flash[:danger] = @phrase.errors.full_messages.to_sentence
      render :edit
    end
  end

  def create
    @phrase = current_user.phrases.new(phrase_params)
    if@phrase.save
      flash[:notice] = 'Phrase has been created'
      redirect_to root_path
    else
      flash[:danger] = @phrase.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy 
    if @phrase.get_likes.size == 0 && @phrase.get_dislikes.size == 0
    @phrase.destroy
    flash[:notice] = 'Phrase has been deleted!'
    redirect_to user_path(@phrase.user)
    else
    flash[:danger] = 'Phrase ha\'t be delete! Phrase have votes' 
    redirect_to user_path(@phrase.user)
    end
  end

  def create_example
    @example = @phrase.examples.new(example_params)
    if @example.save
      flash[:notice] = 'Example has been created!'
    else
      flash[:danger] = @example.errors.full_messages.to_sentence
    end
    redirect_to phrase_path
  end

  def vote
    shared_vote(@phrase)
    if (@phrase.get_likes.size % 5) == 0 
      ApplicationMailer.item_vote(@phrase, @phrase.user.email).deliver_now
    end
    redirect_back fallback_location: root_path
  end

  private

  def phrase_params 
    params.require(:phrase).permit(:phrase, :translation, :category, examples_attributes: [ :example, :user_id, :_destroy ])
  end

  def set_phrase!
    
    @phrase = Phrase.friendly.find(params[:id])
  end

  def check_user!
    unless @phrase.is_author? current_user
      flash[:danger] = 'You don\'t author of phrase, go away!'
      redirect_to(:back)
    end
  end

end
