
-ifdef(PRODUCTION).
-define(ENVIRONMENT, production).
-else.
-define(ENVIRONMENT, test).
-endif.


-define(ApplicationDir,"catalog/application_dir").
