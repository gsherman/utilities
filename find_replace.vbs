If WScript.Arguments.Count <> 3 then
  WScript.Echo "usage: find_replace.vbs filename word_to_find replace_with "
  WScript.Quit
end If

FindAndReplace WScript.Arguments.Item(0), WScript.Arguments.Item(1), WScript.Arguments.Item(2)
WScript.Echo "Operation Complete"

function FindAndReplace(strFile, strFind, strReplace)
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set objInputFile = objFSO.OpenTextFile(strFile,1)
    strTempDir = objFSO.GetSpecialFolder(2)
    Set objTempFile = objFSO.OpenTextFile(strTempDir & "\temp.txt",2,true)
    do until objInputFile.AtEndOfStream
        objTempFile.WriteLine(Replace(objInputFile.ReadLine, strFind, strReplace))
    loop
    objInputFile.Close
    Set objInputFile = Nothing
    objTempFile.Close
    Set objTempFile = Nothing
    objFSO.DeleteFile strFile, true
    objFSO.MoveFile strTempDir & "\temp.txt", strFile
    Set objFSO = Nothing
end function 