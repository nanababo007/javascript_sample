<%
'//딕셔너리 객체 생성.
Function fnCreateDic()
	Dim oDic : Set oDic = Server.CreateObject("Scripting.Dictionary")
	Set fnCreateDic = oDic
End Function
'//json 객체에, 딕셔너리 객체 리스트 배열 설정.
Sub sbSetDicArrayToJsonObj(ByRef oJSON, ByRef arrDic)
	If IsObject(oJSON) And IsArray(arrDic) Then
		Dim i
		Dim nArrDicLen : nArrDicLen = UBound(arrDic)
		'//JSON 객체 설정.
		With oJSON.data
			'//리스트 배열 추가.
			.Add "list", oJSON.Collection()
			With oJSON.data("list")
				For i = 0 To UBound(arrDic)
					Set oRow = arrDic(i)
					.Add i, oRow
				Next
			End With
		End With
	End If
End Sub
'//객체변수 해제처리
Sub sbObjectClear(ByRef p_obj)
	Dim i, item
	If IsObject(p_obj) Then
		Set p_obj = Nothing
	ElseIf IsArray(p_obj) Then
		For i = 0 To UBound(p_obj)
			Set item = p_obj(i)
			If IsObject(item) Then
				Set item = Nothing
			End If
		Next
	End If
End Sub
'//배열에 객체항목 추가 함수.
Sub sbInsertObjectItem(ByRef p_arr, ByRef p_objItem)
	Dim newIdx : newIdx = 0
	If IsObject(p_objItem) Then
		If IsArray(p_arr) Then
			newIdx = UBound(p_arr) + 1
			ReDim Preserve p_arr(newIdx) : Set p_arr(newIdx) = p_objItem
		Else
			ReDim p_arr(newIdx) : Set p_arr(newIdx) = p_objItem
		End If
	End If
End Sub
'//ResW : Response.Write "문자열", 축약형
Sub ResW(ByRef sVal)
	Response.Write sVal
End Sub
'//ResWBR : Response.Write "문자열" & "<br />" 의 축약형
Sub ResWBR(ByRef sVal)
	ResW sVal & "<br />"
End Sub
'//ResWNL : Response.Write "문자열" & "<br />" 의 축약형
Sub ResWNL(ByRef sVal)
	ResW sVal & vbCrLf
End Sub
%>