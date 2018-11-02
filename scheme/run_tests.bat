@color 02
call r5rs test\assert-test.scm
@if ERRORLEVEL 1 goto :fail

call r5rs test\cell-test.scm
@if ERRORLEVEL 1 goto :fail

call r5rs test\grid-test.scm
@if ERRORLEVEL 1 goto :fail

call r5rs test\grid-manager-test.scm
@if ERRORLEVEL 1 goto :fail

@echo test suite OK
@goto :stop

:fail
@color 04
@echo FAILED: !errorlevel!

:stop
