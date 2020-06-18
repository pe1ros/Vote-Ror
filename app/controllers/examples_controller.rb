class ExamplesController < ApplicationController
  before_action :set_phrase!, only: [:create, :destroy, :vote]
  before_action :set_example!, only: [:destroy, :vote]

    def create
      @example = @phrase.examples.new(example_params)
      if @example.save
        flash[:notice] = 'Example has been created!'
      else
        flash[:danger] = @example.errors.full_messages.to_sentence
      end
      redirect_to phrase_path(@phrase)
    end
  
    def destroy
      if @phrase.examples.friendly.find(params[:id]).get_likes.size == 0 && @phrase.examples.friendly.find(params[:id]).get_dislikes.size == 0
      @phrase.examples.friendly.find(params[:id]).destroy
      flash[:notice] = 'Example has been deleted!'
      redirect_to phrase_path(@phrase)
      else
      flash[:danger] = 'Example have\'t be delete! Example have votes'
      redirect_to phrase_path(@phrase)
      end
      
    end
    
    def vote
      shared_vote(@example) 
      if (@example.get_likes.size % 5) == 0 
        ApplicationMailer.item_vote(@example, @example.user.email).deliver_now
      end
      redirect_back fallback_location: root_path
    end

    private
  
    def example_params
      params.require(:example).permit(:example, :user_id)
    end
  
    def set_phrase!
      @phrase = Phrase.friendly.find(params[:phrase_id])
    end
    def set_example!   
       @example = @phrase.examples.friendly.find(params[:phrase_id]) 
    end
  
end
