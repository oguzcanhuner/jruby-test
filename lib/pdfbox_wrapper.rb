require 'java'
require_relative 'pdfbox-app-2.0.28.jar'

java_import 'java.io.FileOutputStream'
java_import 'java.util.Calendar'
java_import 'org.apache.pdfbox.pdmodel.PDDocument'
java_import 'org.apache.pdfbox.pdmodel.interactive.digitalsignature.PDSignature'
java_import 'org.apache.pdfbox.pdmodel.interactive.digitalsignature.SignatureOptions'
java_import 'org.apache.pdfbox.text.PDFTextStripper'

class PDFBoxWrapper
	def initialize(file_path)
		@file_path = file_path
    @file = java.io.File.new(@file_path)
	end

	def read_text
		document = PDDocument.load(@file)
		#pdf_text_stripper = PDFTextStripper.new
		#text = pdf_text_stripper.getText(document)
		document.close

    text
	end

  def apply_signature
		document = PDDocument.load(@file)
    output_file = java.io.File.new(Rails.root.join('lib', 'sample_output.pdf').to_s)
    output = FileOutputStream.new(output_file)

    signature = PDSignature.new
    signature.setFilter(PDSignature::FILTER_ADOBE_PPKLITE)
    signature.setSubFilter(PDSignature::SUBFILTER_ADBE_PKCS7_DETACHED)
    signature.setName("Example User")
    signature.setLocation("Los Angeles, CA")
    signature.setReason("Testing")
    signature.setSignDate(Calendar.getInstance());

    signatureOptions = SignatureOptions.new
    signatureOptions.setPreferredSignatureSize(SignatureOptions::DEFAULT_SIGNATURE_SIZE * 2)
    document.addSignature(signature, signatureOptions)
    document.saveIncremental(output)
  end
end
