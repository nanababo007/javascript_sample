<!-- #include file="incJson.asp" -->
<!-- #include file="incLib.asp" -->
<%
'// url : http://korsoft.kr/test/test_js/promise/ajaxMemberAccessHistory.asp?searchKeyword=
Dim i,j,k
Dim oJSON : Set oJSON = New aspJSON
Dim oJSONParam : Set oJSONParam = New aspJSON
Dim oList, oRow
Dim sAddr : sAddr = ""
Dim sMemberId : sMemberId = ""
Dim sAccessTime : sAccessTime = ""
Dim searchParam : searchParam = request("searchParam")
Dim searchKeyword

'//파라미터 읽기
'//searchParam = "{""searchKeyword"":[{""addr"":""서울시 남대문구"",""memberId"":""user01""},{""addr"":""서울시 서대문구"",""memberId"":""user02""},{""addr"":""서울시 관악구"",""memberId"":""user03""},{""addr"":""서울시 금천구"",""memberId"":""user04""},{""addr"":""서울시 동대문구"",""memberId"":""user05""},{""addr"":""서울시 동대문구 홍길동"",""memberId"":""user06""},{""addr"":""서울시 서대문구 홍제동"",""memberId"":""user07""}]}"
If Trim(searchParam) <> "" Then
	oJSONParam.loadJSON(searchParam)
End If

'//데이터 설정
oJSON.data.Add "title", "member access history list"

sMemberId = "user01"
sAddr = "서울시 남대문구"
sAccessTime = "2021-03-02 13:12:03"
If fnCheckSearchCond(sMemberId) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	oRow("memberId") = sMemberId
	oRow("accessTime") = sAccessTime
	sbInsertObjectItem oList, oRow
End If

sMemberId = "user02"
sAddr = "서울시 서대문구"
sAccessTime = "2021-03-01 11:22:21"
If fnCheckSearchCond(sMemberId) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	oRow("memberId") = sMemberId
	oRow("accessTime") = sAccessTime
	sbInsertObjectItem oList, oRow
End If

sMemberId = "user03"
sAddr = "서울시 관악구"
sAccessTime = "2021-03-02 02:09:31"
If fnCheckSearchCond(sMemberId) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	oRow("memberId") = sMemberId
	oRow("accessTime") = sAccessTime
	sbInsertObjectItem oList, oRow
End If

sMemberId = "user04"
sAddr = "서울시 금천구"
sAccessTime = "2021-06-12 22:05:42"
If fnCheckSearchCond(sMemberId) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	oRow("memberId") = sMemberId
	oRow("accessTime") = sAccessTime
	sbInsertObjectItem oList, oRow
End If

sMemberId = "user05"
sAddr = "서울시 동대문구"
sAccessTime = "2021-05-01 15:02:11"
If fnCheckSearchCond(sMemberId) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	oRow("memberId") = sMemberId
	oRow("accessTime") = sAccessTime
	sbInsertObjectItem oList, oRow
End If

sMemberId = "user06"
sAddr = "서울시 동대문구 홍길동"
sAccessTime = "2021-01-02 11:02:11"
If fnCheckSearchCond(sMemberId) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	oRow("memberId") = sMemberId
	oRow("accessTime") = sAccessTime
	sbInsertObjectItem oList, oRow
End If

sMemberId = "user07"
sAddr = "서울시 서대문구 홍제동"
sAccessTime = "2021-03-12 13:12:01"
If fnCheckSearchCond(sMemberId) Then
	Set oRow = fnCreateDic()
	oRow("addr") = sAddr
	oRow("memberId") = sMemberId
	oRow("accessTime") = sAccessTime
	sbInsertObjectItem oList, oRow
End If

'//JSON 객체 데이터 배열 설정.
sbSetDicArrayToJsonObj oJSON, oList

'//결과값 출력.
Response.Write oJSON.JSONoutput()

'//############## 함수정의 ##############
'//파라미터로 넘어온 검색조건에, 맞는 부분이 있으면 true, 없으면 false.
Function fnCheckSearchCond(ByVal sVal)
	Dim result : result = False
	Dim sSearch : sSearch = ""
	If Trim(sVal) = "" Then
		fnCheckSearchCond = result
		Exit Function
	End If
	If Trim(searchParam) <> "" Then
		For Each rowKey In oJSONParam.data("searchKeyword")
			Set row = oJSONParam.data("searchKeyword").item(rowKey)
			sSearch = row.item("memberId")		'//###### 각 적용부분마다, memberId 이 부분 변경필요 ######
			'//체크비교
			If InStr(1, sVal, sSearch) > 0 Then
				result = True
				Exit For
			End If
		Next
	End If
	fnCheckSearchCond = result
End Function
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