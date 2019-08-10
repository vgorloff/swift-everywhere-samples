default:
	@ruby -r "`pwd`/../Scripts/Builder.rb" -e "Builder.xcode()"

# See why we need this: https://stackoverflow.com/a/6273809/1418981
%:
	@ruby -r "`pwd`/../Scripts/Builder.rb" -e "Builder.xcode()" $@