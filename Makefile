include core.mk

doc:
	make -C document/$(DOC_TYPE) $(DOC_TYPE).pdf

doc-clean:
	make -C document/$(DOC_TYPE) clean

doc-pdfclean:
	make -C document/$(DOC_TYPE) pdfclean

fpga:
	make -C hardware/fpga/$(FPGA_FAMILY) run


.PHONY: doc doc-clean doc-pdfclean
