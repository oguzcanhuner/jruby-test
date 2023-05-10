class SignaturesController < ApplicationController
  def create
    # sign a document using PDFBox
    head :ok
  end

  def show
    render json: 'something'
  end
end
