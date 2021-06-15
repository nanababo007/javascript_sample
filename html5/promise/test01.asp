<html>
<head>
	<meta charset="UTF-8">
	<title>promise 테스트 - Ajax 순차 호출</title>
	<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="lib.js"></script>
</head>
<body>
<h1><a href="">Ajax 로, 서버 url 순차적으로 호출하기</a></h1>
<div>
	검색어 : <input type="text" id="txtSearchKeyword" onclick="this.select();" value="서울" /> 
	<input type="button" value=" 검색 " id="btnSearch" />
	<span style="margin-left:20px;">ex) 동대문구, 남대문구, 서대문구, 서울, </span>
</div>
<div id="result" style="margin-top:10px;">
	<div id="resultAddress" style="float:left;width:300px;min-height:500px;border:1px solid #dadada;"></div>
	<div id="resultMember" style="float:left;width:300px;min-height:500px;border:1px solid #dadada;"></div>
	<div id="resultMemberAccess" style="float:left;width:300px;min-height:500px;border:1px solid #dadada;"></div>
</div>
<div style="clear:both;height:30px;"></div>
<script>
$(function(){
	//검색버튼 클릭시 이벤트 처리.
	$('#btnSearch').click(function(e){
		var sSearchKeyword = $('#txtSearchKeyword').val();
		if ($.trim(sSearchKeyword)=='')
		{
			alert('검색어를 입력해주세요.');
			$('#txtSearchKeyword').focus();
			return false;
		}
		//검색처리
		fnSearch(sSearchKeyword);
	});
	//검색입력박스 엔터 처리.
	$('#txtSearchKeyword').keydown(function(e){
		if (e.keyCode==13)
		{
			$('#btnSearch').trigger('click');
		}
	});
	//로딩시 검색입력박스 포커스 주기.
	$('#txtSearchKeyword').focus();
});
//검색함수 (순차적으로 ajax 를 호출)
function fnSearch(searchKeyword){
	//검색결과 초기화.
	$('#resultAddress').html( '' );
	$('#resultMember').html( '' );
	$('#resultMemberAccess').html( '' );
	//주소정보 검색
	fnSearchPost({searchKeyword:searchKeyword},function(data){
		//회원정보 검색
		fnSearchMember({searchKeyword:data.list},function(data2){
			//접속정보 검색
			fnSearchMemberAccess({searchKeyword:data2.list},function(data3){
				//todo : 최종 처리할 내용.
			}); //접속정보 검색
		}); //회원정보 검색
	}); //주소정보 검색
}
//주소정보 검색.
//oParam : 파라미터 객체. {}
function fnSearchPost(oParam,callback){
	var searchParam = JSON.stringify(oParam ? oParam : {});
	fnAjaxJson('/test/test_js/promise/ajaxPostSearch.asp', {searchParam:searchParam}, function(data){
		//console.info(data);
		var result = [];
		var list = data.list;
		result.push('<center><h3>주소검색</h3></center>');
		result.push('<ul>');
		$.each(list,function(index,el){
			var sAddr = el.addr;
			var row = '';
			row += '<li>'+sAddr+'</li>';
			result.push(row);
		}); // $.each(list
		result.push('</ul>');
		$('#resultAddress').html( result.join('') );
		//콜백함수 호출.
		if (callback)
		{
			callback(data);
		}
	});
}
//회원정보 검색.
//oParam : 파라미터 객체. {}
function fnSearchMember(oParam,callback){
	var searchParam = JSON.stringify(oParam ? oParam : {});
	fnAjaxJson('/test/test_js/promise/ajaxSearchMember.asp', {searchParam:searchParam}, function(data){
		//console.info(data);
		var list = data.list;
		var result = [];
		result.push('<center><h3>회원검색</h3></center>');
		result.push('<ul>');
		$.each(list,function(index,el){
			var sAddr = el.addr;
			var memberId = el.memberId;
			var row = '';
			row += '<li>'+memberId+' ('+sAddr+')</li>';
			result.push(row);
		}); // $.each(list2
		result.push('</ul>');
		$('#resultMember').html( $('#resultMember').html() + result.join('') );
		//콜백함수 호출.
		if (callback)
		{
			callback(data);
		}
	});	// fnAjaxJson
}
//접속정보 검색.
//oParam : 파라미터 객체. {}
function fnSearchMemberAccess(oParam,callback){
	var searchParam = JSON.stringify(oParam ? oParam : {});
	//console.info(searchParam);
	fnAjaxJson('/test/test_js/promise/ajaxMemberAccessHistory.asp', {searchParam:searchParam}, function(data){
		//console.info(data);
		var result = [];
		var list = data.list;
		result.push('<center><h3>회원 접속정보 검색</h3></center>');
		result.push('<ul>');
		$.each(list,function(index,el){
			var sAddr = el.addr;
			var memberId = el.memberId;
			var accessTime = el.accessTime;
			var row = '';
			row += '<li>'+memberId+' ('+accessTime+')</li>';
			result.push(row);
		});
		result.push('</ul>');
		$('#resultMemberAccess').html( result.join('') );
		//콜백함수 호출.
		if (callback)
		{
			callback(data);
		}
	});	// fnAjaxJson
}
</script>
</body>
</html>