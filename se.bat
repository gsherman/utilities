@echo off

:usage
IF "%1%" == "-?" (
	@echo:
	echo se.bat :: Wrapper batch file for SchemaEditor
	echo    -i {file}  Copies a .schemaeditor file to the {pwd}, and sets the inputFilePath to {file}
	echo    -gd             Copies a .schemaeditor file to the {pwd}
	echo    -input {file}   Sets the inputFilePath in the .SchemaEditor file to {file}
	echo    -gd             Copies a .schemaeditor file to the {pwd}
	echo    -g              Generate an example SchemaEditor file
  echo    -e              Exports the schema to the file defined in exportFilePath
  echo    -p              Previews the changes
  echo    -a              Apply the changes
	@echo:
  GOTO:EOF
)

IF "%1%" == "-i" (
	cat c:\bin\dovetail.SchemaEditor | sed s/"<inputFilePath>schemascript.xml<\/inputFilePath>"/"<inputFilePath>%2%<\/inputFilePath>"/ > Default.SchemaEditor 
  GOTO:EOF
)

IF "%1%" == "-gd" (
 	copy c:\bin\dovetail.SchemaEditor Default.SchemaEditor
  GOTO:EOF
)

IF "%1%" == "-input" (  
	cat Default.SchemaEditor | sed s/"<inputFilePath>.*<\/inputFilePath>"/"<inputFilePath>%2%<\/inputFilePath>"/ > temp.SchemaEditor 	
	rm Default.SchemaEditor
	mv temp.SchemaEditor Default.SchemaEditor
  GOTO:EOF
)




IF EXIST SchemaDifferenceReport.txt del SchemaDifferenceReport.txt
	"C:\apps\Dovetail Software\SchemaEditor\SchemaEditor.exe" %*
GOTO DONE

 
IF "%1%" == "" (
 "C:\apps\Dovetail Software\SchemaEditor\SchemaEditor.exe" %*
 GOTO DONE
)


:DONE
IF EXIST SchemaDifferenceReport.txt cat SchemaDifferenceReport.txt
