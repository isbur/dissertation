for %%f in (*.xlsx) do (
	echo %%f
	copy /y NUL "%%~nf.docx"
)
pause

