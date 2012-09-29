RVM_GEMSET=hostfile
RVM_RUBIES=1.9.2@$(RVM_GEMSET),1.9.3@$(RVM_GEMSET)
RVM_OPTS=$(RVM_RUBIES) --create
RVM_EXEC=rvm $(RVM_OPTS) exec

default:	test

bundle:
	$(RVM_EXEC) bundle install --quiet

test: bundle
	$(RVM_EXEC) bundle exec rake
