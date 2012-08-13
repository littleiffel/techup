LESS_COMPRESSOR ?= `which lessc`
WATCHR ?= `which watchr`
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


TECHUP_LESS = ./less/main.less
TECHUP_CSS_DEST = ./css/application.css
TECHUP_MINCSS_DEST = ./css/application.min.css

#
# BUILD SIMPLE BOOTSTRAP DIRECTORY
# lessc & uglifyjs are required
#

techup:
	@echo "\n${HR}"
	@echo "Building Techup(CSS/JS)..."
	@echo "${HR}\n"
	@cp bootstrap/img/* img/
	@lessc ${TECHUP_LESS} > ${TECHUP_CSS_DEST}
	@echo "Compiling LESS for techup...               ${CHECK} Done"
	@lessc --compress ${TECHUP_LESS} > ${TECHUP_MINCSS_DEST}
	@echo "Compiling LESS Compressed for techup...    ${CHECK} Done"
	@echo "\n${HR}"
	@echo "Techup successfully built at ${DATE}."
	@echo "${HR}\n"


#
# WATCH LESS FILES
#

watch:
	echo "Watching less files..."; \
	watchr -e "watch('less/.*\.less') { system 'make techup' }"
	