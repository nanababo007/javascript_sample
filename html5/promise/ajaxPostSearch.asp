<!-- #include file="incJson.asp" -->
<!-- #include file="incLib.asp" -->
<%
'// url : http://korsoft.kr/test/test_js/promise/ajaxPostSearch.asp?searchKeyword=
Dim i,j,k
Dim oJSON : Set oJSON = New aspJSON
Dim oJSONParam : Set oJSONParam = New aspJSON
Dim oList, oRow
Dim sAddr : sAddr = ""
Dim searchParam : searchParam = request("searchParam")
Dim searchKeyword : searchKeyword = ""

'//파라미터 읽기
'//searchParam: {"searchKeyword":"서울"}
If Trim(searchParam) <> "" Then
	oJSONParam.loadJSON(searchParam)
	searchKeyword = oJSONParam.data("searchKeyword")
End If

'//데이터 설정
oJSON.data.Add "title", "address list"

sAddr = "서울시 남대문구"
If searchKeyword = "" Or (searchKeyword <> "" And InStr(1, sAddr, searchKeyword) > 0) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	sbInsertObjectItem oList, oRow
End If

sAddr = "서울시 서대문구"
If searchKeyword = "" Or (searchKeyword <> "" And InStr(1, sAddr, searchKeyword) > 0) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	sbInsertObjectItem oList, oRow
End If

sAddr = "서울시 관악구"
If searchKeyword = "" Or (searchKeyword <> "" And InStr(1, sAddr, searchKeyword) > 0) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	sbInsertObjectItem oList, oRow
End If

sAddr = "서울시 금천구"
If searchKeyword = "" Or (searchKeyword <> "" And InStr(1, sAddr, searchKeyword) > 0) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	sbInsertObjectItem oList, oRow
End If

sAddr = "서울시 동대문구"
If searchKeyword = "" Or (searchKeyword <> "" And InStr(1, sAddr, searchKeyword) > 0) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	sbInsertObjectItem oList, oRow
End If

'//JSON 객체 데이터 배열 설정.
sbSetDicArrayToJsonObj oJSON, oList

'//결과값 출력.
Response.Write oJSON.JSONoutput()

'//중간 실행 중단.
Sub ResEnd()
	sbRelease
	Response.End
End Sub
'//리소스 해제 처리.
sbRelease
Sub sbRelease()
	'//리스트 리소스 해제.
	sbObjectClear oList
	sbObjectClear oJSONParam
	sbObjectClear oJSON
End Sub
%>