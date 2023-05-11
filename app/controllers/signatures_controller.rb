class SignaturesController < ApplicationController
  def create
    # sign a document using PDFBox
    head :ok
  end

  def show
    pdfbox = PDFBoxWrapper.new(Rails.root.join('lib', 'sample.pdf').to_s)

    render json: pdfbox.read_text
  end
end
